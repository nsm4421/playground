from enum import Enum
from fastapi import FastAPI, Path, HTTPException, status
from typing import Optional
from pydantic import BaseModel

# create app
app = FastAPI()

# sample item
sample_items = [
    {'_id' : 0, 'product' : '휴지', 'quantity' : 10, 'price' : 1000},
    {'_id' : 1, 'product' : '과자', 'quantity' : 5, 'price' : 2000},
    {'_id' : 2, 'product' : '음료수', 'quantity' : 20, 'price' : 3000},
]

class Item(BaseModel):

    
    _id : int
    product : Optional[str]
    quantity : Optional[int]
    price : Optional[int]

# ------------------------ Routing ------------------------ #

@app.get('/')
def index():
    return {'msg' : 'index page'}


@app.get('/item/{item_id}')
def get_item(item_id : int = Path(None, description="상품의 고유 번호", ge=0, lt=len(sample_items))):
    return sample_items[item_id]

@app.get('/item')
def get_product(*, item_id : Optional[int] = None, product : str):
    if item_id == None:
        for item in sample_items:
            if item['product'] == product:
                return item
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    else:
        return sample_items[item_id]

@app.post('/add-item')
def add_item(item_id : int, item:Item):
    sample_items.append(item)

