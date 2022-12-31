from sqlalchemy import Column, DateTime, Enum, Integer, String, func
from sqlalchemy.orm import Session, relationship
from database.connection import database, base

class BaseMixin:
    id=Column(Integer, primary_key=True, index=True)
    created_at = Column(DateTime, nullable=False, default=func.utc_timestamp())
    updated_at = Column(DateTime, nullable=False, default=func.utc_timestamp())

    def __init__(cls):
        cls._session = None

    @staticmethod
    def set_session(session:Session=None)->Session:

        if session == None:
            session = next(database.session())
        return session
    
    @classmethod
    def get(cls, session:Session=None, **kds):
        session=cls.set_session()
        query = session.query(cls)
        for (k, v) in kds.items():
            col = getattr(cls, k)
            query = query.filter(col == v)
        if query.count()>1:
            raise Exception("There's overlap in %s" %(cls.__tablename__))
        res = query.first()
        if session != None:
            session.close()
        return res

    @classmethod
    def create(cls, session:Session=None, auto_commit=False, **kds):
        session=cls.set_session()
        obj = cls()
        for c in obj.columns:
            if (c.name in kds) and (c.name not in ['id','create_at']):
                setattr(obj, c.name, kds.get(c.name))
        session.add(obj)
        session.flush()
        if auto_commit:
            session.commit()
        return obj

    @property
    def columns(cls):
        return cls.__table__.columns

    @property
    def hashed_id(cls):
        return hash(cls.id)

class User(base, BaseMixin):
    __tablename__ = 'user'
    status=Column(Enum('active', 'deleted', 'blocked'), default='active')
    email=Column(String(length=30), nullable=True)
    password=Column(String(length=2000), nullable=True)
    nickname=Column(String(length=30), nullable=True, unique=True)
    phone_number=Column(String(length=30), nullable=True, unique=True)
    sns_type = Column(Enum('facebook', 'google', 'email'), nullable=True)
    
