from Util_Qx import Util_Qx
import numpy as np
import pandas as pd

class Calc_Symbol(Util_Qx):
    def __init__(self, excel_path : str):
        super().__init__(excel_path=excel_path)


    # 기수계산
    def calcSymbol(self):

        # 담보 dictionary에서 검증대상건의 정보 추출
        cov_dict = self.CovDict[self.coverage]
        numBenefit = cov_dict['NumBenefit']
        nonCov = cov_dict['NonCov']
        payRate = cov_dict['PayRate']
        reduceRate = cov_dict['ReduceRate']
        reducePeriod = cov_dict['ReducePeriod']
        invalidPeriod = cov_dict['InvalidPeriod']

        # Ex, Bx, Gx 배열 세팅
        self.setUpQx()
        
        lx = np.zeros(shape=(numBenefit+1, self.n+1))
        lxPrime = np.zeros(shape=(self.n+1))
        
        Dx = np.zeros(shape=(self.n+1))
        DxPrime = np.zeros(shape=(self.n+1))
        
        Nx = np.zeros(shape=(self.n+1))
        NxPrime = np.zeros(shape=(self.n+1))

        Cx = np.zeros(shape=(numBenefit+1, self.n+1))
        Mx = np.zeros(shape=(numBenefit+1, self.n+1))
        
        SUMx = np.zeros(shape=(self.n+1))

        # lx
        for bNum in range(numBenefit+1):
            lx[bNum, 0] = 100000
            for t in range(self.n):
                if t == 0:
                    lx[bNum, t+1] = lx[bNum, t] * (1 - self.Ex[bNum, self.x+t]*(1-nonCov[bNum]))
                else:
                    lx[bNum, t+1] = lx[bNum, t] * (1 - self.Ex[bNum, self.x+t])

        # l'x
        for bNum in range(numBenefit+1):
            lxPrime[0] = 100000
            for t in range(self.n):
                if t == 0:
                    lxPrime[t+1] = lxPrime[t] * (1 - self.Gx[self.x+t]*(1-invalidPeriod))
                else:
                    lxPrime[t+1] = lxPrime[t] * (1 - self.Gx[self.x+t])


        # Dx, D'x
        Dx = lx[0]*self.v**np.arange(self.n+1)
        DxPrime = lxPrime*(self.v**np.arange(self.n+1))
        
        # Nx , N'x
        Nx[-1] = Dx[-1]
        NxPrime[-1] = DxPrime[-1]
        for t in range(self.n)[::-1]:
            Nx[t] = Nx[t+1]+Dx[t]  
            NxPrime[t] = NxPrime[t+1]+DxPrime[t]  

                    
        # Cx
        for i in range(1, numBenefit+1):
            Cx[i] = lx[i] * self.Bx[i][self.x:self.x+self.n+1] * (self.v ** (np.arange(self.n+1)+0.5))

        # Mx
        for i in range(1, numBenefit+1):
            Mx[i, -1] = Cx[i, -1]
            for t in range(self.n)[::-1]:
                Mx[i, t] = Cx[i, t] + Mx[i, t+1]

        # SUMx
        for i in range(1, numBenefit+1):
            pRate = payRate[i]              # 지급률
            rPeriod = reducePeriod[i]       # 감액기간
            rRate = reduceRate[i]           # 감액률
            for t in range(self.n+1):
                # 감액기간 내
                if t-self.x<reducePeriod[i]:
                    SUMx[t] += pRate * ((1-rRate) * (Mx[i, t]-Mx[i, rPeriod]) + \
                        (Mx[i, rPeriod] - Mx[i, self.n]))
                # 감액기간 후
                else:
                    SUMx[t] += pRate * (Mx[i, t] - Mx[i, self.n])

        # 기수식 dictionary 세팅
        self.SymbolDict = {
            'lx' : lx,
            "l'x" : lxPrime,
            "Dx" : Dx,
            "D'x" : DxPrime,
            "Nx" : Nx,
            "N'x" : NxPrime,
            "Cx" : Cx,
            "Mx" : Mx,
            "SUMx" : SUMx
        }   


    # 기수표 출력
    def getSymbolDataFrame(self) -> pd.DataFrame:

        # 기수식 계산
        self.calcSymbol()
        
        df = {}
        cov_dict = self.CovDict[self.coverage]
        numBenefit = cov_dict['NumBenefit']

        # 탈퇴율
        for i in range(numBenefit+1):
            df[f"Ex({i})"] = self.Ex[i][self.x:self.x+self.n+1]

        # 급부율
        for i in range(1, numBenefit+1):
            df[f"Bx({i})"] = self.Bx[i][self.x:self.x+self.n+1]   

        # 납입면제율
        df['Gx'] = self.Gx[self.x:self.x+self.n+1]

        # 기수식s
        df['Dx'] = self.SymbolDict['Dx']
        df["D'x"] = self.SymbolDict["D'x"]
        df['Nx'] = self.SymbolDict['Nx']
        df["N'x"] = self.SymbolDict["N'x"]

        for i in range(numBenefit+1):
            df[f"lx({i})"] = self.SymbolDict['lx'][i]

        for i in range(1, numBenefit+1):
            df[f"Cx({i})"] = self.SymbolDict['Cx'][i]

        for i in range(1, numBenefit+1):
            df[f"Mx({i})"] = self.SymbolDict['Mx'][i]

        df["SUMx"] = self.SymbolDict["SUMx"]

        # dictionary ---> dataframe 
        df = pd.DataFrame(df)

        # index 달아주기 (x, x+1, ...., x+n)
        df.index = range(self.x,self.x+self.n+1)

        return df

       