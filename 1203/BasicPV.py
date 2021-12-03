import json
import numpy as np
import pandas as pd


class BasicPV:
    def __init__(self, QxJson : str = './Qx.json', CovJson : str = './Coverage.json', CombJson : str = './Comb.json'):

        self.v = 1/(1+0.025)

        self.fillNa = "^"
        self.w = 120
        self.maxNumBenefit = 10

        # Json 파일 읽기
        with open(QxJson, 'r') as j:
            self.Qx_dict  = json.load(j)        
        with open(CovJson, 'r') as j:
            self.Coverage_dict  = json.load(j)       
        with open(CombJson, 'r') as j:
            self.Comb_dict  = json.load(j)       

        
        # Init symbols
        self.lx = np.zeros((self.maxNumBenefit+1, self.w))
        self.lxPrime = np.zeros(self.w)                              # 납입자
        
        self.qx_exit = np.zeros((self.maxNumBenefit+1, self.w))
        self.qx_benefit = np.zeros((self.maxNumBenefit, self.w))
        self.qx_grant = np.zeros(self.w)
        
        self.Dx = np.zeros(self.w)   
        self.Nx = np.zeros(self.w)   
        self.DxPrime = np.zeros(self.w)   
        self.NxPrime = np.zeros(self.w)

        self.Cx = np.zeros((self.maxNumBenefit, self.w))  
        self.Mx = np.zeros((self.maxNumBenefit, self.w))  
        self.SUMx = np.zeros(self.w)  


    def clearSymbols(self):
        for i in range(self.maxNumBenefit+1):
            for t in range(self.w):
                self.lx[i, t] = 0.
                self.qx_exit[i, t] = 0.

        for i in range(self.maxNumBenefit):
            for t in range(self.w):
                self.qx_benefit[i, t] = 0.
                self.Cx[i, t] = 0.
                self.Mx[i, t] = 0.               

        for t in range(self.w):
            self.qx_grant[t] = 0.
            self.lxPrime[t] = 0.
            self.Dx[t] = 0.
            self.DxPrime[t] = 0.
            self.Nx[t] = 0.
            self.NxPrime[t] = 0.
            self.SUMx[t] = 0.

    def setArgs(self, x : int = None, sex : int = None, n : int = None, m : int = None, injure : int = None, driver : int = None, AMT : int = None, coverageKey : str = None):
        if x!=None:self.x = x 
        if sex!=None:self.sex = sex 
        if n!=None:self.n = n 
        if m!=None:self.m = m 
        if injure!=None:self.injure = injure 
        if driver!=None:self.driver = driver 
        if AMT!=None:self.AMT = AMT 
        if coverageKey!=None:
            self.coverageKey = coverageKey 
            self.covInfo = self.Coverage_dict[coverageKey]

    def parsingCoverageInfo(self):

        self.NumBenefit = self.covInfo['NumBenefit']    
        # 탈퇴
        self.ExitCode = self.covInfo['ExitCode']
        self.ExitType = self.covInfo['ExitType']
        self.NonCov =  np.array(self.covInfo['NonCov'])
        
        # 급부
        self.BenefitCode = self.covInfo['BenefitCode']
        self.BenefitType = self.covInfo['BenefitType']
        self.PayRate =  np.array(self.covInfo['PayRate'])
        self.ReduceRate =  np.array(self.covInfo['ReduceRate'])
        self.ReducePeriod =  np.array(self.covInfo['ReducePeriod'])

        # 납입면제
        self.GrantCode = self.covInfo['GrantCode']
        self.GrantType = self.covInfo['GrantType']
        self.InvalidPeriod =  self.covInfo['InvalidPeriod']
  
    def getQx(self, riskKey : str, riskType : str = None):
        if riskKey == self.fillNa:
            return np.zeros(self.w)
        elif riskType == self.fillNa:
            return self.Qx_dict[riskKey][str(self.sex)]
        # 상해급수
        elif riskType == "I":
            return self.Qx_dict[riskKey+f"_{self.injure}"][str(self.sex)]
        # 운전자급수
        elif riskType == "D":
            return self.Qx_dict[riskKey+f"_{self.driver}"][str(self.sex)]
        # 결합위험률
        elif riskType == "C":
            return self.getCombQx(riskKey)
        else:
            try:
                return self.Qx_dict[riskKey][str(self.sex)]
            except Exception as e:
                raise print(e)


    def getCombQx(self, combRiskKey : str):
        # Unpack
        combInfo = self.Comb_dict[combRiskKey]
        numRiskKey = combInfo['NumRisKey']
        riskKeys = combInfo['RiskKeys']
        periods = combInfo['Periods']
        operation = combInfo['Operation']
        qx_array = np.zeros((numRiskKey, self.w))

        for i in range(numRiskKey):
            qx_array[i] = self.Qx_dict[riskKeys[i]][str(self.sex)]
            qx_array[:, self.x] *= 1-periods[i]/12

        if operation == 1:
            return np.sum(qx_array, axis = 0)
        elif operation == 2:
            return 1 - np.product(1 - qx_array, axis = 0)

    def qxMapping(self):
        # 탈퇴율 mapping
        for i in range(self.NumBenefit+1):
            self.qx_exit[i] = self.getQx(self.ExitCode[i], self.ExitType[i])
        # 급부율 mapping
        for i in range(self.NumBenefit):
            self.qx_benefit[i] = self.getQx(self.BenefitCode[i], self.BenefitType[i])
        # 납면율 mapping
        self.qx_grant = self.getQx(self.GrantCode, self.GrantType)

    def calcSymbols(self):
    
        # lx, l'x
        self.lx[:, self.x] = 100000
        self.lxPrime[self.x] = 100000
        for i in range(self.x, self.x+self.n):
            if i == 0:
                self.lx[:, i+1] = self.lx[:, i] * (1-self.qx_exit[:, i]*(1-self.NonCov/12))
                self.lxPrime[i+1] = self.lxPrime[i] *(1-self.qx_grant[i] * (1-self.InvalidPeriod/12))
            else:
                self.lx[:, i+1] = self.lx[:, i] * (1-self.qx_exit[:, i])
                self.lxPrime[i+1] = self.lxPrime[i] *(1-self.qx_grant[i])

        # Dx, D'x
        self.Dx[self.x:] = self.lx[0, self.x:] * self.v ** np.arange(self.w-self.x)
        self.DxPrime[self.x:] = self.lxPrime[self.x:] * self.v ** np.arange(self.w-self.x)

        # Nx, N'x
        for t in range(self.x, self.x+self.n+1)[::-1]:
            self.Nx[t] = self.Nx[t+1] + self.Dx[t]
            self.NxPrime[t] = self.NxPrime[t+1] + self.DxPrime[t]
        
        # Cx, Mx, SUMx
        for i in range(self.NumBenefit):
            pRate, rRate, rPeriod = self.PayRate[i], self.ReduceRate[i], self.ReducePeriod[i]
            self.Cx[i] = self.lx[i+1]*self.qx_benefit[i] * self.v ** (np.arange(self.w) - self.x+0.5)
            for t in range(self.x, self.x+self.n+1)[::-1]:
                self.Mx[i, t] = self.Mx[i, t+1] + self.Cx[i, t]
            for t in range(self.x, self.x+self.n+1):
                if t - self.x < self.ReducePeriod[i]:
                    self.SUMx[t] += pRate((1-rRate)*(self.Mx[i, t] - self.Mx[i, self.x+rPeriod]) + \
                        (self.Mx[i, self.x+rPeriod] - self.Mx[i, self.x+self.n]))
                else:
                    self.SUMx[t] += pRate*(self.Mx[i, t] - self.Mx[i, self.x+self.n])

    def clearSymbols(self):
        for i in range(self.maxNumBenefit+1):
            for t in range(self.w):
                self.lx[i, t] = 0.
                self.qx_exit[i, t] = 0.

        for i in range(self.maxNumBenefit):
            for t in range(self.w):
                self.qx_benefit[i, t] = 0.
                self.Cx[i, t] = 0.
                self.Mx[i, t] = 0.               

        for t in range(self.w):
            self.qx_grant[t] = 0.
            self.lxPrime[t] = 0.
            self.Dx[t] = 0.
            self.DxPrime[t] = 0.
            self.Nx[t] = 0.
            self.NxPrime[t] = 0.
            self.SUMx[t] = 0.


    def getSymbolTable(self):
        df = {}

        df['x+t'] = range(self.x, self.x+self.n+1)

        for i in range(self.NumBenefit+1):
            df[f"qx_exit({i})"] = self.qx_exit[i, self.x:self.x+self.n+1]
            df[f"lx({i})"] = self.lx[i, self.x:self.x+self.n+1]
        for i in range(self.NumBenefit):
            df[f"qx_benefit({i+1})"] = self.qx_benefit[i, self.x:self.x+self.n+1]
            df[f"lx_benefit({i+1})"] = self.lx[i, self.x:self.x+self.n+1]
            df[f"Cx({i+1})"] = self.Cx[i, self.x:self.x+self.n+1]
            df[f"Mx({i+1})"] = self.Mx[i, self.x:self.x+self.n+1]

        df['SUMx'] = self.SUMx[self.x:self.x+self.n+1]

        df["qx_grant"] = self.qx_grant[self.x:self.x+self.n+1]
        df["l'x"] = self.lxPrime[self.x:self.x+self.n+1]

        df["Dx"] = self.Dx[self.x:self.x+self.n+1]
        df["Nx"] = self.Nx[self.x:self.x+self.n+1]

        df["D'x"] = self.DxPrime[self.x:self.x+self.n+1]
        df["N'x"] = self.NxPrime[self.x:self.x+self.n+1]

        return pd.DataFrame(df)

        