from enum import Enum

from sqlalchemy import Column, String
from database import Base
from base_mixin import BaseMixIn

class AccountModel(BaseMixIn, Base):
    __tablename__ = 'ACCOUNT'
    email = Column(String(length=255), unique=True)
    password = Column(String(length=255), nullable=True)
    username = Column(String(length=255), unique=True)
    status = Column(Enum('active', 'deleted', 'blocked'), default='active')