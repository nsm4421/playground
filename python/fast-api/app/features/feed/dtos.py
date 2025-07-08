from typing import List, Optional
from datetime import datetime
from pydantic import BaseModel, Field

class CreateFeedDto(BaseModel):
    title: str = Field(..., min_length=1)
    content: str = Field(..., min_length=1)
    hashtags: Optional[List[str]] = Field(default=None, max_items=5)

class UpdateFeedDto(BaseModel):
    title: Optional[str] = None
    content: Optional[str] = None
    hashtags: Optional[List[str]] = Field(default=None, max_items=5)

class FeedResponseDto(BaseModel):
    id: int
    title: str
    content: Optional[str]
    hashtags: List[str]
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
