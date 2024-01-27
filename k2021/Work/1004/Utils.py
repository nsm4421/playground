import sqlite3
import numpy as np
import pandas as pd
from pandas.core.frame import DataFrame
from tqdm import tqdm

## ========================== DB생성 ========================== ##
class SetUpDB:
    def __init__(self, config :dict = None):
        self.config = config
        if self.config == None:
            self.config = {'dbName' : "MyDB.db", \
                'readRiskRateSheet' : {'excelFilePath' : './INFO_N.xlsx', 'sheetName' : '위험률', 'fillna' : 'ZZ'}, \
                    'readProductInfoSheet' : {'excelFilePath' : './INFO_N.xlsx', 'sheetName' : '상품정보', 'fillna' : 0}, \
                        'readCombInfoSheet' : {'excelFilePath' : './INFO_N.xlsx', 'sheetName' : '결합위험률', 'fillna' : 'ZZ'}}    
   
    ## ========================== DB세팅 ========================== ##

    def setUp(self):    
        try:
            self.conn = sqlite3.connect(f"{self.config['dbName']}") # dbName이라는 데이터베이스와 연결 (dbName이라는 이름의 데이터베이스가 없으면 생성)
            self.cursor = self.conn.cursor()
        except:
            raise Exception('DB 연결 실패함')
        
        self.readRiskRateSheet(**self.config['readRiskRateSheet'])
        self.readProductInfoSheet(**self.config['readProductInfoSheet'])
        self.readCombInfoSheet(**self.config['readCombInfoSheet'])
        try:
            self.dropRiskRateTable()
            print("기존에 있던 위험률 테이블 제거")
            self.dropProductInfoTable()
            print("기존에 있던 상품정보 테이블 제거")
            self.dropCombInfoTable()
            print("기존에 있던 상품정보 결합위험률 테이블 제거")
        except:
            pass
        finally:
            self.createRiskRateTable()
            self.createExitTable()
            self.createBenefitTable()
            self.createGrantTable()   
            self.createCombTable()
        self.insertRiskRateValues()
        self.insertProductInfoValues()
        self.insertCombInfoValues()
        print('DB 세팅 완료')

    ## ========================== Excel 파일 읽기 ========================== ##

    def readRiskRateSheet(self,  excelFilePath : str = './INFO_N.xlsx', sheetName : str = "위험률", header : int = 1, fillna : str = "ZZ"):
        """
        Excel 파일에서 위험률 시트 정보 읽기
        """        
        try:
            self.sht_rate = pd.read_excel(excelFilePath, sheet_name=sheetName, header=header)
            self.sht_rate = self.sht_rate[['위험률코드','보조키1','보조키2','보조키3','보조키4','가입연령','남자','여자','위험률명']].fillna(fillna)
            self.sht_rate = self.sht_rate.loc[self.sht_rate['위험률코드']!=fillna]
            self.sht_rate['남자'] = self.sht_rate['남자'].apply(lambda x:0 if x == fillna else x)
            self.sht_rate['여자'] = self.sht_rate['여자'].apply(lambda x:0 if x == fillna else x)
            print(f"{excelFilePath}로부터 {sheetName} 시트 정보 읽음 ---> {self.sht_rate.shape[0]} 건")
        except:
            raise Exception('readExcelSheet ---> 위험률이 있는 엑셀파일을 불러오는데 실패함')

    def readProductInfoSheet(self,  excelFilePath : str = './INFO_N.xlsx', sheetName : str = "상품정보", header : int = 1, fillna : str = "0"):
        """
        Excel 파일에서 상품 시트 정보 읽기
        """ 
        try:
            self.sht_code = pd.read_excel(excelFilePath, sheet_name=sheetName, header=header)
            self.sht_code = self.sht_code[['담보키','급부번호','탈퇴율코드','탈퇴율종류', \
                '부담보기간','급부율코드','급부율종류','지급률','감액률','감액기간',\
                    '납면율코드','납면율종류','무효해지']].fillna(fillna)                
            for riskKinds in self.sht_code[['탈퇴율종류', '급부율종류', '납면율종류']].values:
                riskKind_exit, riskKind_benefit, riskKind_grant = riskKinds
                if riskKind_exit not in ['C', 'M', fillna]:raise Exception(f'탈퇴 위험률 종류가 {riskKind_exit}로 들어간 경우가 존재')
                if riskKind_benefit not in ['C', 'M', fillna]:raise Exception(f'급부 위험률 종류가 {riskKind_benefit}로 들어간 경우가 존재')
                if riskKind_grant not in ['C', 'M', fillna]:raise Exception(f'납면 위험률 종류가 {riskKind_grant}로 들어간 경우가 존재')
            self.sht_code = self.sht_code.loc[self.sht_code['담보키']!=fillna]
            self.sht_code['지급률'] = self.sht_code['지급률'].apply(lambda x:1 if x==fillna else x)
            self.sht_code['부담보기간'] = self.sht_code['부담보기간'].apply(lambda x:0 if x==fillna else x)
            self.sht_code['감액률'] = self.sht_code['감액률'].apply(lambda x:0 if x==fillna else x)
            self.sht_code['감액기간'] = self.sht_code['감액기간'].apply(lambda x:0 if x==fillna else x)
            self.sht_code['무효해지'] = self.sht_code['무효해지'].apply(lambda x:0 if x==fillna else x)
            print(f"{excelFilePath}로부터 {sheetName} 시트 정보 읽음")
        except:
            raise Exception('readExcelSheet ---> 위험률이 있는 엑셀파일을 불러오는데 실패함')   

    def readCombInfoSheet(self,  excelFilePath : str = './INFO_N.xlsx', sheetName : str = "결합위험률", header : int = 1, fillna : str = "ZZ"):
        """
        Excel 파일에서 상품 시트 정보 읽기
        """ 
        try:
            self.combInfo = pd.read_excel(excelFilePath, sheet_name=sheetName, header=header)
            self.combInfo = self.combInfo[['담보키','결합위험률코드', '연산', '위험률개수', \
                '위험률코드(1)','제외기간(1)','위험률명(1)', '위험률코드(2)','제외기간(2)','위험률명(2)', \
                    '위험률코드(3)','제외기간(3)','위험률명(3)', '위험률코드(4)','제외기간(4)','위험률명(4)', \
                        '위험률코드(5)','제외기간(5)','위험률명(5)', '위험률코드(6)','제외기간(6)','위험률명(6)', \
                            '위험률코드(7)','제외기간(7)','위험률명(7)', '위험률코드(8)','제외기간(8)','위험률명(8)']].fillna(fillna)    
            for i in range(1,8+1):
                self.combInfo[f'제외기간({i})'] = self.combInfo[f'제외기간({i})'].apply(lambda x:0 if x==fillna else x)       
            self.combInfo = self.combInfo.loc[self.combInfo['담보키']!=fillna]
            print(f"{excelFilePath}로부터 {sheetName} 시트 정보 읽음")
        except:
            raise Exception('readExcelSheet ---> 위험률이 있는 엑셀파일을 불러오는데 실패함')   

    ## ========================== 테이블 생성 ========================== ##

    def createRiskRateTable(self):
        """
        RiskRate 라는 테이블을 생성
        """
        query = """
                CREATE TABLE IF NOT EXISTS RiskRate (
                RiskCode TEXT NOT NULL,
                Sub1 TEXT, 
                Sub2 TEXT, 
                Sub3 TEXT,
                Sub4 TEXT,
                x INTEGER, 
                Male REAL, 
                Female REAL, 
                RiskName TEXT,
                PRIMARY KEY (RiskCode, Sub1, Sub2, Sub3, Sub4, x)
                );
                """
        try:
            self.conn.execute(query)
            self.conn.commit()
            print("RiskRate 테이블 생성 완료")
        except:
            raise Exception('makeTable ---> DB에서 테이블 만드는데 실패')

    def createExitTable(self):
        """
        ExitInfo(탈퇴정보) 테이블 생성
        """
        query = """
                CREATE TABLE IF NOT EXISTS ExitInfo (
                CoverageKey TEXT NOT NULL,
                BenefitNum INTEGER NOT NULL, 
                RiskCode TEXT, 
                RiskKind TEXT,
                NonCov INTEGER
                );
                """
        try:
            self.conn.execute(query)
            self.conn.commit()
            print("테이블 생성 완료")
        except:
            raise Exception('createExitTable ---> DB에서 테이블 만드는데 실패')

    def createBenefitTable(self):
        """
        BenefitInfo(탈퇴정보) 테이블 생성
        """
        query = """
                CREATE TABLE IF NOT EXISTS BenefitInfo (
                CoverageKey TEXT NOT NULL,
                BenefitNum INTEGER NOT NULL, 
                RiskCode TEXT, 
                RiskKind TEXT,
                DEFRYRATE REAL,
                REDUCRATE REAL,
                REDUCPERIOD INTEGER
                );
                """
        try:
            self.conn.execute(query)
            self.conn.commit()
            print("테이블 생성 완료")
        except:
            raise Exception('createBenefitTable ---> DB에서 테이블 만드는데 실패')

    def createGrantTable(self):
        """
        GrantInfo(납입면제정보) 테이블 생성
        """
        query = """
                CREATE TABLE IF NOT EXISTS GrantInfo (
                CoverageKey TEXT NOT NULL,
                BenefitNum INTEGER NOT NULL, 
                RiskCode TEXT, 
                RiskKind TEXT,
                INVALIDPERIOD INTEGER
                );
                """
        try:
            self.conn.execute(query)
            self.conn.commit()
            print("테이블 생성 완료")
        except:
            raise Exception('createGrantTable ---> DB에서 테이블 만드는데 실패')

    
    def createCombTable(self):
        """
        CombTable(결합위험률정보) 테이블 생성
        """
        query = """
                CREATE TABLE IF NOT EXISTS CombInfo (
                CoverageKey TEXT NOT NULL,
                CombRiskCode TEXT NOT NULL,
                Operation INTEGER NOT NULL,
                NumRiskCode INTEGER NOT NULL,
                RiskCode1 TEXT, Period1 INTEGER, RiskName1 TEXT, 
                RiskCode2 TEXT, Period2 INTEGER, RiskName2 TEXT, 
                RiskCode3 TEXT, Period3 INTEGER, RiskName3 TEXT, 
                RiskCode4 TEXT, Period4 INTEGER, RiskName4 TEXT, 
                RiskCode5 TEXT, Period5 INTEGER, RiskName5 TEXT, 
                RiskCode6 TEXT, Period6 INTEGER, RiskName6 TEXT, 
                RiskCode7 TEXT, Period7 INTEGER, RiskName7 TEXT, 
                RiskCode8 TEXT, Period8 INTEGER, RiskName8 TEXT);
                """
        try:
            self.conn.execute(query)
            self.conn.commit()
            print("테이블 생성 완료")
        except:
            raise Exception('createGrantTable ---> DB에서 테이블 만드는데 실패')

    ## ========================== 테이블 제거 ========================== ##

    def dropRiskRateTable(self):
        """
        위험률 테이블을 제거
        """
        query = """
                DROP TABLE RiskRate;
                """
        try:
            self.conn.execute(query)
            self.conn.commit()
            print(" RiskRate 테이블 제거 완료")
        except:
            raise Exception('dropRiskRateTable ---> DB에서 테이블 제거하는데 실패')

    def dropProductInfoTable(self):   
        """
        상품정보 테이블 제거
        """    
        try:
            for tableName in ['ExitInfo', 'BenefitInfo', 'GrantInfo']:
                query = f"DROP TABLE {tableName};"
                self.conn.execute(query)
                self.conn.commit()
                print(f"{tableName} 테이블 제거 완료")
        except:
            raise Exception(f'dropProductInfoTable ---> DB에서 {tableName} 테이블 제거에 실패')

    def dropCombInfoTable(self):   
        """
        상품정보 테이블 제거
        """    
        try:
            query = f"DROP TABLE CombInfo;"
            self.conn.execute(query)
            self.conn.commit()
            print("결합위험률 테이블 제거 완료")
        except:
            raise Exception('dropCombInfoTable ---> DB에서 결합 위험률 테이블 제거에 실패')


    ## ========================== 데이터 베이스에 값 넣기 ========================== ##

    def insertRiskRateValues(self):
        """
        위험률시트에서 읽은 정보를 RiskRate 테이블에 저장
        """
        try:
            insert_query = "INSERT INTO RiskRate VALUES (?,?,?,?,?,?,?,?,?);"
            for row in tqdm(self.sht_rate.values):           
                self.conn.execute(insert_query, row)
            self.conn.commit()
            print(f"{self.sht_rate.shape[0]}건 데이터 삽입 완료")
        except:
            raise Exception('insertRiskRateValues ---> DB에 위험률을 insert 하는 과정에서 오류 발생')

    def insertProductInfoValues(self):
        """
        상품정보 시트에서 읽은 정보를 ExitInfo, BenefitInfo, GrantInfo 테이블에 저장
        """
        try:
            insert_query = "INSERT INTO ExitInfo VALUES (?,?,?,?,?);"
            for row in self.sht_code[['담보키','급부번호','탈퇴율코드','탈퇴율종류','부담보기간']].values:   
                if row[1] != 99:      
                    self.conn.execute(insert_query, row)
            self.conn.commit()

            insert_query = "INSERT INTO BenefitInfo VALUES (?,?,?,?,?,?,?);"
            for row in self.sht_code[['담보키','급부번호','급부율코드','급부율종류','지급률','감액률','감액기간']].values:  
                if row[1] not in (0, 99):         
                    self.conn.execute(insert_query, row)
            self.conn.commit()

            insert_query = "INSERT INTO GrantInfo VALUES (?,?,?,?,?);"
            for row in self.sht_code[['담보키','급부번호','납면율코드','납면율종류','무효해지']].values:   
                if row[1] == 99:      
                    self.conn.execute(insert_query, row)
            self.conn.commit()


        except:
            raise Exception('insertProductInfoValues ---> DB에 상품정보를 insert 하는 과정에서 오류 발생')

    def insertCombInfoValues(self):
        """
        위험률시트에서 읽은 정보를 CombInfo 테이블에 저장
        """
        try:
            insert_query = "INSERT INTO CombInfo VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"
            for row in tqdm(self.combInfo.values):           
                self.conn.execute(insert_query, row)
            self.conn.commit()
            print(f"결합위험률 {self.combInfo.shape[0]}건 데이터 삽입 완료")
        except:
            raise Exception('insertCombInfoeValues ---> DB에 결합위험률을 insert 하는 과정에서 오류 발생')

