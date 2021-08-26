from flask_login import UserMixin
from Model.conn_db import conn_mysqldb, conn_mongodb

class User(UserMixin):

    def __init__(self, user_id, user_pw, user_name, user_email, user_tier,\
        user_info = None):
        self.id = user_id
        self.pw = user_pw
        self.name = user_name
        self.email = user_email
        self.tier = user_tier
        self.info = user_info

    def get_id(self):
        return str(self.id)

    # 아이디 user 찾기
    @staticmethod
    def get(user_id):
        # mysql DB 연결
        conn = conn_mysqldb()
        # 커서
        cursor = conn.cursor()
        # 이미 존재하는 아이디인지 조회
        query = f"SELECT * FROM user WHERE user_id = '{user_id}';"
        cursor.execute(query)
        user = cursor.fetchone()
        if not user:    # 없는 아이디
            return None
        else:   
            return User(user_id=user[0], user_pw=user[1], user_name=user[2], \
                user_email=user[3], user_tier=user[4], user_info = user[5])


    # 회원가입
    @staticmethod
    def create(user_id : str, user_pw : str, user_name : str, user_email : str, \
        user_tier : str):
        # mysql DB 연결
        conn = conn_mysqldb()
        # 커서
        cursor = conn.cursor()
        # 이미 존재하는 아이디인지 조회
        query = f"SELECT * FROM user WHERE user_id = '{user_id}';"
        cnt = cursor.execute(query)
        if cnt == 0:    # 없는 아이디
            query2 = f"INSERT INTO USER VALUES('{user_id}', '{user_pw}', '{user_name}', \
                '{user_email}', '{user_tier}', '');"
            cnt2 = cursor.execute(query2)    # 쿼리 실행개수 (0:DB오류 / 1:정상)
            conn.commit()
            return cnt2
        else:
            return cnt


    # 회원탈퇴
    @staticmethod
    def delete(user_id : str):
        # mysql DB 연결
        conn = conn_mysqldb()
        # 커서
        cursor = conn.cursor()
        # 이미 존재하는 아이디인지 조회
        query = f"SELECT * FROM user WHERE user_id = '{user_id}';"
        cnt = cursor.execute(query)
        if cnt==1:    # 존재하는 아이디
            query2 = f"DELETE FROM USER WHERE USER_ID = '{user_id}';"
            cnt2 = cursor.execute(query2)    # 0:DB오류 / 1:정상
            conn.commit()
            return cnt2
        else:       # 오류
            return 0
