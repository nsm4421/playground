import numpy as np
import pandas as pd
from MyUtil import MyUtil


class BasicPV(MyUtil):
    def __init__(self):
        super(BasicPV, self).__init__()

 
    def setArgs(self, coverage:str, sex:int, x:int, n:int, m:int, injure : int = 0, driver : int = None, AMT : int = 100000):
        self.coverage = coverage                                 # 담보키
        self.sex = int(sex)                                      # 성별
        self.x = int(x)                                          # 가입연령
        self.n = int(n)                                          # 보험기간
        self.m = int(m)                                          # 납입기간
        self.injure = int(injure) if injure != "^" else "^"      # 상해급수
        self.driver = int(driver) if driver != "^" else "^"      # 운전자급수
        self.AMT = AMT                                           # 가입금액

        # 상품정보
        self.ProductInfo = self.gatherInfo(coverage=self.coverage, sex=self.sex, x=self.x, n=self.n, injure = self.injure, driver=self.driver) 
    
    
    ## ============================= 기수식 계산 (수정 禁止) ============================= ##

    def CalcSymbol(self, returnDataFrame : bool = False): 
        # -------------------------- 상품정보 불러오기 --------------------------#
        num_benefit = self.ProductInfo['NumBenefit']           # 급부개수
        proj = self.n+1                                      # projection기간 (보험기간 ---> 0,1,2,...n)
        ExitInfo = self.ProductInfo['Exit']                  # 탈퇴
        BenefitInfo = self.ProductInfo['Benefit']               # 급부지급
        GrantInfo = self.ProductInfo['Grant']                 # 납면

        # -------------------------- 기수 초기화 --------------------------#

        lx_array = np.zeros(shape=(num_benefit+2, proj))    # 전체유지자, 급부별유지자, 납입자
        qx_exit = np.zeros(shape=(num_benefit+2, proj))     # 탈퇴율 & 납면율
        qx_benefit = np.zeros(shape=(num_benefit, proj))    # 급부지급률
        Cx_array = np.zeros(shape=(num_benefit, proj))      # <---- Cx(1), Cx(2), .....
        Mx_array = np.zeros(shape=(num_benefit, proj))      # <---- Mx(1), Mx(2), .....
        SUM_array = np.zeros(shape=(proj))                  
        Dx_array = np.zeros(shape=(2, proj))                # <---- Dx, D'x
        Nx_array = np.zeros(shape=(2, proj))                # <---- Nx, N'x

        # --------------------------  qx_exit(탈퇴율) & qx_benefit(급부율) -------------------------- #
        for idx in range(num_benefit+2):
            if idx == 0:                                    # 전체유지자
                qx_exit[0] = ExitInfo[0]['qx']
            elif idx<num_benefit+1:                         # 급부별 유지자
                qx_exit[idx] = ExitInfo[idx]['qx']
                qx_benefit[idx-1] = BenefitInfo[idx]['qx']
            else:                                           # 납입자
                qx_exit[-1] = GrantInfo[99]['qx']        

        # --------------------------  계산기수 계산 -------------------------- #     
        # lx   
        for (benefitNum, Info) in ExitInfo.items():     
            nonCov = Info['NonCov']                   
            lx_array[benefitNum] = self.CalcLx(qx=qx_exit[benefitNum], period=nonCov, proj=proj, l0=self.l0)
            
        # l'x
        invalidPeriod = GrantInfo[99]['InvalidPeriod']
        lx_array[-1] = self.CalcLx(qx=qx_exit[-1], period=invalidPeriod, proj=proj, l0=self.l0)

        # Dx, D'x, Nx, N'x
        Dx_array[0] = lx_array[0] * (self.v ** np.arange(proj))
        Dx_array[-1] = lx_array[-1] * (self.v ** np.arange(proj))
        Nx_array[0] = self.CalcInverseCumSum(Dx_array[0])
        Nx_array[1] = self.CalcInverseCumSum(Dx_array[1])

        # Cx, Mx ,SUMx
        for (benefitNum, Info) in BenefitInfo.items():
            idx = benefitNum-1
            defryRate,reducRate,reducPeriod = Info['DefryRate'], Info['ReducRate'], Info['ReducPeriod']
            # Cx
            Cx_array[idx] = (lx_array[benefitNum] * qx_benefit[idx]) * (self.v**(np.arange(proj)+0.5))
        
            # Mx
            Mx_array[idx] = self.CalcInverseCumSum(Cx_array[idx])
            # SUMx
            for t in range(proj):
                if t < reducPeriod:         # 감액기간 中
                    SUM_array[t] += defryRate * ((1 - reducRate) *(Mx_array[idx, t] - Mx_array[idx, reducPeriod]) \
                        + (Mx_array[idx, reducPeriod] - Mx_array[idx, self.n]))
                else:                       # 감액기간 後
                    SUM_array[t] += defryRate * (Mx_array[idx, t] - Mx_array[idx, self.n]) 


        # -------------------------- 결과물 return -------------------------- #  
        if returnDataFrame:                                     # 데이터 프레임으로 기수표를 출력하는 경우
            result = {}
            # qx_exit
            for idx in range(num_benefit+2):
                result[f"qx_exit({idx if idx<num_benefit+1 else 99})"] = qx_exit[idx]
            for idx in range(num_benefit):
                result[f"qx_benefit({idx+1})"] = qx_benefit[idx]
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
        else:                                                   # SUMx, Dx, D'x, Nx, N'x        
            return SUM_array, Dx_array[0], Dx_array[1], Nx_array[0], Nx_array[1]

    #------------------------------------ static methods ------------------------------------#

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
