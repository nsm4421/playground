import uvicorn
import datetime
from fastapi import FastAPI, WebSocket, Request, WebSocketDisconnect
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from manager import ConnectionManager

app = FastAPI()
templates = Jinja2Templates(directory='templates')
manager = ConnectionManager()

def get_time():
    return datetime.datetime.utcnow().strftime('%B %d %Y - %H:%M:%S')


@app.get("/", response_class=HTMLResponse)
async def index(request:Request):
    return templates.TemplateResponse('chat.html', {
        'request':request
    })

@app.websocket("/ws")
async def websocket_endpoint(ws: WebSocket):
    await manager.connect(ws)
    client = ws.client
    await manager.send_personal_message(f"client {client} entered at {get_time()}", ws)
    try:
        while True:
            data = await ws.receive_json()
            msg_template = f"{data['nickname']} >>> {data['msg']}  ({get_time()})"
            await manager.broadcast(msg_template)
    except WebSocketDisconnect:
        manager.disconnect(ws)
        await manager.broadcast(f'{ws.client} left at {get_time()}')
    
if __name__ == "__main__":
    uvicorn.run(
        'main:app',
        host='0.0.0.0',
        port=8080,
        reload=True
    )