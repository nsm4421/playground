import flask
from flask import Flask
from flask_cors import CORS
from KARMA.utils.db_handler import DB_hanlder 

firebase = DB_hanlder()

app = Flask(__name__)
from KARMA.routes import route
CORS(app)





