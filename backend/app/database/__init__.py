from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

from common import config

engine = create_engine(
    config.DB_URL,
    pool_recycle=config.DB_POOL_RECYCLE,
    echo=config.DB_ECHO
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_database():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()