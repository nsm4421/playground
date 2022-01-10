from re import L
import numpy as np
import pandas as pd
from tqdm import tqdm

class Util:
    def __init__(self, excel_path : str):
        self.excel_path = excel_path

    def getQxDict(self):
        df_Qx = pd.read_excel(self.excel_path, sheet_name="위험률", header = 3).fillna(0)
        cols = ['상해급수', '운전자급수']

        riskKeys = []
        for row in df_Qx[['위험률코드'] + cols + ['x', '남자', '여자']].values:
            rCode, injure, driver, x, male, female = row
            rKey = f"{rCode}_{int(injure)}_{int(driver)}"
            riskKeys.append(rKey)
        df_Qx['위험률키'] = riskKeys

        riskKeys = set(riskKeys)

        Qx_dict = {}

        for rKey in tqdm(riskKeys):
            qx_male, qx_female = [0.]*120, [0.]*120
            df_q = df_Qx.loc[df_Qx['위험률키'] == rKey][['x', '남자', '여자']]
            for x, male, female in df_q.values:
                if x == "ZZ":   # 단일률
                    qx_male = [male for _ in range(120)]
                    qx_female = [male for _ in range(120)]
                    break
                else:
                    qx_male[int(x)] = male
                    qx_female[int(x)] = female
            Qx_dict[f"{1}_{rKey}"] = qx_male
            Qx_dict[f"{2}_{rKey}"] = qx_female

        return Qx_dict


    def getCodeDict(self):
        df_Code = pd.read_excel(self.excel_path, sheet_name="코드", header = 3).fillna("")
        df_Code = df_Code[['담보키', '급부번호',\
            '탈퇴율코드', '탈퇴율Type', '부담보기간',\
                    '급부율코드', '급부율Type', '지급률', '감액률', '감액기간', \
                            '납면율코드', '납면율Type', '면책기간']]
        covKeys = np.unique(df_Code['담보키'].values)

        Coverage_dict = {}

        for covKey in tqdm(covKeys):

            coverage_info = {}
            df_c = df_Code[df_Code['담보키'] == covKey]
            numBenefit = 0      # 급부개수
            useCombQx = False   # 결합위험률 적용 여부
            useSingleQx = False # 단일률 적용 여부
            
            ExCode = [None]*10
            ExType = [None]*10
            NonCov = [None]*10
            BxCode = [None]*10
            BxType = [None]*10
            PayRate = [None]*10
            ReduceRate = [None]*10
            ReducePeriod = [None]*10
            GxCode = None
            GxType = None
            InvalidPeriod = None

            for row in df_c.values:
                _, bNum, eCode, eType, nCov, bCode, bType, pRate, rRate, rPeriod, gCode, gType, iPeriod = row

                if (eType == "C") | (bType == "C") | (gType == "C"):
                    useCombQx = True
                if (eType == "S") | (bType == "S") | (gType == "S"):
                    useSingleQx = True
                
                if bNum == 99:  # 납입면제 (grant)
                    GxCode = gCode
                    GxType = gType
                    InvalidPeriod = 0 if iPeriod == "" else int(iPeriod)

                else:

                    ExCode[bNum] = eCode
                    ExType[bNum] = eType
                    NonCov[bNum] = 0 if nCov == "" else int(nCov)

                    if bNum != 0:

                        BxCode[bNum] = bCode
                        BxType[bNum] = bType
                        PayRate[bNum] = 1. if pRate == "" else float(pRate)
                        ReducePeriod[bNum] = 0 if rPeriod == "" else int(rPeriod)
                        ReduceRate[bNum] =  0. if rRate == "" else float(rRate)

                        numBenefit += 1
            
            coverage_info["NumBenefit"] = numBenefit    # 급부개수

            coverage_info["ExCode"] = ExCode[:numBenefit+1]    
            coverage_info["ExType"] = ExType[:numBenefit+1]    
            coverage_info["NonCov"] = NonCov[:numBenefit+1]    
            
            coverage_info["BxCode"] = BxCode[:numBenefit+1]   
            coverage_info["BxType"] = BxType[:numBenefit+1]   
            coverage_info["PayRate"] = PayRate[:numBenefit+1]   
            coverage_info["ReduceRate"] = ReduceRate[:numBenefit+1]   
            coverage_info["ReducePeriod"] = ReducePeriod[:numBenefit+1]   

            coverage_info["GxCode"] = GxCode
            coverage_info["GxType"] = GxType
            coverage_info["InvalidPeriod"] = InvalidPeriod

            coverage_info["UseSingleQx"]= useSingleQx   # 단일률적용여부
            coverage_info["UseCombQx"] = useCombQx      # 결합위험률적용여부
            coverage_info['CombInfo'] = {}
            Coverage_dict[covKey] = coverage_info
            

        return Coverage_dict


    def setCombInfo(self):
        df_Comb = pd.read_excel(self.excel_path, sheet_name="결합위험률", header=3).fillna("")
        df_Comb = df_Comb[['담보키', '결합위험률코드', 'Operation', '위험률개수'] \
            + [f"위험률코드({i})" for i in range(1, 8+1)] \
                + [f"제외기간({i})" for i in range(1, 8+1)]]
        covKeys_comb = np.unique(df_Comb['담보키'].values)
        for covKey in covKeys_comb:
            comb_info = {}
            df_c = df_Comb.loc[df_Comb['담보키'] == covKey]
            for row in df_c.values:
                _, combRiskKey, oper, nRiskKey = row[:4]
                rCodes = row[4:4+8][:nRiskKey]
                periods = row[12:12+8][:nRiskKey]
                periods = [0 if p=="" else int(p) for p in periods]
                comb_info[combRiskKey] = {
                    "Operation" : int(oper),
                    "RiskCodes" : rCodes,
                    "Periods" : periods
                }
            self.Coverage_dict[covKey]["CombInfo"] = comb_info

    def getQx(self, sex : int, riskCode : str, injure : int, driver : int) -> list:
        riskKey = self.getRiskKey(sex, riskCode, injure, driver)
        return self.Qx_dict[riskKey]

    def getCombQxDict(self, comb_info : dict, sex : int, x : int) -> dict:

        result = {}    
        for (combRiskKey, info) in comb_info.items():
            oper = info["Operation"]
            rCodes = info["RiskCodes"]
            periods = info["Periods"]

            numRiskCode = len(rCodes)
            qx = [[0.]*120]*numRiskCode

            for i in range(numRiskCode):

                if rCodes[i] in result.keys():
                    qx[i] = result[rCodes[i]]
                else:
                    qx[i] = self.getQx(sex = sex, riskCode = rCodes[i], injure = 0, driver = 0)    

            if oper == 1:

                combQx = [0.]*120
                for i in range(numRiskCode):
                    for t in range(120):
                        if t == x:
                            combQx[t] += qx[i][t] * (1-periods[i]/12)
                        else:
                            combQx[t] += qx[i][t] 


            elif oper == 2:

                combQx = [1.]*120
                for i in range(numRiskCode):
                    for t in range(120):
                        if t == x:
                            combQx[t] *= 1-qx[i][t]* (1-periods[i]/12)
                        else:
                            combQx[t] *= 1-qx[i][t] 
                for t in range(120):
                    combQx[t] = 1-combQx[t]

            else:
                raise Exception("결합위험률 계산방법이 이상허게 들어옴")
            
            result[combRiskKey] = combQx

        return result
            
    def QxMapping(self, covKey : str, sex:int, x:int, n:int, injure : int, driver : int):
        coverage_info = self.Coverage_dict[covKey]

        numBenefit = coverage_info['NumBenefit']
        Ex = [[0.]*(n+1)]*(numBenefit+1)
        Bx = [[0.]*(n+1)]*(numBenefit+1)

        if coverage_info['UseCombQx']:
            combQxDict = self.getCombQxDict(coverage_info['CombInfo'], sex, x)
            
        for i in range(numBenefit+1):
            eCode = coverage_info[i]['Exit']['ExCode']
            eType = coverage_info[i]['Exit']['ExType']
            if eType == "C":
                Ex[i] = combQxDict[eCode][x:x+n+1]
            else:
                Ex[i] = self.getQx(sex = sex, riskCode=eCode, injure = injure, driver = driver)[x:x+n+1]

            if i>0:
                bCode = coverage_info[i]['Benefit']['BxCode']
                bType = coverage_info[i]['Benefit']['BxType']

                if bType == "C":
                    Bx[i] = combQxDict[bCode][x:x+n+1]
                else:
                    Bx[i] = self.getQx(sex = sex, riskCode=bCode, injure = injure, driver = driver)[x:x+n+1]

        
        gCode = coverage_info[99]['GxCode']
        gType = coverage_info[99]['GxType']
        if gType == "C":
            Gx = combQxDict[gCode][x:x+n+1]
        else:
            Gx = self.getQx(sex = sex, riskCode=gCode, injure=injure,driver=driver)[x:x+n+1]

        return Ex, Bx, Gx

    @staticmethod
    def getRiskKey(sex, riskCode, injure, driver):
        return f"{sex}_{riskCode}_{injure}_{driver}" 



