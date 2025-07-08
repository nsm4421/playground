from sqlalchemy import Column, String
from sqlalchemy.dialects.postgresql import ARRAY
from app.core.database import Base
from app.shared.models import BaseModelMixin

class FeedModel(Base, BaseModelMixin):
    __tablename__ = "feeds"

    title = Column(String, nullable=False)
    content = Column(String, nullable=True)
    hashtags = Column(ARRAY(String), nullable=False)