import json
from flask import Flask, jsonify, redirect, render_template, request
from pytube import YouTube 

app = Flask(__name__)

# Index Page
@app.route("/")
def index():
    return render_template('index.html')
   
@app.route('/download', methods=['GET', 'POST'])
def download():

    if request.method == 'GET':
        req_params = request.args.to_dict()
        link = req_params.get('link')
        try:
            yt = YouTube(link)
            req_params['title'] = yt.title    
            req_params['length']=yt.length
            req_params['thumbnail_url']=yt.thumbnail_url
            req_params['numView']=yt.views
            req_params['description']=yt.description
            return render_template('download.html', **req_params)
        except:
            redirect('/')

    elif request.method == 'POST':
        req_data = json.loads(request.get_data().decode())
        link = req_data.get('link')
        option = req_data.get('option')
        yt = YouTube(link)
        try:
            if option.upper() == "AUDIO":   
                my_stream = yt.streams.filter(only_audio=True)[0]
            else: 
                my_stream = yt.streams.get_highest_resolution()
            
            my_stream.download(output_path='./clip')
            return jsonify(isDownSuccess=True)
        except:
            return jsonify(isDownSuccess=False)
    else:
        redirect('/')


if __name__=='__main__':
    app.debug = True    
    app.run(host="0.0.0.0")