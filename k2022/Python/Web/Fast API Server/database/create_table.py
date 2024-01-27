from enum import unique
from sqlalchemy import DateTime, Enum, MetaData, func
meta = MetaData()
from sqlalchemy import Table, Column, Integer, String, MetaData
import sqlalchemy
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

user = Table(
    'user', meta,
    Column('id', Integer, primary_key=True),
    Column('status', Enum('active', 'deleted', 'blocked'), default='active'),
    Column('email', String(length=30), nullable=True),
    Column('password', String(length=2000), nullable=True),
    Column('nickname', String(length=30), nullable=True, unique=True),
    Column('phone_number', String(length=30), nullable=True, unique=True),
    Column('sns_type', Enum('facebook', 'google', 'email'), nullable=True),
    Column('created_at', DateTime, nullable=False, default=func.utc_timestamp()),
    Column('updated_at', DateTime, nullable=False, default=func.utc_timestamp())
)

DB_USER:str = 'karma'
DB_PASSWORD:str = '1221'
DB_IP:str = 'localhost'
DB_NAME:str = 'myDB'
DB_URL: str = 'mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (
        DB_USER, DB_PASSWORD, DB_IP, DB_NAME
    )        

engine = create_engine(
    url=DB_URL, echo=True

)

meta.create_all(engine)