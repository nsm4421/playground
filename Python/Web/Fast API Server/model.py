from datetime import datetime
from enum import Enum
from typing import List

from pydantic import Field
from pydantic.main import BaseModel
from pydantic.networks import EmailStr, IPvAnyAddress

class BasicUserInfo(BaseModel):
    email:str=None
    password:str=None

class SnsType(str, Enum):
    email:str='email'
    facebook:str='facebook'
    google:str='google'

class Token(BaseModel):
    id: int
    email: str = None
    nickaname: str = None
    phone_number: str = None
    sns_type: str = None

    class Config:
        orm_mode = True

