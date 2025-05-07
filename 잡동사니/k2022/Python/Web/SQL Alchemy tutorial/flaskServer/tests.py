from flaskServer.models import User
from flaskServer.init_db import db_session
from sqlalchemy.exc import SQLAlchemyError

def addUser(uid:str, nickname:str=None):
    u = User(uid, nickname)
    try:
        db_session.add(u)
        db_session.commit()
    except SQLAlchemyError as e:
        db_session.rollback()
        print("SQL Alchemy Error : ", e)
    except:
        print("Error")
    
def deleteUser(uid:str):
    try:
        user = User.query.filter(User.uid == uid).first()
        db_session.delete(user)
        db_session.commit()
    except SQLAlchemyError as e:
        db_session.rollback()
        print("SQL Alchemy Error : ", e)
    except:
        print("Error")
