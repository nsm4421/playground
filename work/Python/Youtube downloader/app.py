from flask import Flask, render_template,request, redirect, url_for, session
from pytube import YouTube 

app = Flask(__name__)
app.config['SECRET_KEY'] = '1221'

@app.route("/", methods=['GET'])
def Home():
    return render_template('Home.html')

@app.route("/search", methods=['GET', 'POST'])
def Search():

    
    clip_link = request.form['URL']     # request 받기
    session['clip_link'] = '%s' % clip_link    # session에 추가
    yt = YouTube(clip_link)             # pytube 객체
    title = yt.title                    # 영상 제목
    thumbnail_url = yt.thumbnail_url    # 영상 썸네일 주소
    
    return render_template('Search.html', \
        clip_link=clip_link, title=title, thumbnail_link=thumbnail_url)



@app.route("/download", methods=['POST'])
def Download():

    try:


        clip_link = session['clip_link']
        yt = YouTube(clip_link)
        streams = yt.streams
        best_stream = streams.get_highest_resolution()
        best_stream.download()
        
        session.pop('clip_link', None)


    except:
        print("다운로드 ERROR")      

    return redirect(url_for('Home'))    






if __name__ == '__main__':
    app.debug = True
    app.run(host='localhost', port = 8080)