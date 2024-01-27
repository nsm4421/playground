import sqlite3
import pandas as pd
from tqdm import tqdm

class MyDB:
    def __init__(self, dbName : str = "Qx.db"):
        self.dbName = dbName    # 데이터베이스 이름
        try:
            self.conn = sqlite3.connect(f'./{dbName}') # dbName이라는 데이터베이스와 연결 (dbName이라는 이름의 데이터베이스가 없으면 생성)
            self.cursor = self.conn.cursor()
        except:
            raise Exception('DB 연결 실패함')

    def readExcelSheet(self,  excelFilePath : str = './INFO_N.xlsx', sheetName : str = "위험률", header : int = 1, fillna : str = "ZZ"):
        """
        Excel 파일에서 위험률 정보를 로드하기
        """
        try:
            self.sht_rate = pd.read_excel(excelFilePath, sheet_name=sheetName, header=header)
            self.sht_rate = self.sht_rate[['위험률코드','보조키1','보조키2','보조키3','보조키4','가입연령','남자','여자','위험률명']].fillna(fillna)
            self.sht_rate['남자'] = self.sht_rate['남자'].apply(lambda x:0 if x == fillna else x)
            self.sht_rate['여자'] = self.sht_rate['여자'].apply(lambda x:0 if x == fillna else x)
            print(f"{excelFilePath}로부터 {sheetName} 시트 정보 읽음 ---> {self.sht_rate.shape[0]} 건")
        except:
            raise Exception('위험률이 있는 엑셀파일을 불러오는데 실패함')

    def makeTable(self):
        """
        RISKRATE 라는 테이블을 만드는 쿼리 실행
        """
        query = """
        CREATE TABLE IF NOT EXISTS RISKRATE (
        RiskCode TEXT NOT NULL,
        Sub1 TEXT, 
        Sub2 TEXT, 
        Sub3 TEXT,
        Sub4 TEXT,
        x INTEGER, 
        Male REAL, 
        Female REAL, 
        RiskName TEXT);
        """
        try:
            self.conn.execute(query)
            self.conn.commit()
            print("테이블 생성 완료")
        except:
            raise Exception('DB에서 테이블 만드는데 실패')

    def insertValues(self):
        """
        엑셀시트에서 읽은 위험률을 DB로 저장하는 쿼리를 실행
        """
        try:
            insert_query = "INSERT INTO RISKRATE VALUES (?,?,?,?,?,?,?,?,?);"
            for row in tqdm(self.sht_rate.values):           
                self.conn.execute(insert_query, row)
            self.conn.commit()
            print(f"{self.sht_rate.shape[0]}건 데이터 삽입 완료")
        except:
            raise Exception('위험률 DB에 insert 하는 과정에서 오류 발생')

    def executeQuery(self, query):
        """
        입력한 쿼리를 실행
        """
        try:
            return self.conn.execute(query)
        except:
            return Exception(f"쿼리 실행 실패 \n {query}")

    def getQx(self, riskCode : str, sex : int = 1, x : int = None, \
        sub1 : str = None, sub2 : str = None, sub3 :str = None, sub4 : str = None):
        """
        조건에 맞는 위험률을 fetch
        """
        try:
            # query template
            query = f"SELECT x, {'Male' if sex ==1 else 'Female'} FROM RISKRATE WHERE RiskCode = '{riskCode}'"        
            # 쿼리 구문 
            if sub1 != None:query += f" AND SUB1 = '{sub1}'"
            if sub2 != None:query += f" AND SUB2 = '{sub2}'"
            if sub3 != None:query += f" AND SUB3 = '{sub3}'"
            if sub4 != None:query += f" AND SUB4 = '{sub4}'"
            if x != None:query += f" AND x = {x};"
            # 쿼리 실행
            self.cursor.execute(query)
            fetched = self.cursor.fetchall()
            if len(fetched) == 0:
                raise Exception("조회된 위험률이 없음 \n {query}")
            return fetched
        except:
            raise Exception(f"쿼리 실행 실패 \n {query}")


class MyInfo:

    def __init__(self,  excelFilePath : str = './INFO_N.xlsx', sheetName : str = "상품정보", header : int = 1, fillna : str = "ZZ"):
        self.excelFilePath = excelFilePath
        self.sheetName = sheetName
        self.fillna = fillna

        try:
            self.sht_code = pd.read_excel(excelFilePath, sheet_name=sheetName, header=header)
            self.sht_code = self.sht_code[['담보키','급부번호','탈퇴율코드','탈퇴율종류', \
                '부담보기간','급부율코드','급부율종류','지급률','감액률','감액기간',\
                    '납면율코드','납면율종류','무효해지']].fillna(fillna)
            print(f"{excelFilePath}로부터 {sheetName} 시트 정보 읽음")
        except:
            raise Exception('위험률이 있는 엑셀파일을 불러오는데 실패함')

    def getExitInfo(self, coverageKey : str, benefitNum : int):
        try:
            if benefitNum not in range(99):
                raise Exception("급부번호 번호 0~98번")
            df = self.sht_code.copy(deep=True)
            df = df.loc[df['담보키' == coverageKey]]
        except:
            raise Exception(f"탈퇴율 정보 불러오던 중 오류 발생 \n 담보키 : {coverageKey} 급부번호 : {benefitNum}")
