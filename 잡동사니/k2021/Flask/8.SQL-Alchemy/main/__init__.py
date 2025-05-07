from flask import Flask
from flask_cors import CORS
from flask_migrate import Migrate, migrate
from flask_sqlalchemy import SQLAlchemy
from flask_wtf import CSRFProtect
import config       # <--- config.py

db = SQLAlchemy()
migrate = Migrate()

def create_app():

    # 앱 생성
    app = Flask(__name__)
    
    # CORS
    CORS(app)

    # config.py의 configuration 설정
    app.config.from_object(config)   

    # ORM
    db.init_app(app)
    migrate.init_app(app, db)    
    from main.models import model
    
    # BluePrint
    from main.routes import auth_route
    app.register_blueprint(auth_route.auth_bp)

    # csrf = CSRFProtect(app)
    # csrf.init_app(app)

    return app