## ================================================================================================================================== ##

class SearchDB:
    def __init__(self,dbName : str = 'MyDB.db'):
        self.dbName = dbName
        self.conn = sqlite3.connect(self.dbName)
        self.cursor = self.conn.cursor()

    ## ========================== 데이터 베이스 조회 ========================== ##

    def getQx(self, riskCode : str, sex : int = 1, \
        sub1 : str = None, sub2 : str = None, sub3 :str = None, sub4 : str = None) -> np.array:
        qx = np.zeros(120, dtype=float)
        try:
            # query template
            query = f"SELECT DISTINCT x, {'Male' if sex ==1 else 'Female'} FROM RiskRate WHERE RiskCode = '{riskCode}';"       
            # 쿼리 구문 
            if sub1 != None:query += f" AND SUB1 = '{sub1}'"
            if sub2 != None:query += f" AND SUB2 = '{sub2}'"
            if sub3 != None:query += f" AND SUB3 = '{sub3}'"
            if sub4 != None:query += f" AND SUB4 = '{sub4}'"
            # 쿼리 실행
            self.cursor.execute(query)
            fetched = self.cursor.fetchall()
            if len(fetched) == 0:
                raise Exception(f"getQx---> 조회된 위험률이 없음 \n {query}")
            for (age, rate) in fetched:
                qx[age] = rate
            return np.array(qx)
        except:
            raise Exception(f"getQx ---> 쿼리 실행 실패 \n {query}")  

    def getExitInfo(self, CoverageKey : str, BenefitNum : int = None):
        try:
            if BenefitNum == None:
                query = f"SELECT DISTINCT * FROM ExitInfo WHERE CoverageKey = '{CoverageKey}';"
            else:
                query = f"SELECT DISTINCT * FROM ExitInfo WHERE CoverageKey = '{CoverageKey}' AND BenefitNum = {BenefitNum};"
            self.cursor.execute(query)
            fetched = self.cursor.fetchall()
            return fetched            
        except:
            raise Exception(f"getExitInfo ---> 탈퇴율 정보 불러오던 중 오류 발생 \n 담보키 : {CoverageKey} 급부번호 : {BenefitNum} \n {query}")
    
    def getBenefitInfo(self, CoverageKey : str, BenefitNum : int = None):
        try:
            if BenefitNum == None:
                query = f"SELECT DISTINCT * FROM BENEFITINFO WHERE CoverageKey = '{CoverageKey}'"
            else:                
                query = f"SELECT DISTINCT * FROM BENEFITINFO WHERE CoverageKey = '{CoverageKey}' AND BenefitNum = {BenefitNum};"
            self.cursor.execute(query)
            fetched = self.cursor.fetchall()
            return fetched   
        except:
            raise Exception(f"getBenefitInfo ---> 급부율 정보 불러오던 중 오류 발생 \n 담보키 : {CoverageKey} 급부번호 : {BenefitNum} \n {query}")

    def getGrantInfo(self, CoverageKey : str):
        try:
            query = f"SELECT DISTINCT * FROM GrantInfo WHERE CoverageKey = '{CoverageKey}';"
            self.cursor.execute(query)
            fetched = self.cursor.fetchall()
            return fetched
        except:
            raise Exception(f"getGrantInfo ---> 납면율 정보 불러오던 중 오류 발생  \n {query}") 

    def getCombInfo(self, CoverageKey : str):
        try:
            query = f"SELECT DISTINCT CombRiskCode, Operation, NumRiskCode, \
                RiskCode1,Period1,RiskCode2,Period2,RiskCode3,Period3,RiskCode4,Period4, \
                    RiskCode5,Period5,RiskCode6,Period6,RiskCode7,Period7,RiskCode8,Period8 \
                        FROM CombInfo WHERE CoverageKey = '{CoverageKey}';"
            self.cursor.execute(query)
            fetched = self.cursor.fetchall()
            return fetched
        except:
            raise Exception(f"getCombInfo ---> 결합위험률 정보 불러오던 중 오류 발생 \n 담보키 : {CoverageKey} \n {query}") 


