from fastapi import FastAPI
import uvicorn
from app.core.database import Base, engine
from app.features.feed.handlers import router as feed_router

# DB 테이블 생성
Base.metadata.create_all(bind=engine)

app = FastAPI()

# 라우터 등록
app.include_router(feed_router)

if __name__ == "__main__":
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)