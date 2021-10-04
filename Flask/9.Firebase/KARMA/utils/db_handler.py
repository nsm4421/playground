import pyrebase
import json

class DB_hanlder:
    def __init__(self, config_path = './KARMA/static/firebaseConfig.json'):
        with open(config_path) as f:
            config = json.load(f)
        # initialize firebase
        firebase = pyrebase.initialize_app(config)
        # database
        self.db = firebase.database()

    def signUp(self, user_id, password, email, nickname):
        user_dict = {
            'password' : password,
            'email' : email,
            'nickname' : nickname
        }
        self.db.child('USER').child(user_id).push(user_dict)
