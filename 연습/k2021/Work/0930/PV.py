import numpy as np
import pandas as pd
from tqdm import tqdm

class MyPV:
    def __init__(self, excel_file : str = './INFO.xlsx', fillNa = 0):
        # 엑셀파일 읽기
        sht_rate = pd.read_excel(excel_file, sheet_name="위험률", header=2)
        sht_code = pd.read_excel(excel_file, sheet_name="코드", header=2)
        sht_comb = pd.read_excel(excel_file, sheet_name="결합위험률", header=2)
        sht_G = pd.read_excel(excel_file, sheet_name="영업보험료")
        sht_V = pd.read_excel(excel_file, sheet_name="준비금")
        
        # 전처리
        self.fillNa = 0        
        self.sht_rate = sht_rate[['RiskKey', 'RiskCode', 'PassYear', 'x', 'Male', 'Female']].fillna(self.fillNa)
        self.sht_code = sht_code[['RiskKind','KEY', 'BenefitNum', 'ExitCode', 'NonCov',\
            'BenefitCode', 'DefryRate', 'ReducRate', 'ReducPeriod', \
                'GrantCode', 'InvalidPeriod']].fillna(self.fillNa)    
        self.sht_comb = sht_comb[['CombRiskKey', 'Operation', 'NumRiskKey'] \
            + [f"RiskKey({i})" for i in range(1, 8+1)] + [f"Period({i})" for i in range(1, 8+1)]].fillna(self.fillNa)
        self.sht_G = sht_G
        self.sht_V = sht_V

        # 공시이율
        self.i = 0.0225
        self.v = 1/(1+self.i)

        # 계약 시점에 가입자 수
        self.l0 = 100000



    # 전역변수 세팅
    def setArgs(self, KEY : str, sex : int, x : int,\
        n : int, m : int, mPrime : int, AMT : int, re : int, passYear : int = None):                
        """
        KEY : 담보키
        re : 갱신여부 ---> 1 : 최초계약 / 2 : 갱신계약
        mPrime : 납입주기
        passYear : 경과기간
        """
        assert m<=n
        assert sex in [1, 2]
        assert x+n<120      
        
        self.KEY = KEY
        self.sex = sex
        self.x = x
        self.n = n
        self.m = m
        self.mPrime = mPrime
        self.AMT = AMT
        self.passYear = 0 if passYear==None else passYear

        # 사업비 세팅
        self.re = re
        if self.re == 1:
            alpha = 0.3
        else:
            if n == 1:
                alpha = 0.07
            elif n==2:
                alpha = 0.14
            else:
                alpha = 0.21
        self.alpha = alpha
        self.beta = 0.19
        self.beta5 = 0.02
        self.ce = 0.038             # 손해조사비

        # 한계연령
        self.w = 108 if self.sex == 1 else 110    
        # projection 기간 (0, 1, 2, ... , n ---> n+1)
        self.proj = self.n+1

    def getQx(self, riskKey : str, sex : int = None, start : int = None) -> np.array:
        if sex == None:
            sex = self.sex
        if start == None:
            start = self.x
        df = self.sht_rate.loc[self.sht_rate['RiskKey'] == riskKey].copy(deep=True)
        if sex==1:
            df = df[['x', 'Male']]
        else:
            df = df[['x', 'Female']]
        qx = np.zeros(120)
        for row in df.values:   
            age, rate = row
            qx[int(age)] = rate
        return qx[start:]

    # 결합위험률 생성 코드
    def getCombQx(self, combRiskKey : str):
        df = self.sht_comb.loc[self.sht_comb['CombRiskKey'] == combRiskKey].copy(deep=True)
        row = df.values[0]
        combRiskKey, operation, numRiskKey = row[:3]
        riskKeys = row[3:3+int(numRiskKey)]
        periods = row[11:11+int(numRiskKey)]    
        if operation == 1:
            qx = np.zeros(120-self.x) 
            for rKey, period in zip(riskKeys, periods):
                if rKey[0] == "C":
                    qx_i = self.getCombQx(rKey)
                else:
                    qx_i = self.getQx(rKey, sex = self.sex, start=self.x) 
                qx_i[0] *= (1-period/12)                    
                qx += qx_i
        elif operation == 2:
            qx = np.ones(120-self.x)   
            for rKey, period in zip(riskKeys, periods):
                if rKey[0] == "C":
                    qx_i = self.getCombQx(rKey)
                else:
                    qx_i = self.getQx(rKey, sex = self.sex, start=self.x) 
                qx_i[0] *= (1-period/12)
                qx *= 1-qx_i
            qx = 1-qx
        else:
            raise ValueError("결합위험률 시트 operation 입력 오류")           
        return qx

    def getMatrixQx(self, riskKey : str)->np.array:
        firstJoin = self.x - self.passYear     # 최초가입연령 = 가입연령 - 경과기간
        df = self.sht_rate.loc[(self.sht_rate['x'] == firstJoin) & \
            (self.sht_rate['RiskKey'] == riskKey)].copy(deep = True)
        if self.sex == 1:df = df[['PassYear', 'Male']]
        else:df = df[['PassYear', 'Female']]
        qx = np.zeros(120)
        for row in df.values:
            age, rate = row
            qx[int(age)] = rate
        return qx      
    
    def Calc(self, returnSample : bool = False):
        df = self.sht_code.copy(deep=True)
        df = df.loc[df['KEY'] == self.KEY]
        # Initialize
        Dx, DxPrime, Nx, NxPrime, tVx, tWx, SUMx  = [0.]*(self.proj), [0.]*(self.proj), [0.]*(self.proj),\
            [0.]*(self.proj), [], [], [0.]*(self.proj)
        sample_dict = {}
        for row in df.values:
            lx = []
            # unpack
            riskKind, _ , benefitNum, exitCode, nonCov, benefitCode, defryRate, reducRate, reducPeriod, grantCode, invalidPeriod = row           
            # float ---> int
            nonCov = int(nonCov)    
            reducPeriod = int(reducPeriod)
            invalidPeriod = int(invalidPeriod)
            ##------------ 위험율 세팅 ------------##   
            # 결합위험률을 사용하는 경우
            if riskKind == "C":
                if benefitNum != 99:
                    # 탈퇴율
                    if exitCode == self.fillNa:
                        q_exit = np.zeros(self.proj)
                    else:
                        q_exit = self.getCombQx(combRiskKey=exitCode)  
                    # 급부율                        
                    if benefitCode == self.fillNa:
                        q_benefit = np.zeros(self.proj)
                    else:
                        q_benefit = self.getCombQx(combRiskKey=benefitCode)   
                else:
                    # 납입면제율           
                    if grantCode == self.fillNa:
                        q_grant = np.zeros(self.proj)
                    else:
                        q_grant = self.getCombQx(combRiskKey=grantCode) 

            # Matrix 위험률을 사용하는 경우
            elif riskKind == "M":
                if benefitNum != 99:
                    # 탈퇴율
                    if exitCode == self.fillNa:
                        q_exit = np.zeros(self.proj)
                    else:
                        q_exit = self.getMatrixQx(riskKey=exitCode)  
                    # 급부율                        
                    if benefitCode == self.fillNa:
                        q_benefit = np.zeros(self.proj)
                    else:
                        q_benefit = self.getMatrixQx(riskKey=benefitCode)   
                else:
                    # 납입면제율           
                    if grantCode == self.fillNa:
                        q_grant = np.zeros(self.proj)
                    else:
                        q_grant = self.getMatrixQx(riskKey=grantCode)               
            
            # 아닌경우
            else:
                if benefitNum != 99:
                    # 탈퇴율
                    if exitCode == self.fillNa:
                        q_exit = np.zeros(self.proj)
                    else:
                        q_exit = self.getQx(riskKey = exitCode)  
                    # 급부율                        
                    if benefitCode == self.fillNa:
                        q_benefit = np.zeros(self.proj)
                    else:
                        q_benefit = self.getQx(riskKey=benefitCode)   
                else:
                    # 납입면제율           
                    if grantCode == self.fillNa:
                        q_grant = np.zeros(self.proj)
                    else:
                        q_grant = self.getQx(riskKey=grantCode)               
            
            ## ------------ lx ------------ ##
            if benefitNum != 99:
                # 유지자                
                lx = [self.l0]   
                for t in range(self.proj-1):
                    q = q_exit[t]
                    if t==0:
                        q*=(1-nonCov/12)
                    l_next = lx[t]*(1-q)
                    lx.append(l_next)   
            else:
                # 납입자
                lx = [self.l0]
                for t in range(self.proj-1):
                    q = q_grant[t]
                    if t==0:
                        q*=(1-invalidPeriod/12)
                    l_next = lx[t]*(1-q)
                    lx.append(l_next)   

            ## ------------ 기수식 ------------ ##
            # Dx, Nx
            if benefitNum == 0:
                Dx = [lx[t]*self.v**t for t in range(self.proj)]
                Nx = [sum(Dx[t:]) for t in range(self.proj)]
            # D'x, N'x
            elif benefitNum == 99:
                DxPrime = [lx[t]*self.v**t for t in range(self.proj)]
                NxPrime = [sum(DxPrime[t:]) for t in range(self.proj)]
            # dx, Cx, Mx, SUMx
            else:
                dx = [q_benefit[t]*lx[t] for t in range(self.proj)]
                Cx = [dx[t]*self.v**(t+0.5) for t in range(self.proj)]
                Mx = [sum(Cx[t:]) for t in range(self.proj)]
                for t in range(self.proj):
                    if t<reducPeriod:
                        sum_x = defryRate*((1-reducRate)*(Mx[t] - Mx[reducPeriod]) + (Mx[reducPeriod] - Mx[self.n]))
                    else:
                        sum_x = defryRate*(Mx[t]-Mx[self.n])
                    SUMx[t] += sum_x

            # sample
            if returnSample:
                if benefitNum == 0:
                    sample_dict['lx'] = lx
                    sample_dict['Dx'] = Dx
                    sample_dict['Nx'] = Nx                    
                elif benefitNum == 99:
                    sample_dict[f"l'x"] = lx
                    sample_dict["D'x"] = DxPrime
                    sample_dict["N'x"] = DxPrime
                else:
                    sample_dict[f'lx({benefitNum})'] = lx
                    sample_dict[f'dx({benefitNum})'] = dx
                    sample_dict[f'Cx({benefitNum})'] = Cx
                    sample_dict[f'Mx({benefitNum})'] = Mx
        if returnSample:
            sample_dict['SUMx'] = SUMx

        ## ------------ 보험료 ------------ ##
        # 월납 납입기수
        Nstar = ((NxPrime[0] - NxPrime[self.m]) - (self.mPrime-1)/(2*self.mPrime)*(DxPrime[0]-DxPrime[self.m]))
        NP = SUMx[0]/(Nstar*self.mPrime)
        G = NP/(1-self.beta-self.beta5-self.ce-self.alpha*Dx[0]/Nstar)
        ## ------------ 준비금 ------------ ##
        for t in range(self.proj):
            if t==0:
                V=0
            else:
                V = (SUMx[t] - NP *(Nx[t]-Nx[self.m]))/Dx[t]
            V = round(V*self.AMT)
            tVx.append(V)        

        if returnSample:
            sample_dict['tVx'] = tVx
            # sample_dict['tWx'] = tWx
            print(f"N* : {Nstar} / NP : {NP} / G : {G}")
            return pd.DataFrame(sample_dict)
        else:
            return {'NP' : round(NP*self.AMT), 'G' : round(G*self.AMT), 'tVx' : tVx}

    def checkG(self, save_path : str = './영업보험료.csv'):
        df = self.sht_G.copy(deep=True)
        my_Gs = []
        for row in tqdm(df.values):
            # sub1 : 최초가입연령 / sub2 : 경가기간
            KEY,m_,sex,x,re,n,m,sub1,sub2,G,AMT = row
            self.setArgs(KEY = KEY, sex = sex, x = x, n = n, m=m ,mPrime = int(12/m_), AMT = AMT, re = re)
            try:
                result = self.Calc()

                my_Gs.append(result['G'] )
            except:
                my_Gs.append("ERROR")
        pd.DataFrame(my_Gs).to_csv(save_path, encoding = "CP949")
        print("영업보험료 계산 완료")

    def checkV(self, save_path : str = './준비금.csv'):
        df = self.sht_V.copy(deep=True)
        my_Vs = []
        for row in tqdm(df.values):
            # sub1 : 최초가입연령 / sub2 : 경가기간
            _,_,KEY,m_,sex,x,re,n,m,sub1,sub2,G,AMT,V0,V1,V2 = row
            self.setArgs(KEY = KEY, sex = sex, x = x, n = n, m=m ,mPrime = 1, AMT = AMT, re = re)
            try:
                Vs = self.Calc()['tVx']
                if len(Vs)<3:Vs=Vs+[0]*(4-len(Vs))
                my_Vs.append(Vs)
            except:
                my_Vs.append(["ERROR"]*3)
        pd.DataFrame(my_Vs).to_csv(save_path, encoding = "CP949")
        print("준비금 계산 완료")