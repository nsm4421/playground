from flask import render_template, request
from flaskServer import app


@app.route('/', methods=['GET'])
def index():
    return "Hi"

