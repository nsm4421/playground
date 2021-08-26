from flask import Flask, Blueprint, request, render_template, make_response, jsonify, redirect, url_for
from flask_login import login_user, current_user, logout_user
import datetime


from Control.manage_user import User

myApp = Blueprint('myApp', __name__)

@myApp.route('/')
def index():
    return render_template('index.html')

@myApp.route('/login')
def login():
    return render_template('login.html')

@myApp.route('/loginAction', methods=['POST'])
def loginAction():
    user_id_given = request.form['user_id']
    user_pw_given = request.form['user_pw']

    user = User.get(user_id_given)    
    if user==None:  # 존재하지 않는 아이디
        return redirect(url_for('myApp.login'))
    elif user_pw_given != user.pw:  # 비밀번호 오류
        return redirect(url_for('myApp.login'))
    elif user_pw_given == user.pw:  # 로그인 성공
        login_user(user)
        return f"{user.id}님 로그인 성공"
    else:   # DB 오류
        return redirect(url_for('myApp.login'))

@myApp.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('myApp.login'))

@myApp.route('/register')
def register():
    return render_template('signUp.html')


@myApp.route('/registerAction', methods=['POST'])
def registerAction():
    user_id = request.form['user_id']
    user_pw = request.form['user_pw']
    user_name = request.form['user_name']
    user_email = request.form['user_email']
    user_tier = request.form['user_tier']
    result = User.create(user_id, user_pw, user_name, user_email, user_tier)
    if result==1:  # 회원가입 성공
        return redirect(url_for('myApp.login')) #  로그인 페이지로
    else:   # DB 오류
        return "<h1> 회원가입 오류 </h1>"

# 회원탈퇴
@myApp.route('/delete')
def delete():
    if current_user.is_authenticated:
        return render_template('delete.html')
        
    else:
        return redirect(url_for('myApp.login'))
        


@myApp.route('/deleteAction', methods = ['GET','POST'])
def deleteAction():
    if current_user.is_authenticated:
        result = User.delete(current_user.id)
        logout_user()
        if result==1:  # 회원탈퇴 성공
            return redirect(url_for('myApp.register')) #  회원가입 페이지로
    return "<h1> 오류 </h1>"



@myApp.route('/main')
def main():
    if current_user.is_authenticated:
        return render_template('main.html', user_id=current_user.user_id)
    else:
        return redirect(url_for('myApp.login'))
