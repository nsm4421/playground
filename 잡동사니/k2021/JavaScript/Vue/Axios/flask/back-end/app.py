from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
app.config.from_object(__name__)
# CORS(app,  resources={r'*': {"origins": "*"}})

@app.route('/', methods=['GET', 'POST'])
def index():
    try:
        print(f"{request.args['player']} 선수 : count {request.args['count']} 번")
    except:
        pass
    return "<h1> Hi </h1>"

if __name__ == '__main__':
    app.run(port = 5000, debug=True)