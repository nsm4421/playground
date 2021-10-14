from KARMA import app
from flask import render_template, redirect, url_for, request

from KARMA.utils.db_handler import DB_hanlder
from KARMA import firebase

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/signUp')
def signUp():
    return render_template('signUp.html')

@app.route('/signUpAction', methods = ['POST'])
def signUpAction():
    try:
        user_id = request.form['user_id']
        password = request.form['password']
        email = request.form['email']
        nickname = request.form['nickname']
        firebase.signUp(user_id, password, email, nickname)
        print('회원가입성공')
        return redirect(url_for('login')) 
    except:
        return redirect(url_for('signUp')) 

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/loginAction', methods = ['POST'])
def loginAction():
    return "LOGIN ACTION"

@app.route('/<int:num_room>')
def find_room(num_room):
    return "INDEX"