from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, PasswordField
from wtforms.fields.html5 import EmailField
from wtforms.validators import DataRequired, Length, EqualTo, Email

class RegisterForm(FlaskForm):
    user_id = StringField('사용자이름',\
        validators=[DataRequired(), \
            Length(min=3, max=20)])
    password = PasswordField('비밀번호', \
        validators=[DataRequired(),\
            Length(min=3, max=20)])
    password_re = PasswordField('비밀번호확인', \
        validators=[DataRequired(), \
            EqualTo('password', '비밀번호가 일치하지 않습니다')])
    email = EmailField('이메일', validators=[DataRequired(), Email()])

    nick_name = StringField('닉네임',\
        validators=[DataRequired(), \
            Length(max=20)])
    
    lol_id = StringField('롤 id',\
        validators=[DataRequired(), \
            Length(max=30)])
    tier = StringField('롤 티어',\
        validators=[DataRequired(), \
            Length(max=10)])


