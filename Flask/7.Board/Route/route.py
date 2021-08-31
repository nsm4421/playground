from flask import Flask, Blueprint, request, render_template, make_response, jsonify, redirect, url_for, flash
from flask_login import login_user, current_user, logout_user
import datetime
from Model.conn_db import conn_mysqldb, conn_mongodb
from Control.manage_user import User


myApp = Blueprint('myApp', __name__)

@myApp.route('/')
@myApp.route('/index')
def index():
    return render_template('index.html')
#=================== 로그인 ===================#
@myApp.route('/login')
def login():
    if current_user.is_authenticated:
        flash("이미 로그인 됐는데?")
        return redirect(url_for('myApp.main'))
    return render_template('login.html')
@myApp.route('/loginAction', methods=['POST'])
def loginAction():
    user_id_given = request.form['user_id']
    user_pw_given = request.form['user_pw']
    user = User.get(user_id_given)    
    if user==None:  # 존재하지 않는 아이디
        flash("존재하지 않는 아이디임")
        return redirect(url_for('myApp.login'))
    elif user_pw_given != user.pw:  # 비밀번호 오류
        flash("비밀번호 틀림")
        return redirect(url_for('myApp.login'))
    elif user_pw_given == user.pw:  # 로그인 성공
        login_user(user)
        flash("로그인 성공")
        return redirect(url_for('myApp.main'))
    else:   # DB 오류
        flash("DB 오류")
        return redirect(url_for('myApp.index'))
#=================== 로그아웃 ===================#
@myApp.route('/logout')
def logout():       
    if current_user.is_authenticated:
        logout_user()
        return redirect(url_for('myApp.index'))
    flash("아직 로그인도 안했는데 뭔 로그아웃?")
    return redirect(url_for('myApp.login')) 
#=================== 회원가입 ===================#
@myApp.route('/register')
def register():
    if current_user.is_authenticated:
        flash("이미 로그인 되어 있습니다.")
        return redirect(url_for('myApp.index'))
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
        flash("회원가입 실패~")
        return redirect(url_for('myApp.register'))
#=================== 회원탈퇴 ===================#
@myApp.route('/delete')
def delete():
    if current_user.is_authenticated:
        return render_template('delete.html')
    else:
        return redirect(url_for('myApp.index'))

@myApp.route('/deleteAction', methods = ['GET','POST'])
def deleteAction():
    if current_user.is_authenticated:
        result = User.delete(current_user.id)
        logout_user()
        if result==1:  # 회원탈퇴 성공
            return redirect(url_for('myApp.register')) #  회원가입 페이지로
        return redirect(url_for('myApp.index'))
    return redirect(url_for('myApp.index'))
#=================== 메인페이지 ===================#
@myApp.route('/main')
def main():
    conn = conn_mysqldb()
    cursor = conn.cursor()
    query = f"SELECT * FROM ARTICLE;"
    cursor.execute(query)
    articles = cursor.fetchall()
    return render_template('main.html', articles = articles)
#=================== 게시물 보기 ===================#
@myApp.route('/main/<article_id>')
def show_article(article_id):
    conn = conn_mysqldb()
    cursor = conn.cursor()
    query = f"SELECT * FROM ARTICLE WHERE ARTICLE_ID= '{article_id}';"
    cnt = cursor.execute(query)
    if cnt==1:
        article = cursor.fetchone()
        return render_template('article.html', article = article)
    else:
        return redirect(url_for('myApp.main'))

#=================== 게시물 쓰기 ===================#
@myApp.route('/main/write_article')
def write_article():
    if current_user.is_authenticated:
        return render_template('write_article.html')
    else:
        flash("로그인부터 하세요")
        return redirect(url_for('myApp.login'))
        

@myApp.route('/main/writeAction', methods=['POST'])
def writeAction():
    writer_id = current_user.id
    title = request.form['title']
    text = request.form['text']
    conn = conn_mysqldb()
    cursor = conn.cursor()
    query = f"INSERT INTO ARTICLE(WRITER_ID, TITLE, ARTICLE) VALUES ('{writer_id}', '{title}', '{text}');"
    cnt = cursor.execute(query)
    conn.commit()
    if cnt==1:
        flash("업로드 됨")
    else:
        flash("오류")
    return redirect(url_for('myApp.main'))

#=================== 게시물 삭제 ===================#
@myApp.route('/main/<article_id>/delete', methods=['POST'])
def delete_article(article_id):
    conn = conn_mysqldb()
    cursor = conn.cursor()
    query = f"DELETE FROM ARTICLE WHERE ARTICLE_ID = '{article_id}';"
    cnt = cursor.execute(query)
    conn.commit()
    if cnt==1:
        flash("삭제 됨")
    else:
        flash("오류")
    return redirect(url_for('myApp.main'))