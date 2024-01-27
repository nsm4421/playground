import numpy as np
import pandas as pd

class Util:
    def __init__(self, ExcelPath : str):
        # 위험율 테이블
        self.RiskTab = pd.read_excel(ExcelPath, \
            sheet_name="위험률", header = 0).fillna(0.)\
                .drop_duplicates(ignore_index=True)
        # 급부지급
        self.BenefitTab = pd.read_excel(ExcelPath, \
            sheet_name="급부지급", header = 0).fillna(0.)\
                .drop_duplicates(ignore_index=True)\
                    .sort_values(['담보코드', '급부번호'])
        # 급부지급
        self.ExitTab = pd.read_excel(ExcelPath, \
            sheet_name="급부탈퇴", header = 0).fillna(0.)\
                .drop_duplicates(ignore_index=True)\
                    .sort_values(['담보코드', '급부번호'])
        # 납입면제
        self.GrantTab = pd.read_excel(ExcelPath, \
            sheet_name="납입면제", header = 0).fillna(0.)\
                .drop_duplicates(ignore_index=True)\
                    .sort_values(['담보코드'])

    def getRate(self, rCode : str, sex : int, age = None,\
        sub1 = None, sub2 = None, sub3 = None) -> np.array:
        """
        Input : 위험률코드, 성별, 연령
        Output : 위험률
        """
        # Slicing
        df = self.RiskTab.copy(deep=True)
        condition = (df['위험률코드'] == rCode) & \
            (df['성별'] == sex)         
        if sub1 != None:condition = condition & (df['sub1'] == sub1)
        if sub2 != None:condition = condition & (df['sub2'] == sub2)
        if sub3 != None:condition = condition & (df['sub3'] == sub3)
        df = df.loc[condition]
        # 가입나이
        if isinstance(age, int):
            df = df.loc[df['나이'] == age]
        elif (isinstance(age, list) or isinstance(age, tuple)) and len(age) == 2:
            df = df.loc[df['나이'] >= age[0]]
            df = df.loc[df['나이'] <= age[1]]
        else:
            raise ValueError("Age : int or interval")
        return df['위험률'].values
           
    def benefitInfo(self, cCode : str)->np.array:
        """
        Input : 담보코드
        Output : 급부번호, 위험률코드, 지급률, 감액기간, 감액률
        """
        df = self.BenefitTab.copy(deep=True)
        df = df.loc[df['담보코드'] == cCode, \
            ['급부번호', '위험률코드', '지급률', '감액기간', '감액률']]
        return df.values
        
    def exitInfo(self, cCode):
        """
        Input : 담보코드
        Output : 급부번호, 위험률코드, 부담보기간
        """
        df = self.ExitTab.copy(deep=True)
        df = df.loc[df["담보코드"] == cCode, ["급부번호", "위험률코드", "부담보기간"]]
        if df.shape[0] == 0:return None
        else:return df.values

    def grantInfo(self, cCode : str) -> np.array:
        """
        Input : 담보코드
        Output : 위험률코드, 면책기간
        """
        df = self.GrantTab.copy(deep=True)
        df = df.loc[df['담보코드'] == cCode, ['위험률코드', '면책기간', 'sub']]
        if df.shape[0] == 0:return None
        else:return df.values