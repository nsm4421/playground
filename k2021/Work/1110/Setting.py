import pandas as pd
import numpy as np
import json
from tqdm import tqdm

# Qx.csv layout : RiskKey,x,Male,Female,RisCodeName
# Code.csv layout : Coverage,CoverageName,Sub1,Sub2,Sub3,CoverageKey,Bnum,ExitCode,ExitType,ExitCodeName,NonCov,BenefitCode,BenefitType,
#                   BenefitCodeName,PayRate,ReducRate,ReducPeriod,GrantCode,GrantType,GrantCodeName,InvalidPeriod
# Comb.csv layout : CoverageKey,CoverageName,CombRiskKey,CombRiskKeyName,Operation,RiskKey(1),Period(1),RiskKeyName(1),RiskKey(2),Period(2),RiskKeyName(2),RiskKey(3),Period(3),RiskKeyName(3),
#                   RiskKey(4),Period(4),RiskKeyName(4),RiskKey(5),Period(5),RiskKeyName(5),RiskKey(6),Period(6),RiskKeyName(6),RiskKey(7),Period(7),RiskKeyName(7),RiskKey(8),Period(8),RiskKeyName(8)


class Setting:
    def __init__(self, qx_path : str, code_path : str, comb_path : str):
        self.qx_path = qx_path
        self.code_path = code_path
        self.comb_path = comb_path

    @staticmethod
    def MakeQxDict(qx_path : str = './Qx.csv', max_age :int = 120, fillNa = "^"):
        # 위험률시트 읽기
        Qx_tab = pd.read_csv(qx_path).fillna(fillNa)
        Qx_dict = {}    
        Qx_dict[1], Qx_dict[2] = {}, {}    
        for rKey in tqdm(np.unique(Qx_tab['RiskKey'].values)):
            df = Qx_tab.loc[Qx_tab['RiskKey'] == rKey]
            qx_male = np.zeros(max_age+1)
            qx_female = np.zeros(max_age+1)
            for (rKey, x, male, female) in df[['RiskKey', 'x', 'Male', 'Female']].values:
                # 단일률
                if x=='ZZ':
                    qx_male = np.ones(shape = max_age+1) * male
                    qx_female = np.ones(shape = max_age+1) * male
                    Qx_dict[1][rKey] = qx_male
                    Qx_dict[2][rKey] = qx_female
                    continue
                # 연령율
                else:
                    qx_male[int(x)] = male
                    qx_female[int(x)] = female        
                Qx_dict[1][rKey] = qx_male
                Qx_dict[2][rKey] = qx_female
        return Qx_dict

    @staticmethod
    def MakeCoverageDict(code_path = './Code.csv', comb_path = './Comb.csv', fillNa = "^"):
        # 코드 시트 읽기
        code_tab = pd.read_csv(code_path).fillna(fillNa)
        code_tab = code_tab.sort_values(by=['CoverageKey', 'Bnum'])
        # 결합위험률 시트 읽기
        comb_tab = pd.read_csv(comb_path).fillna(fillNa)
        comb_tab = comb_tab.sort_values(by=['CoverageKey', 'CombRiskKey'])
        # 결과물
        Coverage_dict = {}       
        
        # 담보정보
        for cKey in np.unique(code_tab['CoverageKey'].values):
            cov_dict = {}                           
            df = code_tab.loc[code_tab['CoverageKey'] == cKey]
            # 급부개수 
            numBenefit = df['Bnum'].values.reshape(-1)[-2]       
            # 탈퇴         
            exitCode = [fillNa]*(numBenefit+1)
            exitType = [fillNa]*(numBenefit+1)
            nonCov = np.zeros(numBenefit+1)                     
            # 급부지급
            benefitCode = [fillNa]*numBenefit
            benefitType = [fillNa]*numBenefit
            payRate = np.ones(numBenefit)
            reducRate = np.zeros(numBenefit)
            reducPeriod = np.zeros(numBenefit)
                        
            for (cKey, bNum, eCode, eType, nCov, bCode, bType, pRate, rRate, rPeriod, gCode, gType, iPeriod) in \
                df[['CoverageKey', 'Bnum', 'ExitCode', 'ExitType', 'NonCov', 'BenefitCode', 'BenefitType', \
                    'PayRate', 'ReducRate', 'ReducPeriod', 'GrantCode', 'GrantType', 'InvalidPeriod']].values:
                # 예외처리
                if bNum == fillNa:raise Exception(f'{cKey} 담보 담보번호가 공백으로 들어옴')
                else:bNum = int(bNum)
                # 납면
                if bNum == 99:
                    cov_dict['GrantCode'] = gCode                                           # 납면율
                    cov_dict['GrantType'] = gType                                           # 납면율 종류
                    cov_dict['InvalidPeriod'] = 0 if iPeriod == fillNa else int(iPeriod)    # 무효해지기간
                else:
                    # 탈퇴
                    exitCode[bNum] = eCode                                              # 탈퇴율
                    exitType[bNum] = eType                                              # 탈퇴율 종류
                    nonCov[bNum] = 0 if nCov == fillNa else int(nCov)                   # 부담보 기간    
                    
                    if bNum != 0:
                        # 급부
                        benefitCode[bNum-1] = bCode                                       # 급부율
                        benefitType[bNum-1] = bType                                       # 급부율 종류
                        payRate[bNum-1] = float(pRate)                                    # 급부지급률                          
                        reducRate[bNum-1] = 0. if rRate == fillNa else float(rRate)       # 감액률
                        reducPeriod[bNum-1] = 0 if rPeriod == fillNa else int(rPeriod)    # 감액기간

                cov_dict['NumBenefit'] = numBenefit
                cov_dict['ExitCode'] = exitCode
                cov_dict['ExitType'] = exitType
                cov_dict['NonCov'] = nonCov
                cov_dict['BenefitCode'] = benefitCode
                cov_dict['BenefitType'] = benefitType
                cov_dict['PayRate'] = payRate
                cov_dict['ReducRate'] = reducRate
                cov_dict['ReducPeriod'] = reducPeriod
                                      
                        
            # 결합위험률 정보      
            if cKey in comb_tab['CoverageKey'].values:
                comb_info = {}
                df_comb = comb_tab[['CoverageKey', 'CombRiskKey', 'Operation'] + \
                    [f'RiskKey({i})' for i in range(1, 8+1)] + [f'Period({i})' for i in range(1, 8+1)]]        
                for row in df_comb.values:
                    cKey = row[0]                                                         # 담보키
                    combKey = row[1]                                                      # 결합위험률키
                    operation = int(row[2])                                               # 연산방법 (1: sum / 2 : product)
                    rKeys = row[3:3+8]                                                    # 위험률키
                    periods = [int(p) if p!=fillNa else 0 for p in row[11:11+8]]          # 제외기간
                    numRiskRate = 0                 
                    for rKey in rKeys:
                        if rKey!=fillNa:numRiskRate +=1                
                    comb_info[combKey] = {'RiskKeys' : list(rKeys[:numRiskRate]),
                                        'Periods' : list(periods[:numRiskRate]),
                                        'Operation' : operation}
                cov_dict['Combine'] = comb_info

            Coverage_dict[cKey] = cov_dict

        return Coverage_dict


