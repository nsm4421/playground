import numpy as np
import pandas as pd
from MyUtil import MyUtil
from Setting import Setting


# Usage
# mypv = MyPV()
# mypv.setArgs(coverage, sex, x, n, m, injure, driver, AMT)
# mypv.CalcPV()



class MyPV(MyUtil):
    def __init__(self, qx_path : str = './Qx.csv', code_path : str = './Code.csv', comb_path :str = './Comb.csv',\
        max_age : int = 120, fillNa : str = "^"):
        super(MyPV, self).__init__(fillNa=fillNa)
        self.Qx_dict = Setting.MakeQxDict(qx_path=qx_path, max_age=max_age, fillNa=fillNa)
        self.Coverage_dict = Setting.MakeCoverageDict(code_path=code_path, comb_path=comb_path, fillNa=fillNa)

        self.i = 0.025
        self.v = 1/(1+self.i)
        

     # PV계산    
    def CalcPV(self):
        # 기수계산
        SUMx, Dx, DxPrime, Nx, NxPrime = self.CalcSymbol()        
        # 납입기수
        Nstar1 = self.CalcNstar(DxPrime=DxPrime, NxPrime=NxPrime, m=self.m, mPrime=1)
        Nstar12 = self.CalcNstar(DxPrime=DxPrime, NxPrime=NxPrime, m=self.m, mPrime=12)
        # 순보험료
        NP1_full = SUMx[0]/Nstar1
        NP12_full = SUMx[0]/Nstar12
        NP1 = round(NP1_full*self.AMT)
        NP12 = round(NP12_full*self.AMT)
        return NP1, NP12
