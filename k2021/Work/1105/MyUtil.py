import numpy as np
import pandas as pd

class MyUtil:
    def __init__(self):
        self.excel_file='./실속있는보장보험_STD.xlsx'
        self.fillNa = "ZZ"

        # Excel 시트 읽기
        self.readExcelSheet(excel_file=self.excel_file, fillNa=self.fillNa)

    def readExcelSheet(self, excel_file :str, fillNa : str):
        # 위험률시트
        self.sht_rate = pd.read_excel(excel_file, sheet_name="위험률", header=2)
        self.sht_rate = self.sht_rate[['RiskCode','Sub1','Sub2','Sub3', 'x', 'Male','Female']].fillna(self.fillNa)
        for col in ['Male', 'Female']:
            self.sht_rate[col] = self.sht_rate[col].apply(lambda x:0 if x==self.fillNa else np.double(x))

        # 코드시트         
        self.sht_code = pd.read_excel(excel_file, sheet_name="코드", header=2)
        self.sht_code = self.sht_code.fillna(self.fillNa )
        self.sht_code = self.sht_code[['Coverage', 'BenefitNum', 'ExitCode', 'ExitType', 'NonCov',\
            'BenefitCode', 'BenefitType', 'DefryRate', 'ReducRate', 'ReducPeriod', \
                'GrantCode', 'GrantType', 'InvalidPeriod']] 
        for col in ['NonCov', 'ReducPeriod', 'InvalidPeriod']:
            self.sht_code[col] = self.sht_code[col].apply(lambda x:0 if x==self.fillNa  else int(x))
        for col in ['ReducRate', 'DefryRate']:
            self.sht_code[col] = self.sht_code[col].apply(lambda x:0 if x==self.fillNa  else float(x))
        self.sht_code = self.sht_code.astype({'NonCov' : int, 'ReducRate' : float, 'DefryRate' : float, 'ReducPeriod' : int, 'InvalidPeriod' : int})

        # 결합위험률 시트
        sht_comb = pd.read_excel(excel_file, sheet_name="결합위험률", header=2)
        sht_comb = sht_comb[['Coverage', 'CombRiskCode', 'Operation', 'NumRiskCode'] \
            + [f"RiskCode({i})" for i in range(1, 8+1)] + [f"Period({i})" for i in range(1, 8+1)]].fillna(self.fillNa)
        # null값 처리
        for col in [f"Period({i})" for i in range(1, 8+1)]:
            sht_comb[col] = sht_comb[col].apply(lambda x:0 if x==self.fillNa  else int(x))
        # dtype
        self.sht_comb = sht_comb.astype({'Operation' : int, 'NumRiskCode' : int, \
            'Period(1)' : int, 'Period(2)' : int, 'Period(3)' : int, 'Period(4)' : int, \
                'Period(5)' : int, 'Period(6)' : int, 'Period(7)' : int, 'Period(8)' : int})

    def gatherInfo(self, coverage : str, sex : int = 1, x : int = 40, n : int = 80, injure : int = None, driver : int = None) -> dict:
        """
        Coverage를 입력하면 필요한 정보를 추출
        """
        df_code = self.sht_code.loc[self.sht_code['Coverage'] == coverage]
        if df_code.shape[0] == 0:raise Exception(f"Coverage {coverage}로 조회되는 정보가 없음")

        # 결합위험률 생성
        self.comb_dict = self.getCombQx(coverage=coverage, x=x, sex=sex, n=n)
        
        # 탈퇴
        ExitInfo = {}
        for row in df_code[['BenefitNum','ExitCode','ExitType','NonCov']].values:
            # unpack
            benefitNum, exitCode, exitType, nonCov = row
            # BenefitNum 0~98
            if benefitNum != 99:
                qx_exit = self.QxMapping(riskCode=exitCode, sex=sex, x=x, n=n, riskType=exitType, driver=driver, injure=injure)              
                ExitInfo[benefitNum] = {'RiskCode' : exitCode, 'RiskType' : exitType, 'qx' : qx_exit, 'NonCov' : nonCov}

        # 급부지급
        BenefitInfo = {}
        num_benefit = 0
        for row in df_code[['BenefitNum','BenefitCode','BenefitType','DefryRate', 'ReducRate', 'ReducPeriod']].values:
            # unpack
            benefitNum, benefitCode, benefitType, defryRate, reducRate, reducPeriod = row
            # BenefitNum 1~98
            if benefitNum!=0 and benefitNum!=99:
                num_benefit +=1
                qx_benefit = self.QxMapping(riskCode=benefitCode, sex=sex, x=x, n=n, riskType=benefitType, driver=driver, injure=injure)
                BenefitInfo[benefitNum] = {'RiskCode' : benefitCode, 'RiskType' : benefitType, 'qx' : qx_benefit, \
                        'DefryRate' : defryRate, 'ReducRate' : reducRate, 'ReducPeriod' : reducPeriod}
        # 납면
        GrantInfo = {}        
        for row in df_code[['BenefitNum','GrantCode','GrantType','InvalidPeriod']].values:
            # unpack
            benefitNum, grantCode, grantType, invalidPeriod = row
            # BenefitNum 99
            if benefitNum == 99:
                qx_grant = self.QxMapping(riskCode=grantCode, sex=sex, x=x, n=n, riskType=grantType, driver=driver, injure=injure)    
                GrantInfo[benefitNum] = {'RiskCode' : grantCode, 'RiskType' : grantType, 'qx' : qx_grant, 'InvalidPeriod' : invalidPeriod}     

        return {'Exit' : ExitInfo, 'Benefit' : BenefitInfo, 'Grant' : GrantInfo, 'NumBenefit' : num_benefit}


    #  -------------------------------------- 위험률매핑 --------------------------------------  #

    def QxMapping(self, riskCode : str, sex : int, x : int, n : int, riskType : str, driver : int, injure : int)->np.array:
        # 위험률 코드 無 ---> qx = 0
        if riskCode == self.fillNa: 
            return np.zeros(shape=(n+1))
        # 일반적인 경우
        elif riskType.upper() == self.fillNa:
            return self.getQx(riskCode=riskCode,sex=sex,x=x,n=n)
        # 결합위험률
        elif riskType.upper() == "C":
            return self.comb_dict[riskCode]    
        # 이차위험률 (상해급수)
        elif riskType.upper() ==  "M": 
            return self.getMatrixQx(riskCode=riskCode, sex=sex, x=x, n=n, injure=injure)
        # 이차위험률 (운전자급수)
        elif riskType.upper() ==  "M2": 
            return self.getMatrixQx2(riskCode=riskCode, sex=sex, x=x, n=n,driver=driver)
        # 단일률
        elif riskType.upper() == "S":
            return self.getSingleQx(riskCode=riskCode, sex=sex, n=n)
        else:
            raise Exception(f'위험률 코드 {riskCode} / 타입 {riskType} 에러')


    def getQx(self, riskCode : str, sex : int, x : int, n : int) -> np.array:
        condition = (riskCode == self.sht_rate['RiskCode']) 
        qx = np.zeros(n+1)
        if sex == 1:
            for (t,male) in self.sht_rate.loc[condition][['x', 'Male']].values:
                if 0<=t-x and t-x<n+1:
                    qx[int(t-x)] = male
        else:
            for (t,female) in self.sht_rate.loc[condition][['x', 'Female']].values:
                if 0<=t-x and t-x<n+1:
                    qx[int(t-x)] = female
        return qx

    # 상해급수
    def getMatrixQx(self, riskCode, sex, x, n, injure) -> np.array:
        condition = (riskCode == self.sht_rate['RiskCode']) & (int(injure) == self.sht_rate['Sub2'])   
        qx = np.zeros(n+1)
        if sex == 1:
            for (t,male) in self.sht_rate.loc[condition][['x', 'Male']].values:
                if 0<=t-x and t-x<n+1:
                    qx[int(t-x)] = male
        else:
            for (t,female) in self.sht_rate.loc[condition][['x', 'Female']].values:
                if 0<=t-x and t-x<n+1:
                    qx[int(t-x)] = female
        return qx            

    # 운전자
    def getMatrixQx2(self, riskCode, sex, x, n, driver) -> np.array:
        try:
            condition = (riskCode == self.sht_rate['RiskCode']) & (driver == self.sht_rate['Sub3'])    
            qx = np.zeros(n+1)
            if sex == 1:
                for (t,male) in self.sht_rate.loc[condition][['x', 'Male']].values:
                    if 0<=t-x and t-x<n+1:
                        qx[int(t-x)] = male
            else:
                for (t,female) in self.sht_rate.loc[condition][['x', 'Female']].values:
                    if 0<=t-x and t-x<n+1:
                        qx[int(t-x)] = female
            return qx
        except:
            raise Exception(f'{riskCode} - 운전자위험률 error')       

    # 단일률
    def getSingleQx(self, riskCode : str,  sex : int, n : int) -> np.array:
        try:
            condition = self.sht_rate['RiskCode'] == riskCode      
            if self.injure in [1,2,3]:
                condition = condition & (self.sht_rate['Sub2'] == self.injure)     
            qx = np.ones(n+1)
            if sex == 1:
                q = self.sht_rate.loc[condition]['Male'].values[0]
            else:
                q = self.sht_rate.loc[condition]['Female'].values[0]
            try:
                return qx * q
            except:
                return qx*q[0]
        except:
            raise Exception(f'{riskCode} - 단일률 error')

    # 결합위험률
    def getCombQx(self, coverage : str, x : int, sex : int, n : int) -> dict:
        df = self.sht_comb.loc[self.sht_comb['Coverage'] == coverage]
        if df.shape[0] == 0:return {}
        else:
            qx_dict = {}
            for row in df.values:
                combRiskCode, operation, numRiskCode = row[1:4]            
                riskCodes = row[4:4+numRiskCode]
                periods = row[12:12+numRiskCode]            
                qx_array = np.zeros(shape = (numRiskCode, n+1))
                for i, riskCode in enumerate(riskCodes):                
                    if riskCode in qx_dict.keys():
                        qx_array[i] = qx_dict[riskCode]
                    else:
                        qx_array[i] = self.getQx(riskCode=riskCode, sex=sex, x=x, n=n)
                k_array = np.array([period/12 for period in periods])               
                if operation == 1:
                    qx_dict[combRiskCode] = self.CombOperation1(qx_array=qx_array, k_array=k_array)
                elif operation == 2:
                    qx_dict[combRiskCode] = self.CombOperation2(qx_array=qx_array, k_array=k_array)
                else:
                    raise Exception("Operation 입력값 오류발생")
            return qx_dict

    # q_comb = (1-k1) q1 + (1-k2) q2 + ....
    @staticmethod
    def CombOperation1(qx_array : np.array, k_array : np.array):
        qx_array[:, 0] *= 1 - k_array
        return np.sum(qx_array, axis = 0)

    # q_comb = 1 - (1-k1 x q1) x (1-k2 x q2) x ....
    @staticmethod
    def CombOperation2(qx_array : np.array, k_array : np.array):       
        qx_array[:, 0] *= 1 - k_array      
        product = np.product(1-qx_array, axis = 0)      
        return 1-product



