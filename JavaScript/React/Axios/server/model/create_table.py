import pymysql
# from server.model.db_handler import DBHandler
from db_handler import DBHandler

# Usage
# cd /server/model
# python create_table.py

dbh = DBHandler()

if __name__ == '__main__':
    try:
        query = "CREATE TABLE USER (USER_ID VARCHAR(30) PRIMARY KEY,\
            PASSWORD VARCHAR(30) NOT NULL, EMAIL VARCHAR(30) UNIQUE,\
                NICKNAME VARCHAR(30) UNIQUE);"    
        dbh.execute_insert_query(query)
        print('USER table created')
    except:
        print('ERROR : USER is not created')