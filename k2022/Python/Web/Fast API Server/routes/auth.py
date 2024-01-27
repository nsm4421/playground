from datetime import datetime, timedelta
import bcrypt
from fastapi import APIRouter, Depends
from starlette.responses import JSONResponse
from model import BasicUserInfo, Token
import jwt
from sqlalchemy.orm import Session
from database.connection import database
from database.schema import User

router_auth = APIRouter(prefix="/auth")

@router_auth.get('/test')
def test(a):
    return "test"+a

@router_auth.post('/register/email', status_code=201)
async def email_register(user_info :BasicUserInfo , session:Session=Depends(database.session)):
    email = user_info.email
    password = user_info.password    
    
    if (email == None) or (password==None):
        return JSONResponse(
            content=dict(message='email and password is not provided'),
            status_code=400
        )   
    u = User.get(session, email=email)

    if u:
        return JSONResponse(
            content=dict(message='already signed up'),
            status_code=400
        ) 

    password_encoded = password.encode('utf-8')
    password_hashed = bcrypt.hashpw(password=password_encoded, salt=bcrypt.gensalt())   
    User.create(
        session=session, auto_commit=True, email=email, password=password_hashed
    )

    data_to_encode = dict(email=email, expire= str(datetime.utcnow() + timedelta(days=31)))
    token = jwt.encode(data_to_encode,'karma', algorithm="HS256")
    return token
