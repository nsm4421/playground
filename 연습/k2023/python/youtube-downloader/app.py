import json
from flask import Flask, jsonify, request, send_file
import os
from pytube import YouTube 

app = Flask(__name__)

def parse_request(request):
    return json.loads(request.get_data().decode())

def extract_meta_data(yt:YouTube):
    return {
        'title':yt.title,
        'length':yt.length,
        'thumbnail':yt.thumbnail_url,
        'numView':yt.views,
        'description':yt.description
    }

@app.route("/files")
def get_mp4_file_path():
    files = os.listdir(os.path.join(os.curdir, "downloaded"))
    return [f for f in files if f.endswith(".mp4")]

@app.route('/downloaded/<string:video>')
def video(video):
    return send_file(os.path.join(os.curdir, "downloaded", video))

@app.route("/meta", methods=['POST'])
def get_meta_data():
    # parsing post request
    req = parse_request(request)

    # create youtube instance
    yt = YouTube(req.get("ytLink"))

    # return meta data
    return {
        'title':yt.title,
        'length':yt.length,
        'thumbnail':yt.thumbnail_url,
        'numView':yt.views,
        'description':yt.description
    }

@app.route('/download', methods=['POST'])
def download():
    # parsing post request
    req = parse_request(request)

    # create youtube instance
    yt = YouTube(req.get("ytLink"))
    
    # get stream to download
    if req.get('isAudio'):
        stream = yt.streams.filter(only_audio=True)[0]
    else:
        stream = yt.streams.get_highest_resolution()

    # download
    try:
        stream.download("./downloaded")
        return jsonify({"isSuccess":True})
    except:
        return jsonify({"isSuccess":False})

if __name__=='__main__':
    app.debug = True    
    app.run(host="0.0.0.0")