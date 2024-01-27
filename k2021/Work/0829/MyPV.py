import pandas as pd
import numpy as np

class MyPV:
    def __init__(self, excel_file : str):       
        # 시트 읽기
        self.sht_rate = pd.read_excel(excel_file, sheet_name='위험률', header=1).fillna(0.)
        self.sht_benefit = pd.read_excel(excel_file, sheet_name='급부지급', header=1).fillna(0.)
        self.sht_exit = pd.read_excel(excel_file, sheet_name='급부탈퇴', header=1).fillna(0.)
        self.sht_grant = pd.read_excel(excel_file, sheet_name='납입면제', header=1).fillna(0.)

    def setArgs(self, key : str, x : int, sex : int, n : int, m : int, mPrime : int = 12):

        self.key = key        # Coverage&key1&key2&key3
        key1 = key.split("_")[1]

        self.x = x      # 가입연령
        self.sex = sex      # 성별
        self.w = 108 if sex == 0 else 110    # 한계연령
        self.m = m      # 납입기간
        self.mPrime = mPrime     # 납입주기
        self.n = n      # 보험기간     
        self.proj = self.n+1      # projection 기간



        if key1 == '1':
            self.alpha1 = 4/1000 
            self.alpha2 = 0.05*min(self.n, 20)
            self.S = 0.4
        else:
            self.alpha1 = 2.8/1000*min(n, 10)/10
            self.alpha2 = 0.035*min(self.n, 10)
            self.S = 0.04

        self.i = 0.0225  # 이율 2.25%
        self.v = 1/(1+self.i)
        self.l0 = 100000
        self.beta1 = 1/1000
        self.beta5 = 0
        self.beta2 = 0.065 - self.beta5
        self.betaPrime = self.beta1/2
        self.AMT = 100000   # 십만원

    def getQx(self, rKey : str, sex : int = None, w=120) -> np.array:
        """
        Input
            - rKey : 위험률키
            - sex : 성별 (1 : 남 / 2 :여)
        Output
            - qx 
        """
        if sex==None:sex=self.sex
        df = self.sht_rate.copy(deep=True)
        df = df.loc[df['Key'] == rKey]
        if sex==1:  # 남자
            df = df[['x', 'Male']]
        else:
            df = df[['x', 'Female']]
        try:
            qx = np.zeros(w)
            for row in df.values:
                age, rate = row
                qx[int(age)] = rate
            return qx[self.x:]
        except:
            raise ValueError(f"{rKey} 위험률 가져오는데 실패")

    def main(self):
        # Join
        df_exit = self.sht_exit.loc[self.sht_exit['Key'] == self.key,\
            ['BenefitNum', 'RiskCode']].copy(deep=True)  
        df_benefit = self.sht_benefit.loc[self.sht_benefit['Key'] == self.key, \
            ['BenefitNum', 'DefryRate', 'RiskCode', 'ReducRate', 'ReducPeriod',\
                'NonCov']].copy(deep=True)
        df_join = pd.merge(left=df_exit, right=df_benefit, how='outer', on='BenefitNum',\
            suffixes=['_exit','_benefit']).fillna(np.nan).sort_values(by='BenefitNum')
        df_grant = self.sht_grant.loc[self.sht_grant['Key'] == self.key, \
            ['RiskCode', 'InvalidPeriod']].copy(deep=True)

        lx_dict = {}
        dx_dict = {}
        Cx_dict = {}
        Mx_dict = {}
        SUMx_dict = {}

        for row in df_join.values:            
            bNum, rCode_exit, dRate, rCode_benefit, rRate, rPeriod, nCov = row
            if bNum==0:
                pass
            else:
                #---------------- lx 계산 ----------------#
                lx = [self.l0]
                # 급부탈퇴율
                if rCode_exit == np.nan:qx_exit = np.zeros(120)
                else:qx_exit = self.getQx(rCode_exit)

                # 급부별 lx 계산
                for t in range(self.proj-1):
                    l = lx[t]
                    l_next = l*(1-qx_exit[t]*(1-nCov/12))   # 부담보
                    lx.append(l_next)

                #---------------- 급부 계산 ----------------#

                # 급부지급률
                if rCode_benefit == np.nan:qx_benefit = np.zeros(120)
                else:qx_benefit = self.getQx(rCode_exit)
                # dx
                dx = [lx[t]*qx_benefit[t] for t in range(self.proj)]
                # Cx
                Cx = [dx[t]*self.v**(t+0.5) for t in range(self.proj)]
                # Mx
                Mx = [sum(Cx[t:]) for t in range(self.proj)]
                # SUMx
                SUMx = []
                for t in range(self.proj):
                    if t<rPeriod:
                        sum_x = dRate*((1-rRate)*(Mx[t] - Mx[rPeriod]) + (Mx[rPeriod] - Mx[self.n]))
                    else:
                        sum_x = dRate*(Mx[t] - Mx[self.n])
                    SUMx.append(sum_x)
   
                lx_dict[bNum] = lx
                dx_dict[bNum] = dx
                Cx_dict[bNum] = Cx
                Mx_dict[bNum] = Mx
                SUMx_dict[bNum] = SUMx

        # NSP
        NSP = [0]*self.proj
        for key in SUMx_dict.keys():
            SUMx = SUMx_dict[key]
            for t in range(self.proj):NSP[t] += SUMx[t]
            
            
        #---------------- 전체 유지자 ----------------#
        lx0 = [self.l0]*(self.proj)
        for row in df_exit.values:
            bNum, rCode_exit = row
            qx_exit = self.getQx(rCode_exit)
            if bNum==0:
                # 급부별 lx 계산
                lx0 = [self.l0]
                for t in range(self.proj-1):
                    l = lx0[t]
                    l_next = l*(1-qx_exit[t])   # <-------- 혹시 부담보 있으면 적용해주기
                    lx0.append(l_next)
        Dx = [lx0[t]*self.v**t for t in range(self.proj)]
        Nx = [sum(Dx[t:]) for t in range(self.proj)]
        lx_dict[0] = lx0
        
        #---------------- 납입 ----------------#

        # 납입자
        if df_grant.shape[0] == 0:  # 납면사유 x
            lxPrime = lx0
        elif df_grant.shape[0] == 1:
            lxPrime = [self.l0]
            rCode_grant, iPeriod = df_grant.values[0]
            qx_grant = self.getQx(rCode_grant)
            for t in range(self.proj):
                lPrime = lxPrime[t]
                if t==0:
                    lPrime*=1-qx_grant[t]*(1-iPeriod/12)    # iPeriod : 면책기간
                else:
                    lPrime*=1-qx_grant[t]
                lxPrime.append(lPrime)
        lx_dict[99] = lxPrime
        DxPrime = [lxPrime[t]*self.v**t for t in range(self.proj)]
        NxPrime = [sum(DxPrime[t:]) for t in range(self.proj)]
        # 월납 납입기수
        Nstar = 12*((NxPrime[0] - NxPrime[self.m]) - 11/24*(DxPrime[0]-DxPrime[self.m]))
        
        #---------------- 보험료 ----------------#
        # 연납순보험료
        NP = NSP[0]/ (NxPrime[0] - NxPrime[self.m])
        # 월납순보험료
        NP_monthly = NSP[0]/Nstar
        # 기준연납순보험료
        NP_std = NSP[0]/(NxPrime[0]-NxPrime[min(self.n, 20)])   #<--------- 기준 납입기간 20인지 확인
        # 연납베타순보험료 
        NP_beta = NP + self.betaPrime*(Nx[0]-Nx[self.n]-(NxPrime[0]-NxPrime[self.m]))/(NxPrime[0]-NxPrime[self.m])
        # 월납영업보험료
        G = (NP_monthly + (self.alpha1 + self.alpha2*NP_std) * Dx[0]/Nstar +\
            self.beta1/12 + self.betaPrime*(Nx[0]-Nx[self.n]-Nstar/12)/Nstar) \
                /(1-self.beta2-self.beta5)

        #---------------- 준비금 ----------------#
        tVx = []
        for t in range(self.proj):
            if t==0:
                V=0
            else:
                V = (NSP[t] + self.betaPrime*(Nx[t] - Nx[self.n]-\
                    (NxPrime[t]-NxPrime[self.m])) - NP_beta *(NxPrime[t]-NxPrime[self.m]))/Dx[t]
            tVx.append(V)
        
        #---------------- 환급금 ----------------#
        # 해약공제액
        alpha_apply = self.alpha1 + self.alpha2 * NP_std
        alpha_std =NP_std*0.05*min(self.n, 20)+10/1000*self.S
        alpha = min(alpha_apply, alpha_std)
        # 환급금
        tWx = []
        for t in range(self.proj):
            m = min(self.m, 7)
            W = max(0, tVx[t] - max(0, (1-t/m)*alpha))
            tWx.append(W)      
        
        return {"기수" : {'lx' : lx_dict, \
            "Cx" : Cx_dict, \
                "SUMx" : SUMx_dict, \
                    "NSP" : NSP, \
                        "N*" : Nstar},
            "보험료" : {"연납순보험료" : round(NP*self.AMT), \
            "기준연납순보험료" : round(NP_std*self.AMT), \
                "연납베타순보험료" : round(NP_beta*self.AMT), \
                    "월납영업보험료" : round(G*self.AMT)}, \
                        "준비금" : [round(V*self.AMT) for V in tVx], \
                            "환급금" : [round(W*self.AMT) for W in tWx]}