## ================================================================================================================================== ##

class Util(SearchDB):    
    def __init__(self,dbName : str = 'MyDB.db', fillna :str = "ZZ"):
        SearchDB.__init__(self, dbName=dbName)
        self.dbName = dbName
        self.fillna = fillna

    def getInfos(self, coverageKey : str):
        exit_info = self.getExitInfo(coverageKey)
        benefit_info = self.getBenefitInfo(coverageKey)
        grant_info = self.getGrantInfo(coverageKey)
        return exit_info, benefit_info, grant_info



    # 결합위험률 계산
    def updateCombRiskRateValue(self, coverageKey : str, x : int, \
        sub1 : int = None, sub2 :int = None, sub3 : int = None, sub4 : int = None) -> pd.DataFrame:
        comb_info = self.getCombInfo(coverageKey)

        for info in comb_info:
            qx_comb = np.zeros(120-x)
            combRiskCode, operation, numRiskKey = info[:3]
            riskCodes, periods = info[3::2][:numRiskKey], info[4::2][:numRiskKey]
            # 1 ---> q_comb = (1-k1)q1+(1-k2)q2+(1-k3)q3+...
            if operation == 1:
                qx_comb_male = self.combOperation1(riskCodes, periods, x, 1)
                qx_comb_female = self.combOperation1(riskCodes, periods, x, 2)
            # 2 ---> q_comb = 1-(1-k1 x q1)(1-k2 x q2)(1-k3 x q3) ...
            elif operation == 2:
                qx_comb_male = self.combOperation2(riskCodes, periods, x, 1)
                qx_comb_female = self.combOperation2(riskCodes, periods, x, 2)
            else:
                raise Exception(f"operation 컬럼은 1, 2만 가능한데 {operation}가 들어옴")

            for i in range(120-x):
                self.insertCombRiskRateValue(combRiskCode=combRiskCode, x= i+x, \
                    male = qx_comb_male[i], female = qx_comb_female[i], riskName=coverageKey)   

    def insertCombRiskRateValue(self, combRiskCode : str, x : int , male : float, female : float, riskName : str = None):
        try:
            insert_query = "INSERT OR REPLACE INTO RiskRate VALUES (?,?,?,?,?,?,?,?,?);"
            self.conn.execute(insert_query, \
                (combRiskCode, self.fillna, self.fillna, self.fillna, self.fillna,\
                    x, male, female, riskName))
            self.conn.commit()
        except:
            raise Exception('insertRiskRateValues ---> DB에 위험률을 insert 하는 과정에서 오류 발생')  

    def combOperation1(self, riskCodes : list, periods : list, x : int, sex : int = 1):
        if len(riskCodes) != len(periods):
            raise Exception("riskCodes배열과 periods배열의 길이가 일치하지 않음")
        qx_comb = np.zeros(120-x)
        # q_comb = (1-k1)q1+(1-k2)q2+(1-k3)q3+...
        for riskCode, period in zip(riskCodes, periods):            
            qx = self.getQx(riskCode, sex=sex)[x:]
            qx[0] *= 1-(period/12)
            qx_comb += qx

        return qx_comb

    def combOperation2(self, riskCodes : list, periods : list, x : int, sex : int = 1):
        if len(riskCodes) != len(periods):
            raise Exception("riskCodes배열과 periods배열의 길이가 일치하지 않음")        
        # q_comb = (1-k1)q1+(1-k2)q2+(1-k3)q3+...
        product = np.ones(120-x, dtype=float) 
        for riskCode, period in zip(riskCodes, periods):     
            qx = self.getQx(riskCode, sex=sex)[x:]
            k_ = np.zeros(120-x)
            k_[0] = 1-period/12
            product *= 1-(1-k_)*qx
        qx_comb = 1 - product   

        return qx_comb

