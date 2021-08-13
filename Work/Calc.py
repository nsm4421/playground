from Util import Util
import numpy as np
import pandas as pd

class Calc:
    def __init__(self, util : Util, i : float = 0.025, l0 : int = 100000):
     
        self.util = util
        self.i = i
        self.v = 1/(1+self.i)
        self.l0 = l0

        # 사업비
        self.alpha1 = 2/1000
        self.alpha2 = 2 
        self.beta1 = 0.6/1000
        self.beta5 = 0.025
        self.betaPrime = self.beta1/2
        self.beta2 = 0.15

    def Setting(self, cCode, x, sex, n, m, mPrime, AMT):
        # Input
        self.x = x      # 가입연령        
        self.n = n      # 보험기간
        self.m = m      # 납입기간
        self.mPrime = mPrime        # 납입주기
        self.sex = sex  # 성별     
        self.AMT = AMT
        self.w = 108 if self.sex == 1 else 110      # 한계연령
        self.cCode = cCode  # 담보코드 

        self.exitInfo = self.util.exitInfo(self.cCode)
        self.benefitInfo = self.util.benefitInfo(self.cCode)
        self.grantInfo = self.util.grantInfo(self.cCode)

        # 데이터 오류 확인
        assert self.x + self.n <= self.w
        assert mPrime in [1, 2, 4, 12]
        assert self.m<=self.n

    def getRate(self, rCode, age = None):
        if age == None:age=(self.x, self.w)
        return self.util.getRate(rCode, self.sex, age)
    
    def Calc_lx(self):
        lx_dict = {}

        ## 전체 유지자수
        if self.exitInfo == None:
            nonCov = 0
            lx = [self.l0]*(self.w-self.x)
        else:
            if 0 == self.exitInfo[0, 0]:
                _, rCode, nonCov = self.exitInfo[0, :]
                qx = self.getRate(rCode)
                lx = [self.l0]
                for t in range(self.w-self.x-1):
                    if t==0:l=lx[t]*(1-qx[t]*nonCov)
                    else:l=lx[t]*(1-qx[t])
                    lx.append(l)
            else:
                lx = [self.l0]*(self.w-self.x)
        lx_dict['l0'] = lx  

        # 급부별 유지자수
        if self.exitInfo == None:
            for row in self.benefitInfo:
                bNum, _, _, _, _ = row
                lx_dict[f'l{bNum}'] =  lx_dict['l0']
        else:
            for row in self.benefitInfo:
                bNum, _, _, _, _ = row
                if bNum not in self.exitInfo[:, 0]:
                    lx_dict[f'l{bNum}'] =  lx_dict['l0']

        ## 납입자수        
        if self.grantInfo==None:
            lxPrime = lx_dict['l0']
        else:
            lxPrime=[self.l0]
            for row in self.grantInfo:
                rCode, iPeriod = row
                qx = self.util.getRate(rCode, self.sex, (self.x, self.w))
                for t in range(self.w-self.x):
                    lPrime = lxPrime[t]
                    if t==0:
                        lPrime *= 1-(1-iPeriod/12)*qx[t]
                    else:
                        lPrime *= 1-qx[t]
                    lxPrime.append(lPrime)
        lx_dict['l99'] = lxPrime 
        self.lx_dict = lx_dict

    def Calc_NSP(self):
        self.NSP = 0
        for row in self.benefitInfo:
            bNum, rCode, dRate, rPeriod, rRate = row 
            lx = self.lx_dict[f'l{bNum}']
            qx = self.getRate(rCode)
            Cx = [lx[t]*qx[t]*self.v**(t+0.5) for t in range(self.w-self.x)]       
            for t in range(rPeriod):
                Cx[t] = Cx[t]*(1-rRate)
            self.NSP += dRate*sum(Cx[:self.n])

    def Calc_Nx(self, mPrime = 12):
        lxPrime = self.lx_dict['l99']
        DxPrime = [lxPrime[t]*self.v**t for t in range(self.w-self.x)]
        NxPrime = [sum(DxPrime[t:]) for t in range(self.w-self.x)]
        return mPrime*(NxPrime[0]-NxPrime[self.m] - \
            (mPrime-1)/(2*mPrime)*(DxPrime[0]-DxPrime[self.m]))

    def main(self, cCode, x, sex, n, m, mPrime, AMT):
        self.Setting(cCode, x, sex, n, m, mPrime, AMT)
        self.Calc_lx()
        self.Calc_NSP()
        Nstar = self.Calc_Nx(12)
        NP = self.NSP/Nstar
        print(round(NP*AMT))
