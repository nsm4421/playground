import pymongo

# Connection
conn = pymongo.MongoClient("mongodb://localhost")

# 잘 연결되었는지 확인
print('='*20 + "연결 확인" + "="*20)
print(conn.admin.command('ismaster'))
print('='*20 + "서버정보" + "="*20)
print(conn.server_info())
print('='*45)

# Database
lol_session_db = conn.lol_session_db
print(lol_session_db)
print('='*45)

# Collection
lol_ab = lol_session_db.lol_ab
print(lol_ab)