class Calc:
    def __init__(self, i : float):
        self.v = 1/(1+i)


    def getSymbols(self, Ex : list, Bx : list, Gx : list, numBenefit : int, \
        nonCov : list, payRate : list, reduceRate : list, reducePeriod : list, invalidPeriod : list, n:int, v:int):

        # init
        lx = [[0.]*(n+1)]*(numBenefit+1)
        lxPrime = [0.]*(n+1)
        Nx = [0.]*(n+1)
        NxPrime = [0.]*(n+1)
        Cx = [[0.]*(n+1)]*(numBenefit+1)
        Mx = [[0.]*(n+1)]*(numBenefit+1)
        SUMx = [0.]*(n+1)

        # lx
        for i in range(numBenefit+1):
            lx[i][0] = 100000
            for t in range(n):
                if t == 0:
                    lx[i][t+1] = lx[i][t]*(1-Ex[i][t] * (1-nonCov[i]/12))   # 부담보
                else:
                    lx[i][t+1] = lx[i][t]*(1-Ex[i][t])
        # Dx
        Dx = [lx[0][t]*v**t for t in range(n+1)]
        # Nx
        for t in range(n)[::-1]:
            Nx[t] = Nx[t+1] + Dx[t]
            
        
        # l'x
        lxPrime[0] = 100000
        for t in range(n):
            if t==0:
                lxPrime[t+1] = lxPrime[t]*(1-Gx[t] * (1-invalidPeriod/12))
            else:
                lxPrime[t+1] = lxPrime[t]*(1-Gx[t])
        # D'x
        DxPrime = [lxPrime[t]*v**t for t in range(n+1)]
        # N'x
        for t in range(n)[::-1]:
            NxPrime[t] = NxPrime[t+1] + DxPrime[t]
            

        # Cx
        for i in range(1, numBenefit+1):
            Cx[i] = [lx[i][t]*Bx[i][t]*v**(t+0.5) for t in range(n+1)]

        # Mx
        for i in range(1, numBenefit+1):
            for t in range(n)[::-1]:
                Mx[i][t] = Cx[i][t] + Mx[i][t+1]

        # SUMx
        for i in range(1, numBenefit+1):
            pRate = payRate[i]
            rPeriod = reducePeriod[i]
            rRate = reduceRate[i]
            for t in range(n+1):
                if t<reducePeriod[i]:
                    SUMx[t] += pRate * ((1-rRate) * (Mx[t]-Mx[rPeriod]) + \
                        (Mx[rPeriod] - Mx[n]))
                else:
                    SUMx[t] += pRate * (Mx[t] - Mx[n])

        return {
            'lx' : lx,
            "l'x" : lxPrime,
            "Dx" : Dx,
            "D'x" : DxPrime,
            "Nx" : Dx,
            "N'x" : DxPrime,
            "Cx" : Cx,
            "Mx" : Mx,
            "SUMx" : SUMx
        }   


