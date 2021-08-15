import threading
from flask import Flask, jsonify, request, render_template

app = Flask(__name__, static_url_path = '/static')

# Index Page
@app.route("/")     
def index():
    return "<h1>Bootstrap으로 로그인 페이지 만들어해보기</h1>"

# Login
@app.route("/login")
def login():
    return render_template('login.html')


if __name__=='__main__':
    app.debug = True    # debug mode
    app.config['JSON_AS_ASCII'] = False
    app.run(host="0.0.0.0", port="8080")