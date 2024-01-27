from server import app
import os
import json
from flask import request, jsonify

@app.route('/')
def index():
    return "<h1> HI </h1>"

@app.route('/test')
def test():
    # json 파일 읽기
    with open('./server/data/sample.json', 'r', encoding='utf-8') as j:
        json_data = json.load(j)    
    return jsonify(json_data)

