from flask import Flask
from flask_cors import CORS

# app 만들기
app = Flask(__name__)

# CORS 설정 
CORS(app)

# routing 경로 설정한 내용 import
from server.routes import route
