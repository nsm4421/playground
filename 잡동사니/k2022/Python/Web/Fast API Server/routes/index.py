from fastapi import APIRouter
from starlette.responses import Response
from starlette.requests import Request

router_index = APIRouter()

@router_index.get('/')
async def index():
    return {'test':"HI"}
