from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.ext.declarative import declarative_base

user = "karma"
password = "1221"
ip = "localhost"
db_name="myDB"
db_url = f"mysql+pymysql://{user}:{password}@{ip}/{db_name}?charset=utf8"
engine = create_engine(db_url, echo=True, convert_unicode=True)
db_session = scoped_session(sessionmaker(
    autocommit=False,   # for transcation management 
    autoflush=False, bind=engine))
Base = declarative_base()
Base.query = db_session.query_property()

def init_database():
    Base.metadata.create_all(bind=engine)

def remove_session():
    db_session.remove()