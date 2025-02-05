import asyncio
from websockets import ClientConnection, connect
import sqlite3
from sqlite3 import Connection
import json

DB_PATH = "./upbit_data.db"
END_POINT = "wss://api.upbit.com/websocket/v1"
 
def init_db(conn:Connection):
    conn.execute('''CREATE TABLE IF NOT EXISTS TRADE (
        code TEXT,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        trade_price REAL NOT NULL,
        trade_volume REAL NOT NULL,
        ask_bid TEXT,
        prev_closing_price REAL NOT NULL,
        change TEXT,
        change_price REAL NOT NULL,
        best_ask_price REAL NOT NULL,
        best_ask_size REAL NOT NULL,
        best_bid_price REAL NOT NULL,
        best_bid_size REAL NOT NULL
    )''')
    conn.execute('''CREATE TABLE IF NOT EXISTS ORDERBOOK (
        code TEXT,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        ask_size REAL NOT NULL,
        bid_size REAL NOT NULL,
        ask_price REAL NOT NULL,
        bid_price REAL NOT NULL        
    )''')      
    
async def init_socket(ws:ClientConnection):
    j = [
        {"ticket": 'bitcoin-stream-data'},
        {"type": "trade", "codes": ["KRW-BTC"]},
        {"type": "orderbook", "codes": ["KRW-BTC"]}
    ]
    await ws.send(json.dumps(j))
    
async def on_message(conn:Connection, message):
    try:
        j = json.loads(message)
        if j['type'] == 'trade':
            conn.execute('''INSERT INTO TRADE(
                code, 
                timestamp, 
                trade_price, 
                trade_volume, 
                ask_bid, 
                prev_closing_price, 
                change, 
                change_price, 
                best_ask_price, 
                best_ask_size, 
                best_bid_price, 
                best_bid_size
            ) VALUES (
                ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
            )''', (
                j['code'], j['timestamp'], j['trade_price'], j['trade_volume'], \
                    j['ask_bid'], j['prev_closing_price'], j['change'], j['change_price'], \
                        j['best_ask_price'], j['best_ask_size'], j['best_bid_price'], j['best_bid_size'], 
                    ))
        elif j['type'] == 'orderbook':
            orders = j['orderbook_units']
            for o in orders:
                conn.execute('''INSERT INTO ORDERBOOK(
                    code,
                    timestamp,
                    ask_size,
                    bid_size,
                    ask_price,
                    bid_price
                    ) VALUES(
                        ?, ?, ?, ?, ?, ?
                    )''', (
                        j['code'], j['timestamp'], o['ask_size'], o['bid_size'], o['ask_price'], o['bid_price']
                    ))
        else:
            pass
        conn.commit()
    except Exception as e:
        print(e)

async def main():
    with sqlite3.connect(DB_PATH) as conn:
        init_db(conn)
        async with connect(END_POINT) as ws:
            await init_socket(ws)
            while True:
                message = await ws.recv()
                await on_message(conn, message)

if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
            
        
