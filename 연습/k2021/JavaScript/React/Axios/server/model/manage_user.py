import os
from server.model.db_handler import DBHandler

class ManageUser:
    def __init__(self):

        self.dbh = DBHandler()
    
    # 회원정보조회
    def search(self, user_id):
        try:
            # 아이디 중복여부 체크
            query = f"SELECT * FROM USER WHERE USER_ID='{user_id}';"
            return self.dbh.execute_query(query = query)
        except:
            return {'Fail' : 'DB failure'}

    # 회원가입
    def register(self, user_id, password, email, nickname):
        try:
            # 아이디 중복여부 체크
            cnt = len(self.search(user_id)) 
            if cnt > 0:
                return {'FAIL' : 'Already same user id exist'}
            else:
                # 회원가입정보 저장
                query = f"INSERT INTO USER VALUES('{user_id}','{password}','{email}','{nickname}');"
                self.dbh.execute_query(query = query)
                return {'Success' : 200}
        except:
            return {'Fail' : 'DB failure'}

    # 비번 수정
    def changePassword(self, user_id, new_password):
        try:
            if len(self.search(user_id)) == 0:
                return {'Fail' : f'No user with user id : {user_id}'}
            elif len(self.search(user_id)) >1:
                return {'Fail' : 'DB failure'}
            else:
                query = f"UPDATE USER SET PASSWORD = '{new_password}' WHERE USER_ID='{user_id}';"
                self.dbh.execute_query(query=query)
                return {'Success':200}
        except:
            return {'Fail':'DB failure'}

    # 회원탈퇴
    def withdrawal(self, user_id):
        try:
            if len(self.search(user_id)) == 0:
                return {'Fail' : f'No user with user id : {user_id}'}
            query = f"DELETE FROM USER WHERE USER_ID='{user_id}';"
            self.dbh.execute_query(query=query)
            return {'Success':200}
        except:
            return {'Fail':'DB failure'}
            
            
