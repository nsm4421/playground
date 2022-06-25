from enum import unique
from tokenize import String
from sqlalchemy import Column, Integer, String
from flaskServer.init_db import Base

class User(Base):
    __tablename__ = 'User'

    uid = Column(Integer, primary_key = True)    
    nickname = Column(String, unique = True)
    
    def __init__(self, uid=None, nickname="unknown"):
        self.uid = uid
        self.nickname = nickname

    def __repr__(self):
        return 'User %r' % (self.uid, self.nickname)


