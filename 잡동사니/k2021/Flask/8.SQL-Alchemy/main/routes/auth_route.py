from flask import Blueprint, url_for, render_template, flash, request
from werkzeug.security import generate_password_hash
from flask import redirect
import datetime
from main import db
from main.models.model import User
from main.models.form import RegisterForm

# 인증 blueprint
auth_bp = Blueprint('main', __name__, url_prefix='/auth')

@auth_bp.route('/')
def index():
    return "Index"

@auth_bp.route('/signUp', methods = ['GET', 'POST'])
def signUp():
    form = RegisterForm()
    # POST요청 (회원가입버튼 클릭) and 유효한 정보 제출
    if request.method == 'POST' and form.validate_on_submit():
        # 이미 존재하는 user_id인지 확인
        user = User.query.filter_by(user_id=form.user_id.data).first()
        # 존재하지 않는 user_id라면
        if not user:
            # user 객체 생성
            user = User(user_id = form.user_id.data, \
                password = generate_password_hash(form.password.data), \
                    email = form.email.data, \
                        tier = form.tier.data, \
                            lol_id = form.lol_id.data, \
                                nick_name = form.nick_name.data, \
                                    manner = 3, \
                                        register_date = datetime.datetime.now())
            # DB에 저장
            db.session.add(user)
            db.session.commit()
            # 로그인 화면으로 이동
            flash(f'{form.user_id.data}님 회원가입 성공')
            return redirect(url_for('main.login'))
        # 이미 존재하는 user_id인 경우
        else:
            # 메세지 출력
            flash(f'{form.user_id.data}는 이미 존재하는 아이디다.')
            return render_template('auth/signUp.html', form = form)
    # 그 외 오류
    else:
        return render_template('auth/signUp.html', form = form)

@auth_bp.route('/login', methods = ['GET', 'POST'])
def login():
    return render_template('auth/login.html')

    