class karma(Util, Calc):
    def __init__(self, excel_path : str, i : float):
        super(Util, self).__init__(excel_path = excel_path)
        super(Calc, self).__init__(i=i)

    def setDict(self):
        self.Qx_dict = self.getQxDict()     
        self.Coverage_dict = self.getCodeDict()
        self.setCombInfo()

    def setContractInfo(self, coverage : str, x : int, n : int, m : int, injure : int, driver : int):
        self.coverage = coverage
        self.x = x
        self.n = n
        self.m = m
        self.injure = injure
        self.driver = driver

    def setCoverageInfo(self, coverageKey : str):
        self.key = coverageKey
        covInfo = self.Coverage_dict[coverageKey]
        self.numBenefit = covInfo["NumBenefit"]
        self.UseSingleQx = covInfo["UseSingleQx"]
        self.UseCombQx = covInfo["UseCombQx"]

        self.Ex = covInfo["Ex"]
        self.Bx = covInfo["Bx"]
        self.Gx = covInfo["Gx"]

        self.NonCov = covInfo["NonCov"]
        self.PayRate = covInfo["PayRate"]
        self.ReduceRate = covInfo["ReduceRate"]
        self.ReducePeriod = covInfo["ReducePeriod"]
        self.InvalidPeriod = covInfo["InvalidPeriod"]
   

    def QxMapping(self):
        self.Ex, self.Bx, self.Gx = super().QxMapping(self.coverage, self.sex, self.x, self.n, self.injure, self.driver)

    def getSymbols(self):
        self.Symbols = super().getSymbols(self.Ex, self.Bx, self.Gx, self.numBenefit, \
            self.NonCov, self.PayRate, self.ReduceRate, self.ReducePeriod, self.InvalidPeriod, self.n, self.v)