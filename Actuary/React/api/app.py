from flask import Flask, jsonify, request
from flask_cors import CORS
import json
from glob import glob

from pandas import json_normalize

app = Flask(__name__)
CORS(app, resources={r'*': {'origins': '*'}})   # COR 설정 해제

@app.route('/api/ShowCoverage', methods=['GET'])    
def showCoverage():
    jsonPathLst = glob("./api/covJson/*.json")
    try:

        jsonLst = []
        for jPath in jsonPathLst:
            with open(jPath, 'r') as j:
                jsonLst.append(json.load(j))
        return jsonify({'status' : True, 'message' : f'{len(jsonLst)}개의 담보정보 전송', 'covJsonList' : jsonLst})
    except:
        return jsonify({'status' : False, 'message' : 'ERR', 'covJsonList' : [{}]})


@app.route('/api/AddCoverage', methods=['POST'])    
def addCoverage():
    try:
        jsonRes = request.get_json()
        with open(f'./api/covJson/{dict(jsonRes)["Coverage"]}.json', 'w') as j:
            json.dump(jsonRes, j)       
        return jsonify({'status' : True, 'message' : 'OK'})
    except:
        return jsonify({'status' : False, 'message' : 'ERR'})

if __name__ == "__main__":
    app.run(port = 4000)        # 4000번 포트
    app.debug = True            # 디버깅모드