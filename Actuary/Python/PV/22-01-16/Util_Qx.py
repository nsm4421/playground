import numpy as np
from tqdm import tqdm
from Util_Dict import Util_Dict

class Util_Qx(Util_Dict):
    def __init__(self, excel_path : str):
        super().__init__(excel_path = excel_path)
        
        # ---- 시작할 때 한번만 하면 되는 내용 ---- #
        
        # Dictionary 세팅
        print('위험률 Dict 세팅')
        self.setQxDict()
        print('담보 Dict 세팅')
        self.setCovDict()
        print('결합위험률정보 세팅')
        self.setCombInfo()
        print('사업비정보 세팅')
        self.setExpenseInfo()
        
        # Qx를 담보 dictionary에 세팅해두기
        print('Qx 세팅')
        self.settingQx()


    def setting(self, coverage : str, injure : int, driver : int, \
        sex : int, x : int, n : int, m : int, AMT : int, i : float):
        """
        계약정보, 위험률, 사업비 세팅
        """
        
        # 계약정보
        self.coverage = (coverage, int(injure), int(driver))  # 담보키
        self.i = float(i)                                  # 적용이율
        self.v = 1/(1+i)                            # 할인율
        self.sex = int(sex)                              # 성별
        self.x = int(x)                                  # 가입연령
        self.n = int(n)                                  # 보험기간
        self.m = int(m)                                  # 납입기간
        self.AMT = int(AMT)                              # 가입금액
        
        # 위험률(Ex, Bx, Gx) 세팅 
        self.setUpQx()      

        # 사업비 세팅
        self.alpha1 = self.CovDict[self.coverage]['Expense'][f'alpha1_n{self.n}']
        self.alpha3 = self.CovDict[self.coverage]['Expense']['alpha3']
        self.beta1 = self.CovDict[self.coverage]['Expense']['beta1']
        self.beta2 = self.CovDict[self.coverage]['Expense']['beta2']
        self.gamma = self.CovDict[self.coverage]['Expense']['gamma']
        self.ce = self.CovDict[self.coverage]['Expense']['ce']
                 

    def settingQx(self):

        """
            담보 Dictionary에 미리 위험률을 세팅해두기
        """

        for (cov_key, cov_dict) in tqdm(self.CovDict.items()):

            numBenefit = cov_dict['NumBenefit']
      
            # (1) 탈퇴율 Setting
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
                #           ---> 결합위험률을 만들 때 사용되는 위험률 배열을 넣기
                elif "C" in eKey[0]:                        
                    comb_dict = self.CovDict[cov_key]['Comb'][eKey]
                    nRiskKey = comb_dict['NumRiskKey']
                    qx_male = [[0.]*120]*nRiskKey
                    qx_female = [[0.]*120]*nRiskKey

                    for i in range(nRiskKey):
                        rKey = comb_dict['RiskKeys'][i]
                        qx_male[i] = self.QxDict[(1, *rKey)]
                        qx_female[i] = self.QxDict[(2, *rKey)]
                    self.CovDict[cov_key]['Comb'][eKey]['Qx'] = [None, np.array(qx_male), np.array(qx_female)]

                # Case 3 : else
                else:
                    Ex_male[i] = self.QxDict[(1, *eKey)]
                    Ex_female[i] = self.QxDict[(2, *eKey)]


            # (2) 급부율 Setting
            BxKey = cov_dict['BxKey']
            Bx_male = [[0.]*120]*(numBenefit+1)
            Bx_female = [[0.]*120]*(numBenefit+1)
            for i in range(1, numBenefit+1):
                bKey = BxKey[i]
                
                # Case 1 : 위험률키 None 
                #           ---> qx = (0,0,0,...)
                if bKey == None:
                    pass        
                
                # Case 2 : 결합위험률
                #           ---> 결합위험률을 만들 때 사용되는 위험률 배열을 넣기
                elif "C" in bKey[0]:                        
                    comb_dict = self.CovDict[cov_key]['Comb'][bKey]
                    nRiskKey = comb_dict['NumRiskKey']
                    qx_male = [[0.]*120]*nRiskKey
                    qx_female = [[0.]*120]*nRiskKey

                    for i in range(nRiskKey):
                        rKey = comb_dict['RiskKeys'][i]
                        qx_male[i] = self.QxDict[(1, *rKey)]
                        qx_female[i] = self.QxDict[(2, *rKey)]
                    self.CovDict[cov_key]['Comb'][bKey]['Qx'] = [None, np.array(qx_male), np.array(qx_female)]

                # Case 3 : else
                else:
                    Bx_male[i] = self.QxDict[(1, *bKey)]
                    Bx_female[i] = self.QxDict[(2, *bKey)]

            # (3) 납면율 Setting
            GxKey = cov_dict['GxKey']
            Gx_male = [0.]*120
            Gx_female = [0.]*120  

            # Case 1 : 위험률키 None 
            #           ---> qx = (0,0,0,...)
            if GxKey == None:
                pass          

            # Case 2 : 결합위험률
            #           ---> 결합위험률을 만들 때 사용되는 위험률 배열을 넣기

            elif "C" in GxKey[0]:                  

                comb_dict = self.CovDict[cov_key]['Comb'][GxKey]
                nRiskKey = comb_dict['NumRiskKey']
                qx_male = [[0.]*120]*nRiskKey
                qx_female = [[0.]*120]*nRiskKey

                for i in range(nRiskKey):
                    rKey = comb_dict['RiskKeys'][i]
                    qx_male[i] = self.QxDict[(1, *rKey)]
                    qx_female[i] = self.QxDict[(2, *rKey)]
                self.CovDict[cov_key]['Comb'][GxKey]['Qx'] = [None, np.array(qx_male), np.array(qx_female)]
            
            # Case 3 : else
            else:
                Gx_male = self.QxDict[(1, *GxKey)]
                Gx_female = self.QxDict[(2, *GxKey)]

            # (4)  탈퇴율, 급부지급율, 납면율을 dictionary에 추가
            self.CovDict[cov_key]['Ex'] = [None, np.array(Ex_male), np.array(Ex_female)]
            self.CovDict[cov_key]['Bx'] = [None, np.array(Bx_male), np.array(Bx_female)]
            self.CovDict[cov_key]['Gx'] = [None, np.array(Gx_male), np.array(Gx_female)]


    def calcCombQx(self, comb_dict : dict) -> list:
        oper = comb_dict['Operation']
        nRiskKey = comb_dict['NumRiskKey']
        periods = comb_dict['Periods']
        qx = comb_dict['Qx'][self.sex]

        if oper == 1:
            qx_comb = np.zeros(120)
            for i in range(nRiskKey):
                for t in range(self.x, self.x+self.n+1):
                    if t == self.x:
                        qx_comb[t] += qx[i,t] * (1-periods[i]/12)
                    else:
                        qx_comb[t] += qx[i,t]

        elif oper == 2:
            qx_comb = np.ones(120)
            
            for i in range(nRiskKey):
                for t in range(self.x, self.x+self.n+1):
                    if t == self.x:
                        qx_comb[t] *= 1-qx[i][t] * (1-periods[i]/12)
                    else:
                        qx_comb[t] *= 1-qx[i][t]

            qx_comb = 1- np.array(qx_comb)
                
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
                self.Gx = combQxDict[GxKey]           


