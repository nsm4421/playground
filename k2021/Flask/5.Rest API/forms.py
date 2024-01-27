from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, BooleanField
from wtforms.validators import DataRequired, Length, Email, EqualTo


class SignUpForm(FlaskForm):
    user_id = StringField('아이디', validators=[DataRequired(), Length(min=3, max=20)])
    user_pw = PasswordField('비밀번호', validators=[DataRequired(), Length(min=10, max=20)])
    re_pw = PasswordField('비밀번호 다시 입력')
    submit = SubmitField('회원가입')
