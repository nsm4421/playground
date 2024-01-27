from fastapi import FastAPI
import uvicorn

from config.config import get_config
from database.connection import database
from routes.index import router_index
from routes.auth import router_auth


def create_app():
    config = get_config('local')
    app = FastAPI()
    database.init_app(app, **config)
    app.include_router(router_index)
    app.include_router(router_auth, tags=['auth'], prefix='/api')
    return app


app = create_app()

if __name__ == '__main__':
    uvicorn.run(
        'main:app',
        host='0.0.0.0',
        port=8080,
        reload=True
    )