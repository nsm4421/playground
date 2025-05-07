import pandas as pd
import numpy as np

class MyPV:
    def __init__(self, excel_file : str):       
        # Read sheets from excel file 
        self.sht_rate = pd.read_excel(excel_file, sheet_name='위험률').fillna(0.)
        self.sht_benefit = pd.read_excel(excel_file, sheet_name='급부지급').fillna(0.)
        self.sht_exit = pd.read_excel(excel_file, sheet_name='급부탈퇴').fillna(0.)
        self.sht_grant = pd.read_excel(excel_file, sheet_name='납입면제').fillna(0.)

        self.i = 0.0225  # 이율 2.25%
        self.v = 1/(1+self.i)
        self.l0 = 100000
        self.beta1 = 1/1000
        self.beta5 = 0
        self.beta2 = 0.065 - self.beta5
        self.betaPrime = self.beta1/2
        self.AMT = 100000

    def setArgs(self, coverage : str, x : int, sex : int, n : int, m : int, \
        mPrime : int = 12, renew : int = 1):

        self.coverage = coverage        # 담보코드
        self.x = x      # 가입연령
        self.sex = sex      # 성별
        self.w = 108 if sex == 0 else 110    # 한계연령
        self.m = m      # 납입기간
        self.mPrime = mPrime     # 납입주기
        self.n = n      # 보험기간     
        self.renew = renew   # 1 : 최초계약 /  2 : 갱신계약

        self.alpha1 = 4/1000 if renew ==1 else 2.8/1000*min(n, 10)/10
        self.alpha2 = 0.05*min(n, 20) if renew==1 else 0.035*min(n, 10)
        self.S = 0.4 if self.renew == 1 else 0.04


    def getQx(self, rCode : str):   
        """
        Input 
        - rCode : 위험률코드
        - age : 나이 (int, list, tuple)
        Ouput
        - 위험률 (x~w세)        
        """     
        df = self.sht_rate[['위험률코드', '가입연령', '성별', '위험률']].copy(deep = True)
        condition = (df['위험률코드'] == rCode) & (df['성별'] == self.sex) & \
            (df['가입연령'] >= self.x) & (df['가입연령'] <= self.w)
        df = df.loc[condition]['위험률']
        return df.values

    def main(self):
        df_benefit = self.sht_benefit.loc[self.sht_benefit['담보코드'] == self.coverage]\
            [['급부번호','지급률','급부위험률코드','감액기간','감액률','부담보기간']].copy(deep = True)
        df_exit = self.sht_exit.loc[self.sht_exit['담보코드'] == self.coverage]\
            [['급부번호', '급부탈퇴위험률']].copy(deep = True)
        df_grant = self.sht_grant.loc[self.sht_grant['담보코드'] == self.coverage]\
            [['납입면제위험률', '면책기간']].copy(deep=True)

        # 전체 유지자수
        lx0 = [self.l0]
        if 0 == df_exit['급부번호'].values[0]:
            rCode_exit = df_exit['급부탈퇴위험률'].values[0]
            qx_exit = self.getQx(rCode_exit)
        else:
            qx_exit = [0.]*(self.w-self.x)
        for t in range(self.w-self.x-1):
            l = lx0[t]
            l *= 1-qx_exit[t]
            lx0.append(l)
        Dx = [lx0[t]*self.v**t for t in range(self.w-self.x)]
        Nx = [sum(Dx[t:]) for t in range(self.w-self.x)]


        NSP = [0.]*(self.w-self.x)
        # NSP
        for bNum in df_benefit['급부번호'].values:
            # 지급률, 급부지급위험률, 감액기간, 감액률, 부담보기간
            _, dRate, rCode_benefit, rPeriod, rRate, nCov = \
                df_benefit.loc[df_benefit['급부번호'] == bNum].values[0]
            # 급부율 (qx_benefit)
            qx_benefit = self.getQx(rCode_benefit)           
            # 탈퇴율 (qx_exit)
            rCode_exit = df_exit.loc[df_exit['급부번호'] == bNum]['급부탈퇴위험률'].values
            if len(rCode_exit) == 0:
                qx_exit = [0.]*(self.w-self.x)    
            else:
                rCode_exit = rCode_exit[0]
                qx_exit = self.getQx(rCode_exit)        
            # lx
            lx = [self.l0]
            for t in range(self.w-self.x-1):
                l = lx[t]
                # 부담보
                if t==0:    
                    l *= 1-qx_exit[t]*(1-nCov/12)
                else:
                    l *= 1-qx_exit[t]
                lx.append(l)
            # dx
            dx = [lx[t]*qx_benefit[t] for t in range(self.w-self.x)]
            # Cx
            Cx = [dx[t]*self.v**(t+0.5) for t in range(self.w-self.x)]
            for t in range(rPeriod):
                Cx[t] *= 1-rRate    # rPeriod : 감액기간 / rRate : 감액률
            # Mx
            Mx = [sum(Cx[t:]) for t in range(self.w-self.x)]
            for t in range(self.w-self.x):
                NSP[t] +=dRate*(Mx[t] - Mx[self.n])

                
            

        # 납입계수
        if df_grant.shape[0] == 0:  # 납면사유 x
            lxPrime = lx0
        elif df_grant.shape[0] == 1:
            lxPrime = [self.l0]
            rCode_grant, iPeriod = df_grant.values[0]
            qx_grant = self.getQx(rCode_grant)
            for t in range(self.w-self.x-1):
                lPrime = lxPrime[t]
                if t==0:lPrime*=1-qx_grant[t]*(1-iPeriod/12)    # iPeriod : 면책기간
                else:lPrime*=1-qx_grant[t]
                lxPrime.append(lPrime)
        else:raise ValueError("납입면제 사유가 2개이상 존재")
        DxPrime = [lxPrime[t]*self.v**t for t in range(self.w-self.x)]
        NxPrime = [sum(DxPrime[t:]) for t in range(self.w-self.x)]
        Nstar = self.mPrime*((NxPrime[0] - NxPrime[self.m]) - \
            (self.mPrime-1)/(2*self.mPrime)*(DxPrime[0]-DxPrime[self.m]))
        Nstar12 = 12*((NxPrime[0] - NxPrime[self.m]) - \
            11/24*(DxPrime[0]-DxPrime[self.m]))


 
        # 순보험료
        P_net = NSP[0] / Nstar
        # 월납순보험료    
        P_net_12 = NSP[0] / Nstar12
        # 월납영업보험료
        G = (P_net_12 + self.alpha1 + Dx[0]/Nstar12 + self.beta1/12 +\
            self.betaPrime*(Nx[0]-Nx[self.n]-Nstar12/12)/Nstar12)/ \
                (1-self.alpha2*12*Dx[0]/Nstar12 - self.beta2-self.beta5)
        # beta 보험료
        P_beta = NSP[0]/(NxPrime[0]-NxPrime[self.m]) + \
            self.betaPrime*(Nx[0]-Nx[self.n]-(NxPrime[0]-NxPrime[self.m]))/(NxPrime[0]-NxPrime[self.m])
        # 기준연납순보험료
        P_std = NSP[0]/(NxPrime[0]-NxPrime[min(self.n, 20)])

        # 책임준비금
        tVx = []
        for t in range(self.w-self.x):
            if t==0:
                V = 0
            else:
                V = (NSP[t] + self.betaPrime*(Nx[t] - Nx[self.n]-\
                    (NxPrime[t]-NxPrime[self.m])) - P_beta *(NxPrime[t]-NxPrime[self.m]))/Dx[t]
            tVx.append(V)
        # 해약환급금
        alpha_apply = self.alpha1 + self.alpha2 * P_std
        alpha_std =P_std*0.05*min(self.n, 20)+10/1000*self.S
        alpha = min(alpha_apply, alpha_std)

    
        tWx = []
        for t in range(self.w-self.x):
            m = min(self.m, 7)
            W = max(0, tVx[t] - max(0, (1-t/m)*alpha))
            tWx.append(W)        
        return {'월납영업보험료' : round(G*self.AMT), \
                    '연납베타순보험료' : round(P_beta*self.AMT), \
                    '준비금' : [round(self.AMT*V) for V in tVx][:self.n], \
                        '환급금' : [round(self.AMT*W) for W in tWx][:self.n]}
