from Calc_Symbol import Calc_Symbol
import pandas as pd
from tqdm import tqdm

class Calc_PV(Calc_Symbol):
    def __init__(self, excel_path : str):
        super().__init__(excel_path=excel_path)
        # self.calcSrate()
        
    def calcPV(self) -> dict:
        
        SUMx = self.SymbolDict['SUMx']
        NxPrime = self.SymbolDict["N'x"]
        Nx = self.SymbolDict["Nx"]
        Dx = self.SymbolDict["Dx"]
        DxPrime = self.SymbolDict["D'x"]
        
        # 납입기수
        N1 = NxPrime[0] - NxPrime[self.m]
        N12 = 12*(NxPrime[0] - NxPrime[self.m] \
            -11/24*(DxPrime[0]-DxPrime[self.m]))
        
        # 순보험료
        NP1_full = SUMx[0] / N1
        NP12_full = SUMx[0] / N12

        # 영업보험료
        G1_full = (NP1_full+self.alpha3*DxPrime[0]/N1+self.beta2*(Nx[self.m]- Nx[self.n])) \
            /(1-self.alpha1*DxPrime[0]/(N1/1)-self.beta1-self.ce-self.gamma)
        
        G12_full = (NP12_full+self.alpha3*DxPrime[0]/N12+self.beta2*(Nx[self.m]- Nx[self.n])) \
            /(1-self.alpha1*DxPrime[0]/(N12/12)-self.beta1-self.ce-self.gamma)


        # 준비금
        tVx_full = [(SUMx[t] -NP1_full*(Nx[t]-Nx[self.m])) / Dx[t] for t in range(self.n+1)]
        tVx = [round(self.AMT*V) for V in tVx_full]


        return {
            'NP1_full' : NP1_full,
            'NP12_full' : NP12_full,
            'G1_full' : G1_full,
            'G12_full' : G12_full,
            'NP1' : round(NP1_full*self.AMT),
            'NP12' : round(NP12_full*self.AMT),
            'G1' : round(G1_full*self.AMT),
            'G12' : round(G12_full*self.AMT),
            'tVx_full' : tVx_full,
            'tVx' : tVx
        }



