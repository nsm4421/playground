from flask import Flask, g, request
from datetime import timedelta
import os
from flaskServer.init_db import init_database, remove_session

app = Flask(__name__)
import flaskServer.views   # <-- app을 생성하고, 그 뒤에 import

app.debug = True                                                    # debug mode
app.jinja_env.trim_blocks = True


@app.before_first_request
def beforeFirstRequest():
    init_database()               # initialize mysql database 

@app.after_request
def afterReq(response):
    print(">> after_request!!")
    return response


@app.teardown_request
def teardown_request(exception):
    print(">>> teardown request!!", exception)


@app.teardown_appcontext
def teardown_context(exception):
    remove_session()