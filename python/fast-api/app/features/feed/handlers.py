from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.features.feed.models import FeedModel
from app.features.feed.dtos import CreateFeedDto,FeedResponseDto,UpdateFeedDto

router = APIRouter(
    prefix="/api/feed"
)

@router.post("/", response_model=FeedResponseDto)
async def handle_create_feed(
    payload: CreateFeedDto,
    db: AsyncSession = Depends(get_db)
):
    feed = FeedModel(**payload.model_dump())
    db.add(feed)
    await db.commit()
    await db.refresh(feed)
    return feed

@router.get("/{feed_id}", response_model=FeedResponseDto)
async def handle_find_feed_by_id(
    feed_id: int,
    db: AsyncSession = Depends(get_db)
):
    result = await db.execute(select(FeedModel).filter(FeedModel.id == feed_id))
    feed = result.scalars().first()
    if not feed:
        raise HTTPException(status_code=404, detail="feed not found")
    return feed


@router.put("/{feed_id}", response_model=FeedResponseDto)
async def handle_update_feed(
    feed_id: int,
    payload: UpdateFeedDto,
    db: AsyncSession = Depends(get_db)
):
    result = await db.execute(select(FeedModel).filter(FeedModel.id == feed_id))
    feed = result.scalars().first()
    if not feed:
        raise HTTPException(status_code=404, detail="feed not found")

    for field, value in payload.dict(exclude_unset=True).items():
        setattr(feed, field, value)

    await db.commit()
    await db.refresh(feed)
    return feed


@router.delete("/{feed_id}")
async def handle_delete_feed_by_id(
    feed_id: int,
    db: AsyncSession = Depends(get_db)
):
    result = await db.execute(select(FeedModel).filter(FeedModel.id == feed_id))
    feed = result.scalars().first()
    if not feed:
        raise HTTPException(status_code=404, detail="feed not found")

    await db.delete(feed)
    await db.commit()
    return {"message": "feed deleted successfully"}