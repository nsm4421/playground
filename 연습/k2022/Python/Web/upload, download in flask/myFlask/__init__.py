from flask import Flask, jsonify, redirect, render_template, request, send_file
from werkzeug.utils import secure_filename
import os

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload():
    file_to_upload = request.files['file']
    file_name = secure_filename(file_to_upload.filename)
    save_path = os.path.join('myFlask', 'static', file_name)
    file_to_upload.save(save_path)
    return redirect('/')

@app.route('/download', methods=['GET'])
def download():
    return send_file('./static/test.jpg', as_attachment=True)   