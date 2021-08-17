import pymysql
import pymongo

# Host
MYSQL_HOST = 'localhost'
MONGO_HOST = 'localhost'

# Connection
conn_mysql = pymysql.connect(
            host = 'MYSQL_HOST',
            port = 3306,    
            user = 'root',
            passwd= '1221',
            db = 'LOL',
            charset='utf8')
conn_mongo = pymongo.MongoClient(f'mongodb://{MONGO_HOST}')


# MySQL
def conn_mysql():
    if not conn_mysql.open:     # 연결이 안된 경우
        conn_mysql.ping(reconnect = True)   # 재연결
    return conn_mysql


# MongoDB
def conn_mongodb():
    global conn_mongo
    try:    # 연결되어 있는지 확인
        conn_mongo.admin.command('ismaster')  
    except:    # 다시 연결
        conn_mongo = pymongo.MongoClient(f'mongodb://{MONGO_HOST}')
    finally:
        lol_ab = conn_mongo.lol_session_db.lol_ab
    return lol_ab

