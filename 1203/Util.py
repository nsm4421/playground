import numpy as np
import pandas as pd
import json
from tqdm import tqdm


class Util:
    def __init__(self, excel_file = './Template.xlsx', fillNa = "^"):
        self.excel_file = excel_file
        self.fillNa = fillNa

    def QxSheetToJson(self, sheet_name : str = "위험률", header :int = 2):

        df_Qx = pd.read_excel(self.excel_file, sheet_name=sheet_name, header=header).fillna(self.fillNa)
        RiskKeys = np.unique(df_Qx['RiskKey'].values)

        Qx_dict = {}
        for rKey in tqdm(RiskKeys):
            df_q = df_Qx.loc[df_Qx['RiskKey'] == rKey][['x', 'Male', 'Female']]
            qx_male = [0.]*120
            qx_female = [0.]*120
            for t, (x, male, female) in enumerate(df_q.values):
                if  x == 'ZZ':  # 단일률
                    qx_male = [male]*120
                    qx_female = [female]*120
                    break
                else:
                    qx_male[x] = male
                    qx_female[x] = female
            Qx_dict[rKey] = {1 : qx_male, 2 : qx_female}
            
        with open('Qx.json', 'w') as j:
            json.dump(Qx_dict, j)

    def CoverageSheetToJson(self, sheet_name : str = "코드", header : int= 2):

        df_code = pd.read_excel(self.excel_file, sheet_name=sheet_name, header=header).fillna(self.fillNa)
        CoverageKeys = np.unique(df_code['CoverageKey'].values)

        Coverage_dict = {}

        for covKey in tqdm(CoverageKeys):
            cov_dict = {}
            numBenefit = 0
            df_exit = df_code.loc[df_code['CoverageKey'] == covKey][['BenefitNum', 'ExitCode', 'ExitType', 'NonCov']]
            df_benefit = df_code.loc[df_code['CoverageKey'] == covKey][['BenefitNum', 'BenefitCode', 'BenefitType', 'PayRate', 'ReduceRate', 'ReducePeriod']]
            df_grant = df_code.loc[df_code['CoverageKey'] == covKey][['BenefitNum','GrantCode', 'GrantType', 'InvalidPeriod']]
        
            eCode_lst = []
            eType_lst = []
            nCov_lst = []

            bCode_lst = []
            bType_lst = []
            pRate_lst = []
            rRate_lst = []
            rPeriod_lst = []

            for (eInfo, bInfo, gInfo) in zip(df_exit.values, df_benefit.values, df_grant.values):
                bNum, eCode, eType, nCov = eInfo
                _, bCode, bType, pRate, rRate, rPeriod = bInfo
                _, gCode, gType, iPeriod = gInfo

                bNum = int(bNum)
                nCov = 0 if nCov == self.fillNa else int(nCov)
                pRate = 1. if pRate == self.fillNa else float(pRate)
                rRate = 0. if rRate == self.fillNa else float(rRate)
                rPeriod = 0 if rPeriod == self.fillNa else int(rPeriod)
                iPeriod = 0 if iPeriod == self.fillNa else int(iPeriod)

                if bNum == 99:
                    cov_dict['GrantCode'] = gCode
                    cov_dict['GrantType'] = gType
                    cov_dict['InvalidPeriod'] = iPeriod
                else:
                    eCode_lst.append(eCode)
                    eType_lst.append(eType)
                    nCov_lst.append(nCov)
                
                if bNum not in [0, 99]:
                    bCode_lst.append(bCode)
                    bType_lst.append(bType)
                    pRate_lst.append(pRate)
                    rRate_lst.append(rRate)
                    rPeriod_lst.append(rPeriod)
                    numBenefit += 1

            cov_dict['NumBenefit'] = numBenefit

            cov_dict['ExitCode'] = eCode_lst
            cov_dict['ExitType'] = eType_lst
            cov_dict['NonCov'] = nCov_lst

            cov_dict['BenefitCode'] = bCode_lst
            cov_dict['BenefitType'] = bType_lst
            cov_dict['PayRate'] = pRate_lst
            cov_dict['ReduceRate'] = rRate_lst
            cov_dict['ReducePeriod'] = rPeriod_lst

            Coverage_dict[covKey] = cov_dict

        with open('Coverage.json', 'w') as j:
            json.dump(Coverage_dict, j)


    def CombSheetToJson(self, sheet_name : str = "결합위험률", header : int = 2):

        Comb_dict = {}
        df_comb = pd.read_excel(self.excel_file, sheet_name = sheet_name, header = header).fillna(self.fillNa)
        for (combRiskKey, operation, numRiskKey, \
            rKey1, rKey2, rKey3, rKey4, rKey5,rKey6,rKey7, rKey8, \
                period1, period2, period3, period4, period5, period6, period7, period8) \
                    in df_comb[['CombRiskKey', 'Operation', 'NumRiskKey'] \
                        + [f"RiskKey({i+1})" for i in range(8)] \
                            + [f"Period({i+1})" for i in range(8)]].values:
               
                            rKeys = [rKey1, rKey2, rKey3, rKey4, rKey5,rKey6,rKey7, rKey8][:numRiskKey]
                            periods = [ period1, period2, period3, period4, period5, period6, period7, period8][:numRiskKey]
                            Comb_dict[combRiskKey] = {'NumRiskKey' : numRiskKey, 'RiskKeys' : rKeys, 'Periods' : periods, 'Operation' : operation}

        with open('Comb.json', 'w') as j:
            json.dump(Comb_dict, j)
