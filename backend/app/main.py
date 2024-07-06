from fastapi import FastAPI
from dataclasses import asdict

import uvicorn
from common import config
from routes import index_router

def create_app():
    # 앱 생성
    app = FastAPI()
        
    # 라우팅
    app.include_router(index_router)
    return app

app = create_app()

if __name__ == '__main__':
    uvicorn.run('main:app', host='0.0.0.0', port=8080, reload=config.PROJECT_RELOAD)
