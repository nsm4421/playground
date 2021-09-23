import flask
from flask_cors import CORS 
from flask import Flask,render_template, request


app = Flask(__name__)

@app.route('/')
def index():
    return render_template('./index.html')

@app.route('/test', methods=['POST'])
def test():
    message = request.args.get("message")
    return str(message)


if __name__=='__main__':
    app.config['JSON_AS_ASCII'] = False
    CORS(app)
    app.run(port=5000, debug=True)