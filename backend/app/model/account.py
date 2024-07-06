from sqlalchemy import Column, Integer, String
from database import Base

class Account(Base):
    __tablename__ = 'ACCOUNT'
    id=Column(Integer, primary_key=True, index=True)
    nickname=Column(String, index=True)
    description=Column(String, index=True)
    