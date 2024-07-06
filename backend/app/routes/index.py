from fastapi import APIRouter, Depends, Response
from sqlalchemy.orm import Session

from database import get_database
from model.account import Account

router = APIRouter()

@router.get('/', description='TEST')
async def index(nickname: str, description: str,
    session:Session = Depends(get_database)):
    account = Account(nickname=nickname, description=description)
    session.add(account)
    session.commit()
    return Response(f'User Added nickname:{nickname}|descripton:{description}')