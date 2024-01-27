from flask import Flask, jsonify, request, render_template, make_response
from flask_login import LoginManager, current_user, login_required, login_user, logout_user
from flask_cors import CORS
import os

from Control.manage_user import User
from Route import route

app = Flask(__name__)
app.config['SECRET_KEY'] = '1221'
CORS(app)

# Https에서 지원하는 기능을 Http에서도 사용 가능
os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'

# BluePrint
app.register_blueprint(route.myApp, url_prefix='/myApp')

# Login Manager
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.session_protection = 'strong'     # 보안수준

@login_manager.user_loader
def load_user(user_id):
    return User.get(user_id)

@login_manager.unauthorized_handler
def unauthorized():
    return make_response(jsonify(success=False), 401)


if __name__ == '__main__':
    app.debug = True    # debug 모드
    app.run(host='0.0.0.0', port='8080')
