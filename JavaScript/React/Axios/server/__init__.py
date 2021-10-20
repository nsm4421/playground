from flask import Flask
from flask_cors import CORS
from server import config

# app 만들기
app = Flask(__name__)

# config
app.config.from_object(config)

# CORS 설정 
CORS(app)

# blueprint
from server.routes.route_auth import bp_auth
app.register_blueprint(bp_auth)
