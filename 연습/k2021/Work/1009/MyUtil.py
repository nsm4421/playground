import numpy as np
import pandas as pd

class MyUtil:
    def __init__(self, excel_file : str = './INFO.xlsx', fillNa = "ZZ"):
        self.excel_file = excel_file
        self.fillNa = fillNa
                
        ## 위험률시트
        sht_rate = pd.read_excel(excel_file, sheet_name="위험률", header=2)
        sht_rate = sht_rate[['위험률코드','경과년수','가입연령', '남자','여자']].fillna(fillNa)
        # null값 처리
        for col in ['남자', '여자']:
            sht_rate[col] = sht_rate[col].apply(lambda x:0 if x==fillNa else float(x))
        # dtype
        self.sht_rate = sht_rate.astype({'가입연령' : int, '남자' : float, '여자' : float})

        ## 코드시트         
        sht_code = pd.read_excel(excel_file, sheet_name="코드", header=2)
        sht_code = sht_code.fillna(fillNa)
        sht_code = sht_code[['담보키', '급부번호', '탈퇴율', '탈퇴율Type', '부담보기간',\
            '급부율', '급부율Type', '지급률', '감액률', '감액기간', '납면율', '납면율Type', '무효해지기간']] 
        # null값 처리
        for col in ['부담보기간', '지급률', '감액률', '감액기간', '무효해지기간']:
            sht_code[col] = sht_code[col].apply(lambda x:0 if x==fillNa else x)
        # dtype
        self.sht_code = sht_code.astype({'부담보기간' : int, '지급률' : float, \
            '감액률' : float, '감액기간' : int, '무효해지기간' : int})

        ## 결합위험률 시트
        sht_comb = pd.read_excel(excel_file, sheet_name="결합위험률", header=2)
        sht_comb = sht_comb[['담보키', '결합위험률코드', '계산방법', '위험률개수'] \
            + [f"위험률코드({i})" for i in range(1, 8+1)] + [f"제외기간({i})" for i in range(1, 8+1)]].fillna(fillNa)
        # null값 처리
        for col in [f"제외기간({i})" for i in range(1, 8+1)]:
            sht_comb[col] = sht_comb[col].apply(lambda x:0 if x==fillNa else int(x))
        # dtype
        self.sht_comb = sht_comb.astype({'계산방법' : int, '위험률개수' : int, \
            '제외기간(1)' : int, '제외기간(2)' : int, '제외기간(3)' : int, '제외기간(4)' : int, \
                '제외기간(5)' : int, '제외기간(6)' : int, '제외기간(7)' : int, '제외기간(8)' : int})


    #  -------------------------------------- 상품정보 --------------------------------------  #
    def gatherInfo(self, coverage : str, sex : int = 1, x : int = 40, n : int = 80, firstJoinAge : int = None) -> dict:
        """
        담보키를 입력하면 필요한 정보를 추출
        """
        df_code = self.sht_code.loc[self.sht_code['담보키'] == coverage].copy(deep = True)
        if df_code.shape[0] == 0:raise Exception(f"담보키 {coverage}로 조회되는 정보가 없음")
        # 결합위험률 생성
        comb_dict = self.getCombQx(coverage=coverage, x=x, sex=sex, n=n)
        
        # 탈퇴
        ExitInfo = {}
        for row in df_code[['급부번호','탈퇴율','탈퇴율Type','부담보기간']].values:
            benefitNum, exitCode, exitType, nonCov = row
            if benefitNum != 99:
                if exitCode == self.fillNa:
                    qx_exit = np.zeros(shape = (n+1))
                elif exitType == self.fillNa:
                    qx_exit = self.getQx(riskCode = exitCode, sex=sex, x = x, n=n)                
                elif exitType.upper() == 'M':
                    qx_exit = self.getMatrixQx(riskCode = exitCode, sex=sex, x = x, n=n, firstJoinAge = firstJoinAge)
                elif exitType.upper() == "C":
                    qx_exit = comb_dict[exitCode]
                else:
                    raise Exception(f"탈퇴율Type이 {exitType}으로 들어옴")                    
                ExitInfo[benefitNum] = {'위험률코드' : exitCode, '위험률Type' : exitType, 'qx' : qx_exit, '부담보기간' : nonCov}
        # 급부지급
        BenefitInfo = {}
        num_benefit = 0
        for row in df_code[['급부번호','급부율','급부율Type','지급률', '감액률', '감액기간']].values:
            benefitNum, benefitCode, benefitType, defryRate, reducRate, reducPeriod = row
            if benefitNum!=0 and benefitNum!=99:
                num_benefit +=1
                if benefitCode == self.fillNa:
                    raise Exception("급부율에 null값이 들어옴")
                elif benefitType == self.fillNa:
                    qx_benefit = self.getQx(riskCode=benefitCode, sex=sex, x=x, n=n)
                elif benefitType.upper() == 'M':
                    qx_benefit = self.getMatrixQx(riskCode = benefitCode, sex=sex, x = x, n=n, firstJoinAge = firstJoinAge)
                elif benefitType.upper() == "C":
                    qx_benefit = comb_dict[benefitCode]       
                else:    
                    raise Exception(f"급부율Type이 {benefitType}으로 들어옴")      
                BenefitInfo[benefitNum] = {'위험률코드' : benefitCode, '위험률Type' : benefitType, 'qx' : qx_benefit, \
                        '지급률' : defryRate, '감액률' : reducRate, '감액기간' : reducPeriod}
        # 납면
        GrantInfo = {}        
        for row in df_code[['급부번호','납면율','납면율Type','무효해지기간']].values:
            benefitNum, grantCode, grantType, invalidPeriod = row
            if benefitNum == 99:
                if grantCode == self.fillNa:
                    qx_grant = np.zeros(shape = (n+1))
                elif grantType == self.fillNa:
                    qx_grant = self.getQx(riskCode=grantCode, sex=sex, x=x, n=n)
                elif grantType.upper() == 'M':
                    qx_grant = self.getMatrixQx(riskCode = grantCode, sex=sex, x = x, n=n, firstJoinAge = firstJoinAge)
                elif grantType.upper() == "C":
                    qx_grant = comb_dict[grantCode]
                else: 
                    raise Exception(f"납면율Type이 {grantType}으로 들어옴")     
                GrantInfo[benefitNum] = {'위험률코드' : grantCode, '위험률Type' : grantType, 'qx' : qx_grant, \
                    '무효해지기간' : invalidPeriod}        
        return {'탈퇴' : ExitInfo, '급부' : BenefitInfo, '납면' : GrantInfo, '급부개수' : num_benefit}

    #  -------------------------------------- 일반위험률 --------------------------------------  #
    def getQx(self, riskCode : str, sex : int = 1, x : int = 40, n : int = 80) -> np.array:
        condition = (riskCode == self.sht_rate['위험률코드']) 
        qx = np.zeros(120)
        if sex == 1:
            for (t,male) in self.sht_rate.loc[condition][['가입연령', '남자']].values:
                qx[int(t)] = male
        else:
            for (t,female) in self.sht_rate.loc[condition][['가입연령', '여자']].values:
                qx[int(t)] = female
        return qx[x:x+n+1]

    #  -------------------------------------- 이차위험률 --------------------------------------  #
    def getMatrixQx(self, riskCode : str,  sex : int = 1, x : int = None, n : int = 80, firstJoinAge : int = 0) -> np.array:
        condition = (riskCode == self.sht_rate['위험률코드']) & (firstJoinAge == self.sht_rate['가입연령'])
        qx = np.zeros(n+1)
        if sex == 1:
            for (t,male) in self.sht_rate.loc[condition][['경과년수', '남자']].values:
                idx = int(t -(x-firstJoinAge))
                if 0<=idx and idx<=n:
                    qx[idx] = male                
        else:
            for (t,female) in self.sht_rate.loc[condition][['경과년수', '여자']].values:
                idx = int(t -(x-firstJoinAge))
                if 0<=idx and idx<=n:
                    qx[idx] = female  
        return qx    

    #  -------------------------------------- 결합위험률 --------------------------------------  #
    def getCombQx(self, coverage : str, x : int, sex : int, n : int) -> dict:
        df = self.sht_comb.loc[self.sht_comb['담보키'] == coverage]
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
                    raise Exception("계산방법 입력값 오류발생")
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



