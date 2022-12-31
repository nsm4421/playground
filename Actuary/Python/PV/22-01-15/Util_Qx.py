from re import I
from tqdm import tqdm
from Util_Dict import Util_Dict

class Util_Qx(Util_Dict):
    def __init__(self, excel_path : str):
        super().__init__(excel_path = excel_path)
        
        # Dictionary 세팅
        print('위험률 Dict 세팅')
        self.setQxDict()
        print('담보 Dict 세팅')
        self.setCovDict()
        print('결합위험률정보 세팅')
        self.setCombInfo()
        
        print('Qx 세팅')
        self.settingQx()


    def setting(self, coverage : str, injure : int, driver : int, \
        sex : int, x : int, n : int, m : int, AMT : int, i : float):
        
        self.coverage = (coverage, injure, driver)
        self.i = i
        self.v = 1/(1+i)
        self.sex = sex
        self.x = x
        self.n = n
        self.m = m
        self.AMT = AMT

        self.setUpQx()

    def settingQx(self):

        for (cov_key, cov_dict) in tqdm(self.CovDict.items()):

            numBenefit = cov_dict['NumBenefit']
      
            # 급부율 Setting
            ExKey = cov_dict['ExKey']
            Ex_male = [[0.]*120]*(numBenefit+1)
            Ex_female = [[0.]*120]*(numBenefit+1)

            for i in range(numBenefit+1):
                eKey = ExKey[i]

                # Case 1 : 위험률키 None 
                #           ---> qx = (0,0,0,...)
                if eKey == None:
                    pass      

                # Case 2 : 결합위험률
                #           ---> 결합위험률을 만들 때 사용되는 위험률 배열
                elif "C" in eKey[0]:                        
                    comb_dict = self.CovDict[cov_key]['Comb'][eKey]
                    nRiskKey = comb_dict['NumRiskKey']
                    qx_male = [[0.]*120]*nRiskKey
                    qx_female = [[0.]*120]*nRiskKey

                    for i in range(nRiskKey):
                        rKey = comb_dict['RiskKeys'][i]
                        qx_male[i] = self.QxDict[(1, *rKey)]
                        qx_female[i] = self.QxDict[(2, *rKey)]
                    self.CovDict[cov_key]['Comb'][eKey]['Qx'] = [None, qx_male, qx_female]

                # Case 3 : else
                else:
                    Ex_male[i] = self.QxDict[(1, *eKey)]
                    Ex_female[i] = self.QxDict[(2, *eKey)]


            # 급부율 Setting
            BxKey = cov_dict['BxKey']
            Bx_male = [[0.]*120]*(numBenefit+1)
            Bx_female = [[0.]*120]*(numBenefit+1)
            for i in range(1, numBenefit+1):
                bKey = BxKey[i]

                if bKey == None:
                    pass        

                elif "C" in bKey[0]:                        
                    comb_dict = self.CovDict[cov_key]['Comb'][bKey]
                    nRiskKey = comb_dict['NumRiskKey']
                    qx_male = [[0.]*120]*nRiskKey
                    qx_female = [[0.]*120]*nRiskKey

                    for i in range(nRiskKey):
                        rKey = comb_dict['RiskKeys'][i]
                        qx_male[i] = self.QxDict[(1, *rKey)]
                        qx_female[i] = self.QxDict[(2, *rKey)]
                    self.CovDict[cov_key]['Comb'][bKey]['Qx'] = [None, qx_male, qx_female]


                else:
                    Bx_male[i] = self.QxDict[(1, *bKey)]
                    Bx_female[i] = self.QxDict[(2, *bKey)]

            # 납입면제율
            GxKey = cov_dict['GxKey']
            if GxKey == None:
                Gx_male = [0.]*120
                Gx_female = [0.]*120
            
            elif "C" in GxKey[0]:                        
                comb_dict = self.CovDict[cov_key]['Comb'][GxKey]
                nRiskKey = comb_dict['NumRiskKey']
                qx_male = [[0.]*120]*nRiskKey
                qx_female = [[0.]*120]*nRiskKey

                for i in range(nRiskKey):
                    rKey = comb_dict['RiskKeys'][i]
                    qx_male[i] = self.QxDict[(1, *rKey)]
                    qx_female[i] = self.QxDict[(2, *rKey)]
                self.CovDict[cov_key]['Comb'][GxKey]['Qx'] = [None, qx_male, qx_female]

            else:
                Gx_male = self.QxDict[(1, *GxKey)]
                Gx_female = self.QxDict[(2, *GxKey)]

            # 탈퇴율, 급부지급율, 납면율을 dictionary에 추가
            self.CovDict[cov_key]['Ex'] = [None, Ex_male, Ex_female]
            self.CovDict[cov_key]['Bx'] = [None, Bx_male, Bx_female]
            self.CovDict[cov_key]['Gx'] = [None, Gx_male, Gx_female]


    def calcCombQx(self, comb_dict : dict) -> list:
        oper = comb_dict['Operation']
        nRiskKey = comb_dict['NumRiskKey']
        periods = comb_dict['Periods']
        qx = comb_dict['Qx'][self.sex]

        if oper == 1:
            qx_comb = [0.]*120
            for i in range(nRiskKey):
                for t in range(self.x, self.x+self.n+1):
                    if t == self.x:
                        qx_comb[t] += qx[i][t] * (1-periods[i]/12)
                    else:
                        qx_comb[t] += qx[i][t]

        elif oper == 2:
            qx_comb = [1.]*120
            for i in range(nRiskKey):
                for t in range(self.x, self.x+self.n+1):
                    if t == self.x:
                        qx_comb[t] *= 1-qx[i][t] * (1-periods[i]/12)
                    else:
                        qx_comb[t] *= 1-qx[i][t]

            for t in range(self.x, self.x+self.n+1):
                qx_comb[t] = 1-qx_comb[t]
                
        return qx_comb


    def setUpQx(self):
        cov_dict = self.CovDict[self.coverage]

        numBenefit = cov_dict['NumBenefit']
        useCombQx = cov_dict['UseCombQx']        
        self.Ex = cov_dict['Ex'][self.sex]    
        self.Bx = cov_dict['Bx'][self.sex]        
        self.Gx = cov_dict['Gx'][self.sex]

        # 결합위험률 사용하는 경우
        if useCombQx:
            combQxDict = {}
            for (comb_riskKey, comb_dict) in self.CovDict[self.coverage]['Comb'].items():
                combQxDict[comb_riskKey] = self.calcCombQx(comb_dict)
                 
            ExKey = cov_dict['ExKey']
            for i in range(numBenefit+1):
                eKey = ExKey[i]
                if eKey == None:
                    pass
                elif "C" in eKey[0]:
                    self.Ex[i] = combQxDict[eKey]

            BxKey = cov_dict['BxKey']
            for i in range(1, numBenefit+1):
                bKey = BxKey[i]
                if "C" in bKey[0]:
                    self.Bx[i] = combQxDict[bKey]
            
            GxKey = cov_dict['GxKey']
            if GxKey == None:
                pass
            elif "C" in GxKey[0]:
                self.Gx[i] = combQxDict[GxKey]           


