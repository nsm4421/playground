import pandas as pd
import numpy as np
from tqdm import tqdm


class Util_Dict:
    def __init__(self, excel_path : str):
        
        # 엑셀 경로
        self.excel_path = excel_path
        
        # 구분자
        self.sep = ['상해급수', '운전자급수']


    # Qx dictionary 만들기
    def setQxDict(self):       
        
        # 위험률 시트 읽기
        df_Qx = pd.read_excel(self.excel_path, sheet_name="위험률", header = 3).fillna(0)

        # 위험률키 컬럼 추가
        riskKeys = []
        for row in df_Qx[['위험률코드'] + self.sep + ['x', '남자', '여자']].values:
            rCode, injure, driver, x, male, female = row
            rKey = (rCode, int(injure), int(driver))   
            riskKeys.append(rKey)
        df_Qx['위험률키'] = riskKeys

        # 위험률 Dictionary
        Qx_dict = {}
        
        for rKey in tqdm(set(riskKeys)):    # 위험률키로 loop
            
            # 위험률 배열 초기화
            qx_male = [0.]*120
            qx_female = [0.]*120

            # 해당 위험률키에 해당하는 레코드 추출
            df_q = df_Qx.loc[df_Qx['위험률키'] == rKey][['x', '남자', '여자']]
            
            for x, male, female in df_q.values:
            
                if x == "ZZ":   # 단일률
                    qx_male = [male for _ in range(120)]
                    qx_female = [male for _ in range(120)]
                    break

                else:           # 연령율
                    qx_male[int(x)] = male
                    qx_female[int(x)] = female

            # 위험률 dictionary에 추가
            # 구분자 ---> 성별 / 위험률코드 / 상해급수 / 운전자급수
            Qx_dict[(1,*rKey)] = np.array(qx_male)
            Qx_dict[(2,*rKey)] = np.array(qx_female)

        self.QxDict = Qx_dict


    # 담보 dictionary 만들기
    def setCovDict(self):

        # 코드 시트 읽기
        df_Code = pd.read_excel(self.excel_path, sheet_name="코드", header = 3).fillna(0)

        # 담보키 컬럼 추가
        # 담보키 구분자 : 담보코드 / 상해급수 / 운전자급수
        covKeys = []
        for row in df_Code[['담보코드'] + self.sep].values:
            covKey, injure, driver = row
            covKeys.append((covKey, int(injure), int(driver)))   
        df_Code['담보키'] = covKeys

        Coverage_dict = {}
        cols = self.sep + ['급부번호', '탈퇴율코드', '탈퇴율Type', '부담보기간',\
                            '급부율코드', '급부율Type', '지급률', '감액률', '감액기간', \
                                    '납면율코드', '납면율Type', '면책기간']


        for covKey in tqdm(set(covKeys)):
            # 해당 
            df_c = df_Code[df_Code['담보키'] == covKey][cols]
            
            # 초기화
            ExKey = [None]*10               # 탈퇴위험률키
            NonCov = [None]*10              # 부담보 기간
            BxKey = [None]*10               # 급부위험률키
            PayRate = [None]*10             # 지급률
            ReduceRate = [None]*10          # 감액률
            ReducePeriod = [None]*10        # 감액기간
            GxKey = None                    # 납입면제위험률키
            InvalidPeriod = None            # 무효해지기간
            numBenefit = 0                  # 급부개수
            useCombQx = False               # 결합위험률 적용 여부
            useSingleQx = False             # 단일률 적용 여부

            for row in df_c.values:
                injure, driver, bNum, eCode, eType, nCov, bCode, bType, pRate, rRate, rPeriod, gCode, gType, iPeriod = row

                # 결합위험률 적용 여부
                if (eType == "C") | (bType == "C") | (gType == "C"):
                    useCombQx = True
                # 단일률 적용 여부
                if (eType == "S") | (bType == "S") | (gType == "S"):
                    useSingleQx = True
                
                # 납입면제 (grant) 세팅
                if bNum == 99:  
                    if gCode == 0 or str(gCode).strip() == "":
                        GxKey = None
                        InvalidPeriod = 0
                    else:
                        GxKey = (gCode, int(injure), int(driver))
                        InvalidPeriod = int(iPeriod)

                else:

                    # 탈퇴 (exit) 세팅
                    if eCode == 0 or str(eCode).strip() == "":
                        ExKey[bNum] = None
                        NonCov[bNum] = 0 
                    else:
                        ExKey[bNum] = (eCode, int(injure), int(driver))
                        NonCov[bNum] = int(nCov)

                    if bNum>0:
        
                        if bCode == 0 or str(bCode).strip() == "":
                            raise Exception(f'{covKey} 담보에 대해 급부정보가 들어오지 않음')    
                        
                        # 급부지급 (benefit) 세팅
                        else:
                            BxKey[bNum] = (bCode, int(injure), int(driver))
                            PayRate[bNum] = float(pRate)
                            ReduceRate[bNum] = float(rRate)
                            ReducePeriod[bNum] = int(rPeriod)                 
                            numBenefit += 1

            Coverage_dict[covKey] = {
                'ExKey' : ExKey[:numBenefit+1],
                'NonCov' : np.array(NonCov[:numBenefit+1]),
                'BxKey' : BxKey[:numBenefit+1],
                'PayRate' : np.array(PayRate[:numBenefit+1]),
                'ReduceRate' : np.array(ReduceRate[:numBenefit+1]),
                'ReducePeriod' : np.array(ReducePeriod[:numBenefit+1]),
                'GxKey' : GxKey,
                'InvalidPeriod' : InvalidPeriod,
                'NumBenefit' : numBenefit,
                'UseSingleQx' : useSingleQx,
                'UseCombQx' : useCombQx,
                'Comb' : {},
                'Expense' : {},
                'S' : 0
            }

        self.CovDict = Coverage_dict


    def setCombInfo(self) -> dict:

        # 결합위험률시트 읽기
        df_Comb = pd.read_excel(self.excel_path, sheet_name="결합위험률", header=3).fillna(0)
        df_Comb = df_Comb[['담보코드', '상해급수', '운전자급수', \
            '결합위험률코드', 'Operation', '위험률개수'] \
                + [f"위험률코드({i})" for i in range(1, 8+1)] \
                    +  [f"위험률Type({i})" for i in range(1, 8+1)] \
                        + [f"제외기간({i})" for i in range(1, 8+1)]]
                        
        # 담보키 컬럼 추가
        covKeys = []
        for row in df_Comb[['담보코드'] + self.sep].values:
            cov_key, injure, driver = row
            covKeys.append((cov_key, int(injure), int(driver)))
        df_Comb['담보키'] = covKeys

        df_Comb = df_Comb[['담보키'] + self.sep + \
            ['결합위험률코드', 'Operation', '위험률개수'] \
                + [f"위험률코드({i})" for i in range(1, 8+1)] \
                    +  [f"위험률Type({i})" for i in range(1, 8+1)] \
                        + [f"제외기간({i})" for i in range(1, 8+1)]]

        for covKey in tqdm(set(covKeys)):
            comb_info = {}
            df_c = df_Comb.loc[df_Comb['담보키'] == covKey]

            for row in df_c.values:
                injure, driver, combRiskKey, oper, nRiskKey = row[1:6]
                injure = int(injure)
                driver = int(driver)
                oper = int(oper)
                nRiskKey = int(nRiskKey)
                rCodes = row[6:6+nRiskKey][:nRiskKey]
                periods = [int(p) for p in row[14:14+nRiskKey]]
                rTypes = row[22:22+nRiskKey]

                riskKeys = []
                for rCode, rType in zip(rCodes, rTypes):
                    if rType == "C":
                        rKey = rCode
                    else:
                        rKey = rKey = (rCode, injure, driver)
                    riskKeys.append(rKey)

                comb_info[(combRiskKey, injure, driver)] = {
                    "Operation" : int(oper),
                    'NumRiskKey' : int(nRiskKey),
                    "RiskKeys" : riskKeys,
                    "Periods" : np.array(periods)
                }

            self.CovDict[covKey]['Comb'] = comb_info


    def setExpenseInfo(self):

        df_Expense = pd.read_excel(self.excel_path, sheet_name="사업비", header=3).fillna(0)
        covKeys = []
        for row in df_Expense[['담보코드'] +self.sep].values:
            cov, injure, driver = row
            covKeys.append((cov, int(injure), int(driver)))
        df_Expense['담보키'] = covKeys

        df_Expense = df_Expense[['담보키', 'alpha1 (n=1)', 'alpha1 (n=2)', 'alpha1 (n=3)', \
            'alpha1 (n=4)', 'alpha1 (n=5)', 'alpha3', 'beta1', 'beta2', 'gamma', 'ce']]
        
        for cov_key in tqdm(set(covKeys)):
            row = df_Expense.loc[df_Expense['담보키'] == cov_key].values[0]
            self.CovDict[cov_key]['Expense'] = {
                'alpha1_n1' : row[1],
                'alpha1_n2' : row[2],
                'alpha1_n3' : row[3],
                'alpha1_n4' : row[4],
                'alpha1_n5' : row[5],
                'alpha3' : row[6]/1000,     # <--- 대천알파
                'beta1' : row[7],
                'beta2' : row[8],
                'gamma' : row[9],
                'ce' : row[10],
            }
