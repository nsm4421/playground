import numpy as np
import pandas as pd

class MyPV:
    def __init__(self, excel_file : str = './INFO.xlsx', fillNa = 0):
        # 엑셀파일 읽기
        sht_rate = pd.read_excel(excel_file, sheet_name="위험률", header=1)
        sht_code = pd.read_excel(excel_file, sheet_name="코드", header=1)
        sht_expense = pd.read_excel(excel_file, sheet_name="사업비", header=1)
        sht_comb = pd.read_excel(excel_file, sheet_name="결합위험률", header=1)
        
        # 전처리
        self.fillNa = fillNa        
        self.sht_rate = sht_rate[['RiskKey', 'x', 'Male', 'Female']].fillna(self.fillNa)
        self.sht_code = sht_code[['KEY', 'BenefitNum', 'ExitCode', 'NonCov',\
            'BenefitCode', 'DefryRate', 'ReducRate', 'ReducPeriod', \
                'GrantCode', 'InvalidPeriod']].fillna(self.fillNa)
        self.sht_expense = sht_expense[['KEY', 'sex', 'x', 'n', 'm', 'mPrime',\
            'AMT', 'S', 'alpha1', 'alpha2', 'beta1', 'beta2','betaPrime', \
                'beta5', 'ce', 'gamma', 'StdAlpha2']].fillna(self.fillNa)
        self.sht_comb = sht_comb[['CombRiskKey', 'Operation', 'RiskKey(1)', 'RiskKey(2)',\
            'RiskKey(3)', 'RiskKey(4)', 'RiskKey(5)', 'RiskKey(6)', 'RiskKey(7)', 'RiskKey(8)']]\
                .fillna(self.fillNa)

        # 공시이율
        self.i = 0.0225
        self.v = 1/(1+self.i)

        # 계약 시점에 가입자 수
        self.l0 = 100000

        # 입력값 세팅 했는지 여부
        self.didSetArgs = False

    def makeCombRate(self):
        for row in self.sht_comb.values:
            combRiskKey, operation = row[:2]
            rKeys = row[2:]            
            if operation == 1:
                qx_male, qx_female = np.zeros(120), np.zeros(120)
                for rKey in rKeys:
                    qx_male += self.getQx(rKey, sex = 1, start = 0) 
                    qx_female += self.getQx(rKey, sex = 2, start = 0) 
            elif operation == 2:
                qx1_male = self.getQx(rKeys[0], sex = 1, start = 0) 
                qx1_female = self.getQx(rKeys[0], sex = 2, start = 0) 
                qx2_male = self.getQx(rKeys[1], sex = 1, start = 0) 
                qx2_female = self.getQx(rKeys[1], sex = 2, start = 0) 
                qx_male = qx1_male+qx2_male - qx1_male*qx2_male/2
                qx_female = qx1_female+qx2_female - qx2_female*qx2_female/2
            else:
                continue            
            df = pd.DataFrame({'RiskKey' : [combRiskKey]*120, 'x' : np.arange(120),\
                'Male' : qx_male, 'Female' : qx_female})
            self.sht_rate = self.sht_rate.append(df)
            print(f"{combRiskKey} appended")


    def setArgs(self, KEY : str, sex : int, x : int,\
        n : int, m : int, mPrime : int, AMT : int, S : float,\
            alpha1 : float, alpha2 : float, beta1 : float, beta2 : float,\
                betaPrime : float, beta5 : float, ce : float, gamma : float, stdAlpha2 : int):                
        """
        expense sheet의 컬럼명과 동일
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
        self.S = S
        self.alpha1 = alpha1
        self.alpha2 = alpha2
        self.beta1 = beta1
        self.beta2 = beta2
        self.beta5 = beta5
        self.betaPrime = betaPrime
        self.ce = ce
        self.gamma = gamma
        self.stdAlpha2 = stdAlpha2
        # 한계연령
        self.w = 108 if self.sex == 1 else 110    
        # projection 기간 (0, 1, 2, ... , n ---> n+1)
        self.proj = self.n+1

        self.didSetArgs = True

    def setArgsIthRow(self, i : int):
        """
        Expense sheet에 i번째 줄의 정보를 읽어서 argument를 setting
        """                
        assert 0<=i and i<self.sht_expense.shape[0]
        row = self.sht_expense.values[i]  
        self.setArgs(*row)

    def getQx(self, riskKey : str, sex : int = None, start : int = None):
        if sex == None:sex = self.sex
        if start == None:start = self.x
        df = self.sht_rate.copy(deep=True)
        df = df.loc[df['RiskKey'] == riskKey]
        if sex==1:df = df[['x', 'Male']]
        else:df = df[['x', 'Female']]
        qx = np.zeros(120)
        for row in df.values:   
            age, rate = row
            qx[int(age)] = rate
        return qx[start:]
    

    def Calc(self, returnSample : bool = False):

        if not self.didSetArgs:
            raise ValueError("입력값 세팅이 안됨")

        df = self.sht_code.copy(deep=True)
        df = df.loc[df['KEY'] == self.KEY]

        # Initialize
        Dx, DxPrime, Nx, NxPrime, tVx, tWx, SUMx  = [0.]*(self.proj), [0.]*(self.proj), [0.]*(self.proj),\
            [0.]*(self.proj), [], [], [0.]*(self.proj)
        sample_dict = {}

        for row in df.values:
            # unpack
            _, benefitNum, exitCode, nonCov, benefitCode, defryRate, reducRate, reducPeriod, grantCode, invalidPeriod = row
            # Type Conversion
            try:
                benefitNum = int(benefitNum)
                exitCode = str(exitCode)
                nonCov = int(nonCov)
                benefitCode = str(benefitCode)
                defryRate = float(defryRate)
                reducPeriod = int(reducPeriod)
                grantCode = str(grantCode)
                invalidPeriod = int(invalidPeriod)
            except:
                raise ValueError("Type Mismatch")

            ##------------ 위험율 세팅 ------------##           
            if benefitNum != 99:
                # 탈퇴율
                if exitCode == self.fillNa:
                    q_exit = np.zeros(self.proj)
                else:
                    q_exit = self.getQx(exitCode)  
                # 급부율                        
                if benefitCode == self.fillNa:
                    q_benefit = np.zeros(self.proj)
                else:
                    q_benefit = self.getQx(benefitCode)   
            else:
                # 납입면제율           
                if grantCode == self.fillNa:
                    q_grant = np.zeros(self.proj)
                else:
                    q_grant = self.getQx(grantCode)               
            
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
                    sample_dict['Nx'] = Dx                    
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
        Nstar = 12*((NxPrime[0] - NxPrime[self.m]) - 11/24*(DxPrime[0]-DxPrime[self.m]))
        # 월납순보험료
        NP_month = SUMx[0]/Nstar
        # 연납순보험료
        NP_annual = SUMx[0] / (NxPrime[0] - NxPrime[self.m])
        # 기준연납순보험료
        NP_std = SUMx[0]/(NxPrime[0]-NxPrime[min(self.n, 20)])
        if self.stdAlpha2 ==1:  # alpha2 : 기준연납순보험료기준
            # 영업보험료
            G = (NP_month + (self.alpha1 + self.alpha2*NP_std) * Dx[0]/Nstar +\
                    self.beta1/12 + self.betaPrime*(Nx[0]-Nx[self.n]-Nstar/12)/Nstar) \
                        /(1-self.beta2-self.beta5)
            # 연납베타순보험료
            NP_beta = NP_annual + self.betaPrime*(Nx[0]-Nx[self.n]-(NxPrime[0]-NxPrime[self.m]))/(NxPrime[0]-NxPrime[self.m])
        elif self.stdAlpha2 ==2:  # alpha2 : 영업보험료기준
            # 영업ㅂ험료
            G = (NP_month+self.alpha1*Dx[0]/Nstar+self.beta1/12+self.betaPrime*(Nx[self.m]-Nx[self.n]))\
                /(1-self.alpha1*12*Dx[0]/Nstar-self.beta2-self.beta5)
            # 연납베타순보험료
            NP_beta = NP_annual + self.betaPrime*(Nx[self.m]-Nx[self.n])/(NxPrime[0]-NxPrime[self.m])  
        else:
            raise ValueError("stdAlpha2 는 1(기준연납순보기준) 아니면 2(영업보험료기준)")

        ## ------------ 준비금 ------------ ##
        for t in range(self.proj):
            if t==0:
                V=0
            else:
                V = (SUMx[t] + self.betaPrime*(Nx[t] - Nx[self.n]-\
                    max(NxPrime[t]-NxPrime[self.m], 0)) - NP_beta *max(NxPrime[t]-NxPrime[self.m]), 0)/Dx[t]
            tVx.append(V)        
        ## ------------ 해약환급금 ------------ ##
        # 공제액
        alpha_apply = self.alpha1 + self.alpha2 * NP_std
        alpha_std = NP_std*0.05*min(self.n, 20)+10/1000*self.S
        alpha = min(alpha_apply, alpha_std)
        # 환급금
        for t in range(self.proj):
            m = min(self.m, 7)
            W = max(0, tVx[t] - max(0, (1-t/m)*alpha))
            tWx.append(W)  
        if returnSample:
            sample_dict['tVx'] = tVx
            sample_dict['tWx'] = tWx
            print(f"N* : {Nstar} / NP_month : {NP_month} / NP_beta : {NP_beta} / G : {G}")
            return pd.DataFrame(sample_dict)
        else:
            return {'NP_beta' : NP_beta, 'G' : G, 'tVx' : tVx, 'tWx' : tWx, 'AMT' : self.AMT}
