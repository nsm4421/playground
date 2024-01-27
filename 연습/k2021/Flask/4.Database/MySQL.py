import pymysql

# Connection 
conn = pymysql.connect(
    host = 'localhost',
    port = 3306,    # mysql port번호 default 
    user = 'root',
    passwd= '1221',
    db = 'LOL',
    charset='utf8'
)

# Cursor
cursor = conn.cursor()

## 데이터베이스 내 존재하는 테이블 조회
query_tables = 'show tables;'
result_tables = cursor.execute(query_tables)
print(f"Tables in database LOL : {result_tables}")

## 테이블 만들기
query_create = """
CREATE TABLE USER (
    USER_ID VARCHAR(20) NOT NULL,
    USER_PASSWORD VARCHAR(20) NOT NULL,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_EMAIL VARCHAR(100) NOT NULL, 
    USER_TIER VARCHAR(10) NOT NULL,
    USER_INFO VARCHAR(10),
    PRIMARY KEY (USER_ID)
);
"""
# 쿼리 실행
cursor.execute(query_create)

## 레코드 삽입하기
# Query Template
query_insert = """
INSERT INTO USER (USER_ID, USER_PASSWORD, USER_NAME, USER_EMAIL, USER_TIER, USER_INFO)
VALUES ('카르마', '1221', '상도동 카르마', '카르마@naver.com', '챌린저', '역천괴');
""" 
query_insert2 = """
INSERT INTO USER (USER_ID, USER_PASSWORD, USER_NAME, USER_EMAIL, USER_TIER, USER_INFO)
VALUES ('트위치', '1221', '상도동 트위치', '트위치@naver.com', '챌린저', '괴물쥐');
""" 
# 쿼리 실행
cursor.execute(query_insert)
cursor.execute(query_insert2)

## 조회
# Query Template
query_select = """
SELECT USER_NAME FROM USER WHERE USER_TIER = '챌린저';
"""
# 쿼리 실행
cursor.execute(query_select)
result_select = cursor.fetchall()
for result in result_select:
    print(f"{result[0]}은 챌린저임")


# 커밋
conn.commit()

# 연결 종료
conn.close()