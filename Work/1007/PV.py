import numpy as np
import pandas as pd


class PV:
    def __init__(self, util = None):
        self.i = 0.0255
        self.v = self.i/(1+self.i)
        self.l0 = 10000
        self.util = util

    def setArgs(self, args : dict):
        self.args = args

    def setExpense(self, **args):
        if re == 1:
            alpha = 0.3
        else:
            alpha = 0.07*n
        beta = 0.19
        betaPrime = 0.038
        ce = 0.38
        return {'alpha' : alpha, \
            beta : 'beta', \
                'betaPrime' : betaPrime, \
                    'ce' : ce}

    # 기수식 계산 (수정 禁止)
    def CalcSymbol(self, **args): 
        """
        args 
        - Type : dictionary
        - Keys : coverageKey, sex, x, n, m, num_benefit, l0, proj
        """
        # Settting
        self.utils.setArgs(**args)
        ProductInfo = self.util.getProductInfo(coverageKey)      
        """
        ExitInfo 예시 { 0 : {'qx' : { 'riskCode' : 'AAA', riskType : 'ZZ'}, 'nonCov' : 3} }
        """
        # unpack
        ExitInfo = ProductInfo['Exit']                      # 탈퇴
        BenefitInfo = ProductInfo['Benefit']                # 급부지급
        GrantInfo = ProductInfo['Grant']                    # 납면

        proj = n+1

        # 기수 초기화
        lx_array = np.zeros(shape=(proj, num_benefit+2))    # 전체유지자, 급부별유지자, 납입자
        qx_exit = np.zeros(shape=(proj, num_benefit+2))     
        
        qx_benefit = np.zeros(shape=(proj, num_benefit))    # 급부별 유지자
        Cx_array = np.zeros(shape=(proj, num_benefit))      
        Mx_array = np.zeros(shape=(proj, num_benefit))      
        SUM_array = np.zeros(shape=(proj))   

        Dx_array = np.zeros(shape=(proj, 2))                # 전체유지자, 납입자
        Nx_array = np.zeros(shape=(proj, 2))                

        # lx        
        for idx, (benefitNum, Info) in enumerate(ExitInfo.items()):
            qx_info = Info['qx']
            nonCov = Info['NonCov']
            qx_exit[:, idx] = self.util.getQx(**qx_info)            
            lx_array[0, idx] = l0
            for t in range(proj-1):
                if t == 0:
                    lx_array[t+1, idx] = lx_array[t, idx] * (1 - (1-nonCov/12) * qx_exit[t, idx])
                else:
                    lx_array[t+1, idx] = lx_array[t, idx] * (1 - qx_exit[t, idx])

        # l'x
        qx_exit[:, -1] = self.util.getQx(**GrantInfo['qx'])
        lx_array[0, -1] = l0
        for t in range(proj-1):
            if t == 0:              # 무효해지기간
                lx_array[t+1, -1] = lx_array[t, -1] * (1 - (1-GrantInfo['InvalidPeriod']/12) * qx_exit[t, -1])
            else:
                lx_array[t+1, -1] = lx_array[t, -1] * (1 - (1-qx_exit[t, -1]))

        # Dx, D'x
        Dx_array[:, 0] = lx_array[:, 0] * self.v ** np.arange(proj)
        Dx_array[:, 1] = lx_array[:, 1] * self.v ** np.arange(proj)

        # Nx, N'x
        Nx_array[:, 0] = np.sum(Dx_array[:, 0]) - np.cumsum(Dx_array[:, 0])
        Nx_array[:, 1] = np.sum(Dx_array[:, 1]) - np.cumsum(Dx_array[:, 1])

        # 급부지급
        for idx, (benefitNum, Info) in enumerate(BenefitInfo.items()):
            defryRate = Info['DefryRate']               # 지급률
            reducRate = Info['ReducRate']               # 감액률
            reducPeriod = Info['ReducPeriod']           # 감액기간
            # 급부지급률
            qx_benefit[:, idx] = self.util.getQx(**Info['qx'])
            # Cx
            Cx_array[:, idx] = lx_array[:, idx] * qx_benefit[:, idx] * self.v**(np.arange(proj)+0.5)
            # Mx
            Mx_array[:, idx] = np.sum(Cx_array[:, idx], axis = 1) - np.cumsum(Cx_array[:, idx])
            # SUMx
            for t in range(self.proj):
                if t < reducPeriod:         # 감액기간 中
                    SUM_array[t] += defryRate * ((1 - reducRate) *(Mx_array[t, idx] - Mx_array[reducPeriod, idx]) \
                        + (Mx_array[reducPeriod, idx] - Mx_array[n, idx]))
                else:                       # 감액기간 後
                    SUM_array[t] += defryRate * (Mx_array[t, idx] - Mx_array[n, idx])            

        # pop up result   
        result = {}
        # # lx
        # for idx in range(num_benefit+1):
        #     result[f"lx({idx})"] = lx_array[:, idx]
        # result["l'x"] = lx_array[:, -1]
        # result['Dx'] = Dx_array[:, 0]
        result["D'x"] = Dx_array[:, -1]    
        # result["Nx"] = Nx_array[:, 0]   
        result["N'x"] = Nx_array[:, -1]        
        # for idx in range(num_benefit):
            # result[f"Cx({idx+1})"] = Cx_array[:, idx]
            # result[f"Mx({idx+1})"] = Mx_array[:, idx]
        result[f"SUMx"] = SUM_array[:, idx]
        return result     

    @staticmethod
    def NStar(DxPrime : np.array, NxPrime : np.array, m : int, mPrime : int = 12):
        return mPrime * (NxPrime[0] - NxPrime[m] - \
            (mPrime - 1)/(2*mPrime) * (DxPrime[0] - DxPrime[m]))

    def CalcPV(self, **args):

        # unpack
        symbol = self.CalcSymbol()
        SUMx = result['SUM']
        Dx = result['Dx']
        DxPrime = result["D'x"]
        NxPrime = result["N'x"]

        # 사업비
        expense = self.setExpense()
        alpha = expense['alpha']
        beta = expense['beta']
        betaPrime = expense['betaPrime']
        ce = expense['ce']

        # 납입기수
        Nstar1 = self.Nstar(DxPrime, NxPrime, m, 1)
        Nstar2 = self.Nstar(DxPrime, NxPrime, m, 2)
        Nstar4 = self.Nstar(DxPrime, NxPrime, m, 4)
        Nstar12 = self.Nstar(DxPrime, NxPrime, m, 12)

        # 순보험료
        NP1 = SUMx[0] / Nstar1
        NP2 = SUMx[0] / Nstar2
        NP4 = SUMx[0] / Nstar4
        NP12 = SUMx[0] / Nstar12

        # 영업보험료
        G1 = NP1 / (1-beta-beta5-ce-alpha*Dx[0]/Nstar1)
        G2 = NP2 / (1-beta-beta5-ce-alpha*Dx[0]/Nstar2)        
        G4 = NP4 / (1-beta-beta5-ce-alpha*Dx[0]/Nstar4)
        G12 = NP12 / (1-beta-beta5-ce-alpha*Dx[0]/Nstar12)

        # 준비금
        tVx = [(SUMx[t] - NP1 * (Nx[t]-Nx[m]))/Dx[t] for t in range(proj)]
        tVx = np.array(tVx)

        return {'NP' : [NP1, NP2, NP4, NP12], \
            'G' : [G1, G2, G4, G12], \
                'tVx' : tVx}
