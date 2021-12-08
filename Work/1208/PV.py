from numpy.typing import _96Bit
from Util import MyUtil
import pandas as pd

class MyPV(MyUtil):
    def __init__(self, excel_file='./INFO.xlsx', fillNa : str = "^", i : float = 0.025):
        # 상위 클래스 초기화
        super(MyPV, self).__init__(excel_file=excel_file, fillNa=fillNa, i = i)

        # 사업비시트 읽기
        self.df_Expense = pd.read_excel(excel_file, sheet_name="사업비", header = 2).fillna(fillNa)

    def MyCalculation(self, sex: int, x: int, n: int, m: int, coverageKey: str, AMT : int, injure: int = None, driver: int = None):
        # arumnent 세팅
        super().setArgs(sex=sex, x=x, n=n, m=m, coverageKey=coverageKey, injure=injure, driver=driver, AMT=AMT)   
        
        # 결합위험률 dictionary 생성
        super().setCombQxDict()     

        # PV 계산 결과 return
        return self.calculatePV(symbolsDict=super().getSymbolsDict(),\
            expenseDict=self.getExpenseDict(df_Expense = self.df_Expense, coverageKey = self.coverageKey, n = self.n), \
                n=n, m=m, AMT=AMT)
   
    # 사업비 dictionary
    @staticmethod
    def getExpenseDict(df_Expense : pd.DataFrame, coverageKey : str, n : int) -> dict:
        expense = df_Expense.loc[df_Expense['CoverageKey'] == coverageKey].values[0]
        alpha1 = expense[3+n]
        alpha3 = expense[9] / 1000                                  # 대천 알파
        beta1 = expense[10]
        beta2 = expense[11]
        gamma = expense[12]
        ce = expense[13]
        S = expense[14]                                             # S rate
        useSingleRate = True if expense[15] == "Y" else False       # 단일률 사용 여부
        return {'alpha1' : alpha1, 'alpha3' : alpha3, 'beta1' : beta1, 'beta2' : beta2, 'gamma' : gamma, 'ce' : ce, 'S' : S, 'useSingleRate' : useSingleRate}       

    # PV 계산
    @staticmethod
    def calculatePV(symbolsDict : dict, expenseDict : dict, n : int, m : int, AMT : int):
        # parsing
        SUMx = symbolsDict['SUMx']
        Dx = symbolsDict["Dx"]
        DxPrime = symbolsDict["D'x"]
        Nx = symbolsDict["Nx"]
        NxPrime = symbolsDict["N'x"]
        alpha1 = expenseDict['alpha1']
        alpha3 = expenseDict['alpha3']
        beta1 = expenseDict['beta1']
        beta2 = expenseDict['beta2']
        gamma = expenseDict['gamma']
        ce = expenseDict['ce']
        S = expenseDict['S']
        useSingleRate = expenseDict['useSingleRate']

        # 납입기수
        Nstar1 = 1 *(NxPrime[0] - NxPrime[m])
        Nstar12 = 12 *(NxPrime[0] - NxPrime[m] - 11/24 * (DxPrime[0] - DxPrime[m]))
        
        # 순보험료
        NP1_full = SUMx[0] / Nstar1
        NP12_full = SUMx[0] / Nstar12
        NP1 = round(NP1_full*AMT)
        NP12 = round(NP12_full*AMT)

        # 영업보험료
        G1_full = (NP1_full + alpha3 * DxPrime[0]/Nstar1 + beta2 * (Nx[m]-Nx[n])/Nstar1) / (1-alpha1*DxPrime[0]/(Nstar1/1)-beta1-ce-gamma)
        G12_full = (NP12_full + alpha3 * DxPrime[0]/Nstar12 + beta2 * (Nx[m]-Nx[n])/Nstar12) / (1-alpha1*DxPrime[0]/(Nstar12/12)-beta1-ce-gamma)
        G1 = round(G1_full*AMT)
        G12 = round(G12_full*AMT)

        # 책임준비금
        tVx_full = [(SUMx[t]-NP1_full*(Nx[t]-Nx[m]))/Dx[t] for t in range(n+1)]
        tVx = [round(V*AMT) for V in tVx_full]

          
        return NP12, G12, tVx


