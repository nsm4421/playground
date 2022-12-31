from fastapi import FastAPI
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base  
import logging

class MySQLAlchemy:
    def __init__(cls, app:FastAPI=None):
        cls._engine=None
        cls._session=None
    
    @classmethod
    def init_app(cls, app:FastAPI, **kds):
        db_url = kds.get('DB_URL')
        db_pool_recycle = kds.setdefault('DB_POOL_RECYCLE', 900)
        db_echo = kds.setdefault("DB_ECHO", True)

        cls._engine = create_engine(
            url=db_url, echo=db_echo, pool_recycle=db_pool_recycle
        )
        cls._session = sessionmaker(
            autocommit=False, autoflush=False, bind=cls._engine
        )

        @app.on_event('startup')
        def start_up():
            cls._engine.connect()
            logging.info('Database connected...')

        @app.on_event('shutdown')
        def shut_down():
            cls._session.close_all()
            cls._engine.dispose()
            logging.info('Database disconnected...')

    
    @classmethod
    def get_db_session(cls):
        if cls._session == None:
            raise Exception('session not exists...')
        db_session = None
        try:
            db_session = cls._session()
            yield db_session
        finally:
            db_session.close()
        
    @property
    def session(cls):
        return cls.get_db_session

    @property
    def engine(cls):
        return cls._engine
            
database = MySQLAlchemy()
base = declarative_base()