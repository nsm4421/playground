from flask import Flask, jsonify, request
from flask_cors import CORS
import ast

app = Flask(__name__)
CORS(app, resources={r'*': {'origins': '*'}})   # COR 설정 해제


@app.route('/api/AddCoverage', methods=['POST'])    
def addCoverage():
    try:
        data_str = request.data
        decoded = f"'{data_str.decode('UTF-8')}'"
        data = ast.literal_eval(decoded)    # string ---> dictionary
        return jsonify({'status' : True})
    except:
        return jsonify({'status' : False})

if __name__ == "__main__":
    app.run(port = 4000)        # 4000번 포트
    app.debug = True            # 디버깅모드