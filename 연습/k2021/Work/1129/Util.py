import json
import numpy as np


class Util:
    def __init__(self):

        self.fillNa = "^"

        self.maxNumBenefit = 10
        self.w = 120

        self.v = 1/(1+0.0025)

        self.clearSymbols()

        # Load Json 
        with open('./Qx.json', 'r') as j:
            self.Qx_dict  = json.load(j)        
        with open('./Coverage.json', 'r') as j:
            self.Coverage_dict  = json.load(j)       
        with open('./Comb.json', 'r') as j:
            self.Comb_dict  = json.load(j)       


    def setArgs(self, x : int = None, sex : int = None, n : int = None, m : int = None, injure : int = None, driver : int = None, AMT : int = None, coverageKey : str = None):
        if x!=None:self.x = x 
        if sex!=None:self.sex = sex 
        if n!=None:self.n = n 
        if m!=None:self.m = m 
        if injure!=None:self.injure = injure 
        if driver!=None:self.driver = driver 
        if AMT!=None:self.AMT = AMT 
        if coverageKey!=None:
            self.coverageKey = coverageKey 
            self.covInfo = self.Coverage_dict[self.coverageKey]


    def parsingCoverageInfo(self):

        self.NumBenefit = self.covInfo['NumBenefit']    
        # 탈퇴
        self.ExitCode = self.covInfo['ExitCode']
        self.ExitType = self.covInfo['ExitType']
        self.NonCov =  np.array(self.covInfo['NonCov'])
        
        # 급부
        self.BenefitCode = self.covInfo['BenefitCode']
        self.BenefitType = self.covInfo['BenefitType']
        self.PayRate =  np.array(self.covInfo['PayRate'])
        self.ReduceRate =  np.array(self.covInfo['ReduceRate'])
        self.ReducePeriod =  np.array(self.covInfo['ReducePeriod'])

        # 납입면제
        self.GrantCode = self.covInfo['GrantCode']
        self.GrantType = self.covInfo['GrantType']
        self.InvalidPeriod =  self.covInfo['InvalidPeriod']

    def clearSymbols(self):
        self.lx = np.zeros((self.maxNumBenefit+1, self.w))  # 유지자
        self.lxPrime = np.zeros(self.w)     # 납입자수
        self.qx_exit = np.zeros((self.maxNumBenefit+1, self.w))     # 탈퇴율
        self.qx_benefit = np.zeros((self.maxNumBenefit, self.w))    # 급부율
        self.qx_grant = np.zeros(self.w)    # 납면율
        self.Cx = np.zeros((self.maxNumBenefit, self.w))
        self.Mx = np.zeros((self.maxNumBenefit, self.w))
        self.SUMx = np.zeros(self.w)
        self.Dx = np.zeros((2, self.w))                          # Dx, D'x
        self.Nx = np.zeros((2, self.w))                          # Nx, N'x   

    def getQx(self, riskKey : str, riskType : str = None):
        if riskType == self.fillNa:
            return self.Qx_dict[riskKey][str(self.sex)]
        # 상해급수
        elif riskType == "I":
            return self.Qx_dict[riskKey+f"_{self.injure}"][str(self.sex)]
        #  운전자급수
        elif riskType == "D":
            return self.Qx_dict[riskKey+f"_{self.driver}"][str(self.sex)]
        elif riskType == "C":
            return self.getCombQx(riskKey)



    def QxMapping(self, riskKey : str, riskType : str = None):
        # 탈퇴율 mapping
        for i in range(self.NumBenefit+1):
            self.qx_exit[i] = self.getQx(self.ExitCode[i], self.ExitType[i])
        # 급부율 mapping
        for i in range(self.NumBenefit):
            self.qx_benefit[i] = self.getQx(self.BenefitCode[i], self.BenefitType[i])
        # 납면율 mapping
        self.qx_grant = self.getQx(self.GrantCode, self.GrantType)


    def calcSymbols(self):
        proj = self.n+1
        # lx, l'x
        self.lx[:, self.x] = 100000
        self.lxPrime[self.x] = 100000
        for i in range(self.x, self.x+proj-1):
            if i == 0:
                self.lx[:, i+1] = self.lx[:, i] * (1-self.qx_exit[:, i]*(1-self.NonCov/12))
                self.lxPrime[i+1] = self.lxPrime[i] *(1-self.qx_grant[i] * (1-self.InvalidPeriod/12))
            else:
                self.lx[:, i+1] = self.lx[:, i] * (1-self.qx_exit[:, i])
                self.lxPrime[i+1] = self.lxPrime[i] *(1-self.qx_grant[i])

        # Dx, D'x
        self.Dx[:, self.x:] = self.lx[:, self.x:] * self.v ** (np.arange(self.w) - self.x)

        # Cx, Mx, SUMx
        for i in range(self.NumBenefit):
            pRate, rRate, rPeriod = self.PayRate[i], self.ReduceRate[i], self.ReducePeriod[i]
            self.Cx[i] = self.lx[i+1]*self.qx_benefit[i] * self.v ** (np.arange(self.w) - self.x)
            self.Mx[i] = self.CalcInverseCumSum(self.Cx[i])
            for t in range(proj):
                if t<self.ReducePeriod[i]:
                    self.SUMx[self.x+t] += pRate((1-rRate)*(self.Mx[self.x+t] - self.Mx[self.x+rPeriod]) + \
                        (self.Mx[self.x+rPeriod] - self.Mx[self.x+self.n]))
                else:
                    self.SUMx[self.x+t] += pRate*(self.Mx[self.x+t] - self.Mx[self.x+self.n])


    def getCombQx(self):
        """나중에 허자"""
        pass

    @staticmethod
    def CalcInverseCumSum(array : np.array):
        return np.array([sum(array[t:]) for t in range(len(array))])





