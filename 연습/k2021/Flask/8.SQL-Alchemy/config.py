import os
SECRET_KEY= '1221'
BASE_DIR= os.path.dirname(__file__)
APP_NAME= "example"
SQLALCHEMY_DATABASE_URI = 'sqlite:///{}'.format(os.path.join(BASE_DIR, f'{APP_NAME}.db'))
SQLALCHEMY_TRACK_MODIFICATIONS= False
SECRET_KEY= "1221"