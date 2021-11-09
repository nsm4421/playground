import numpy as np
import pandas as pd
from BasicPV import BasicPV

class MyPV(BasicPV):
    def __init__(self):
        super(MyPV,self).__init__()
        # 사업비 시트 읽기
        self.sht_expense = pd.read_excel(self.excel_file, sheet_name="사업비", header=2)
        self.sht_expense.columns = ['Coverage', 'CoverageName', 'al_1','al_2', 'al_3','al_4','al_5','a3', 'b1','b2','gamma','ce']

        # S rate시트 읽기
        self.Srate = pd.read_excel(self.excel_file, sheet_name="Srate", header=2)
        
        self.i = 0.0250
        self.v = 1/(1+self.i)
        self.l0 = 100000

    # 사업비세팅
    def setExpense(self):            
        expense = self.sht_expense.loc[self.sht_expense['Coverage'] == self.coverage].values[0]
        self.alpha1 = expense[self.n+1]
        self.alpha3 = expense[7]/1000       # 대천 alpha
        self.beta1 = expense[8]
        self.beta2 = expense[9]
        self.gamma = expense[10]
        self.ce = expense[11]


    # PV계산
    def CalcPV(self, coverage : str, n : int, m : int, sex : int, x : int, injure : int, driver : int, AMT : int):

        # 계약정보 세팅
        self.setArgs(coverage=coverage, sex=sex, x=x, n=n, m=m, injure=injure, driver=driver, AMT=AMT)

        # 사업비세팅
        self.setExpense()


        # 기수계산
        SUMx, Dx, DxPrime, Nx, NxPrime = self.CalcSymbol()
        
        # 순보험료
        Nstar1 = self.CalcNstar(DxPrime=DxPrime, NxPrime=NxPrime, m=self.m, mPrime=1)
        Nstar12 = self.CalcNstar(DxPrime=DxPrime, NxPrime=NxPrime, m=self.m, mPrime=12)
        NP1_full = SUMx[0]/Nstar1
        NP12_full = SUMx[0]/Nstar12
        NP1 = round(NP1_full*self.AMT)
        NP12 = round(NP12_full*self.AMT)

        # 영업보험료
        G1_full = (NP1_full + self.alpha3 * DxPrime[0]/Nstar1 + self.beta2*(Nx[self.m] - Nx[self.n])/Nstar1) / \
            (1-self.alpha1*DxPrime[0]/(Nstar1/1) - self.beta1 - self.ce - self.gamma)
        G12_full = (NP12_full + self.alpha3 * DxPrime[0]/Nstar12 + self.beta2*(Nx[self.m] - Nx[self.n])/Nstar12) / \
            (1-self.alpha1*DxPrime[0]/(Nstar12/12) - self.beta1 - self.ce - self.gamma)
        G1 = round(G1_full*self.AMT)
        G12 = round(G12_full*self.AMT)

        # 준비금
        tVx_full = [(SUMx[t] - NP1_full * max(NxPrime[t] - NxPrime[self.n], 0))/Dx[t] for t in range(self.n+1)]
        tVx = [round(V*self.AMT) for V in tVx_full]
        tVx += ["^" for _ in range(6-self.n)]

        # 신계약비
        alpha_apply = round(G1 * self.alpha1 + round(self.alpha3*self.AMT), 0)

        # 해약환급금
        if coverage == 'LA1568' or coverage == 'LA3348':  
            # 단일률  
            alpha_std = NP1_full*0.05*min(n, 20) + 0.45*NP1
            alpha_std *= self.AMT
        else:            
            # S rate 세팅
            S = self.Srate.loc[self.Srate['Coverage'] == coverage]['S'].values[0]
            alpha_std = NP1_full*0.05*min(n, 20) + S * 0.01
            alpha_std *= self.AMT
          
        return NP1,NP12,G1,G12,tVx[0],tVx[1],tVx[2],tVx[3],tVx[4],tVx[5],alpha_apply,round(alpha_std, 8) 






