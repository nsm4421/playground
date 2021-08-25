from flask import Flask, Blueprint, request, render_template, make_response, jsonify, redirect, url_for
from flask_login import login_user, current_user, logout_user
import datetime


from Control.manage_user import User

myApp = Blueprint('myApp', __name__)


@myApp.route('/login')
def login():
    return render_template('login.html')

@myApp.route('/loginAction', methods=['GET', 'POST'])
def loginAction():
    user_id_given = request.form['user_id']
    user_pw_given = request.form['user_pw']
    print(user_id_given, user_pw_given)
    user = User.get(user_id_given)    
    if user==None:  # 존재하지 않는 아이디
        return redirect(url_for('myApp.login'))
    elif user_pw_given != user.pw:  # 비밀번호 오류
        return redirect(url_for('myApp.login'))
    elif user_pw_given == user.pw:  # 로그인 성공
        return f"{user.id}님 로그인 성공"
    else:   # DB 오류
        return redirect(url_for('myApp.login'))

        
    

    # return redirect('/blog/test_blog')
    # return make_response(jsonify(success=True), 200)




@myApp.route('/main')
def main():
    if current_user.is_authenticated:
        return render_template('main.html', user_id=current_user.user_id)
    else:
        return render_template('login.html')
