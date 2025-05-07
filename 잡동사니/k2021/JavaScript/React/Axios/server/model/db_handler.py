import sys
import pymysql
# from sqlalchemy import create_engine

class DBHandler():

    def __init__(self, host= 'localhost', username = 'root', password = '1221',\
        db_name = 'LOL'):
        self.host = host
        self.username = username
        self.password = password
        self.db_name = db_name

        try:
            self.conn = pymysql.connect(host=self.host, user=self.username, passwd=self.password,\
                db=self.db_name, connect_timeout=1)
        except Exception as e:
            print(e)
            sys.exit()        
        # db_path = f"mysql+pymysql://{self.username}:{self.password}@{self.host}:3306/{self.db_name}?charset=utf8"
        # self.engine = create_engine(db_path, encoding='utf-8')

    def execute_query(self, query: str):
        try:
            with self.conn.cursor() as cursor:
                cursor.execute(query)
                self.conn.commit()
                return cursor.fetchall()
        except Exception as e:
            print(e)


    