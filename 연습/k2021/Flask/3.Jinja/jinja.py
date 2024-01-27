from flask import Flask, jsonify, request, render_template

app = Flask(__name__, static_url_path = '/static')

# Index Page
@app.route("/")     
def index():
    return "<h1>Jinja Template 실습</h1>"

# 변수
@app.route("/greeting")
def greeting():
    return render_template('greeting.html', name = "Karma")

# 반복문
@app.route("/loop")
def loop():
    items = ['카르마', '베이가', '질리언', '트위치']
    return render_template('loop.html', items = items)

@app.route("/condition/<int:score>")
def condition(score):
    return render_template('condition.html', score = score)
    

if __name__=='__main__':
    app.debug = True    # debug mode
    app.config['JSON_AS_ASCII'] = False
    app.run(host="0.0.0.0", port="8080")