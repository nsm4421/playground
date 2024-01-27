import numpy as np
import pandas as pd
from Setting import Setting

class MyUtil:
    def __init__(self, fillNa : str = "^"):
        self.fillNa = fillNa

    # Argument Setting
    def setArgs(self, coverage:str, sex:int, x:int, n:int, m:int, injure : int = 0, driver : int = None, AMT : int = 100000):
        self.coverage = coverage                                                # 담보키
        self.sex = int(sex)                                                     # 성별
        self.x = int(x)                                                         # 가입연령
        self.n = int(n)                                                         # 보험기간
        self.m = int(m)                                                         # 납입기간
        self.injure = int(injure) if injure != self.fillNa else self.fillNa     # 상해급수
        self.driver = int(driver) if driver != self.fillNa else self.fillNa     # 운전자급수
        self.AMT = AMT                                                          # 가입금액

        self.cov_dict = self.Coverage_dict[coverage]

    # 기수식 계산
    def CalcSymbol(self, returnDataFrame : bool = False): 

        # 탈퇴율, 급부율, 납면율, 급부개수
        qx_exit, qx_benefit, qx_grant, num_benefit = self.getQx()
        proj = self.n+1                                        # projection기간 (보험기간 ---> 0,1,2,...n)
    
        lx_array = np.zeros(shape=(num_benefit+2, proj))    # 전체유지자, 급부별유지자, 납입자
        Cx_array = np.zeros(shape=(num_benefit, proj))      # <---- Cx(1), Cx(2), .....
        Mx_array = np.zeros(shape=(num_benefit, proj))      # <---- Mx(1), Mx(2), .....
        SUM_array = np.zeros(shape=(proj))                  
        Dx_array = np.zeros(shape=(2, proj))                # <---- Dx, D'x
        Nx_array = np.zeros(shape=(2, proj))                # <---- Nx, N'x
  
        # lx   
        for i, nCov in enumerate(self.cov_dict['NonCov']):                      
            lx_array[i] = self.CalcLx(qx=qx_exit[i], period=nCov, proj=proj, l0=self.l0)
            
        # l'x
        invalidPeriod = self.cov_dict['InvalidPeriod']
        lx_array[-1] = self.CalcLx(qx=qx_exit[-1], period=invalidPeriod, proj=proj, l0=self.l0)

        # Dx, D'x, Nx, N'x
        Dx_array[0] = lx_array[0] * (self.v ** np.arange(proj))
        Dx_array[-1] = lx_array[-1] * (self.v ** np.arange(proj))
        Nx_array[0] = self.CalcInverseCumSum(Dx_array[0])
        Nx_array[1] = self.CalcInverseCumSum(Dx_array[1])

        # Cx, Mx ,SUMx
        for i, (pRate, rRate, rPeriod) in enumerate(zip(self.cov_dict['PayRate'], self.cov_dict['ReducRate'], self.cov_dict['ReducPeriod'])):
            Cx_array[i] = (lx_array[i] * qx_benefit[i]) * (self.v**(np.arange(proj)+0.5))       # Cx  
            Mx_array[i] = self.CalcInverseCumSum(Cx_array[i])                                   # Mx
            for t in range(proj):                                                               # SUMx
                if t < rPeriod:             # 감액기간 中
                    SUM_array[t] += pRate * ((1 - rRate) *(Mx_array[i, t] - Mx_array[i, rPeriod]) \
                        + (Mx_array[i, rPeriod] - Mx_array[i, self.n]))
                else:                       # 감액기간 後
                    SUM_array[t] += pRate * (Mx_array[i, t] - Mx_array[i, self.n]) 

        # 데이터 프레임으로 기수표를 출력하는 경우  
        if returnDataFrame:                                     
            result = {}
            # qx_exit
            for idx in range(num_benefit+1):
                result[f"qx_exit({idx if idx<num_benefit else 99})"] = qx_exit[idx]
            for idx in range(num_benefit):
                result[f"qx_benefit({idx})"] = qx_benefit[idx]
            # lx
            for idx in range(num_benefit+1):
                result[f"lx({idx})"] = lx_array[idx]
            # l'x
            result["l'x"] = lx_array[-1]
            # Dx, D'x, Nx, N'x
            result['Dx'] = Dx_array[0]
            result["D'x"] = Dx_array[1]    
            result["Nx"] = Nx_array[0]   
            result["N'x"] = Nx_array[-1]        
            for idx in range(num_benefit):
                result[f"Cx({idx+1})"] = Cx_array[idx]
                result[f"Mx({idx+1})"] = Mx_array[idx]
            result["SUMx"] = SUM_array
            return pd.DataFrame(result)
        # 데이터 프레임으로 기수표를 출력하지 않는 경우
        else:                                                          
            return SUM_array, Dx_array[0], Dx_array[1], Nx_array[0], Nx_array[1]


    #  -------------------------------------- 위험률세팅 --------------------------------------  #

    def getQx(self) -> list:
        numBenefit = self.cov_dict['NumBenefit']
        # 탈퇴율
        qx_exit = np.zeros((numBenefit+1, self.n+1))
        for i, (eCode, eType) in enumerate(zip(self.cov_dict['ExitCode'], self.cov_dict['ExitType'])):
            qx_exit[i] = self.QxMapping(riskCode=eCode, sex=self.sex, x=self.x, n=self.n, riskType=eType)        
        # 급부율
        qx_benefit = np.zeros((numBenefit, self.n+1))
        for i, (bCode, bType) in enumerate(zip(self.cov_dict['BenefitCode'], self.cov_dict['BenefitType'])):
            qx_benefit[i] = self.QxMapping(riskCode=bCode, sex=self.sex, x=self.x, n=self.n, riskType=bType)
        # 납면율
        qx_grant = self.QxMapping(riskCode=self.cov_dict['GrantCode'], sex=self.sex, x=self.x, n=self.n, riskType=self.cov_dict['GrantType'])
        return qx_exit, qx_benefit, qx_grant, numBenefit

    #  -------------------------------------- 위험률매핑 --------------------------------------  #

    def QxMapping(self, riskCode : str, sex : int, x : int, n : int, riskType : str)->np.array:
        # 위험률 코드 無 ---> qx = 0
        if riskCode == self.fillNa: 
            return np.zeros(shape=(self.n+1))
        # 일반적인 경우
        elif riskType.upper() == self.fillNa:
            return self.Qx_dict[self.sex][riskCode][self.x:self.x+self.n+1]
        # 이차위험률 (상해급수)
        elif riskType.upper() ==  "I": 
            riskKey = f"{riskCode}_{self.injure}"
            return self.Qx_dict[self.sex][riskKey][self.x:self.x+self.n+1]
        # 이차위험률 (운전자급수)
        elif riskType.upper() ==  "D": 
            riskKey = f"{riskCode}_{self.driver}"
            return self.Qx_dict[self.sex][riskKey][self.x:self.x+self.n+1]   
        # 결합위험률
        elif riskType.upper() ==  "C": 
            return self.getCombRiskRate(riskCode)   
        else:
            raise Exception(f'위험률 코드 {riskCode} / 타입 {riskType} 에러')

    # 결합위험률
    def getCombRiskRate(self, combRiskKey) -> np.array:
        combInfo = self.cov_dict['Combine'][combRiskKey]
        operation = combInfo['Operation']           
        riskKeys = combInfo['RiskKeys']
        qx_array = np.zeros(shape = (len(riskKeys), self.n+1))
        for i, rKey in enumerate(riskKeys):                
            qx_array[i] = self.Qx_dict[self.sex][rKey][self.x:self.x+self.n+1]                  
        k_array = np.array([period/12 for period in combInfo['Periods']])      
          
        if operation == 1:
            return self.CombOperation1(qx_array=qx_array, k_array=k_array)
        elif operation == 2:
            return self.CombOperation2(qx_array=qx_array, k_array=k_array)
        else:
            raise Exception("Operation 입력값 오류발생")

    # q_comb = (1-k1) q1 + (1-k2) q2 + ....
    @staticmethod
    def CombOperation1(qx_array : np.array, k_array : np.array):
        qx_array[:, 0] *= 1 - k_array
        return np.sum(qx_array, axis = 0)

    # q_comb = 1 - (1-k1 x q1) x (1-k2 x q2) x ....
    @staticmethod
    def CombOperation2(qx_array : np.array, k_array : np.array):       
        qx_array[:, 0] *= 1 - k_array      
        product = np.product(1-qx_array, axis = 0)      
        return 1-product
  
    @staticmethod
    def CalcLx(qx : np.array, period : int = 0, proj : int = None, l0 : int = 100000):
        if proj == None:proj = len(qx)
        lx = np.zeros(proj)
        lx[0] = l0
        for t in range(proj-1):
            if t==0:
                lx[t+1] = lx[t]*(1-qx[t]*(1-int(period)/12))
            else:
                lx[t+1] = lx[t]*(1-qx[t])
        return lx

    @staticmethod
    def CalcInverseCumSum(array : np.array):
        return np.array([sum(array[t:]) for t in range(len(array))])

    @staticmethod
    def CalcNstar(DxPrime : np.array, NxPrime : np.array, m : int, mPrime : int = 12):
        return mPrime * (NxPrime[0] - NxPrime[int(m)] -  (mPrime - 1)/(2*mPrime) * (DxPrime[0] - DxPrime[int(m)]))
