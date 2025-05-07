from flask import Flask, jsonify, request

app = Flask(__name__)

# Index Page
@app.route("/")     
def index():
    return "<h1> Hello World </h1>"

# test page
@app.route("/test")     
def test():
    return "<h1> Test Page </h1>"

# 주소 할당하기
@app.route("/user/<string:username>")     
def Greeting(username):
    return f"<h1> Hi {username} </h1>"

# Dictionary ---> Json
@app.route("/jsonTest/<string:username>", methods=['GET'])     
def JsonTest(username):
    if len(username)<3:
        return "유저 이름 좀 이상함"
    else:
        userDict = {"성" : username[0], \
            '이름' : username[1:]}
        return jsonify(userDict)

@app.route("/login")
def login():
    user_id = request.args.get("user_id")
    password = request.args.get('password')
    if user_id=="Karma":
        return_data = {'auth' : 'success'}
    else:
        return_data = {'auth' : 'failure'}
    return jsonify(return_data)


if __name__=='__main__':
    app.debug = True    # debug mode
    app.config['JSON_AS_ASCII'] = False
    app.run(host="0.0.0.0", port = "8080")