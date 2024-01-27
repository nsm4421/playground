from flask import Flask, render_template, url_for, flash, redirect, request
from flask_sqlalchemy import SQLAlchemy
from forms import SignUpForm
app = Flask(__name__)
app.config['SECRET_KEY'] = '1221'


@app.route("/signUp")
def signUp():
    form = SignUpForm()
    return render_template('signUp.html', title='회원가입', form=form)


@app.route("/signUpAction", methods=['GET', 'POST'])
def signUpAction():

    return request.form

if __name__ == '__main__':
    app.debug = True
    app.run(host='localhost', port = 8080)
