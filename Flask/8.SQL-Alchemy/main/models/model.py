from main import db

class User(db.Model):
    user_id = db.Column(db.String(20), primary_key = True)
    password = db.Column(db.String(20), nullable = False)
    nick_name = db.Column(db.String(20), unique = True, nullable = False)
    email = db.Column(db.String(30), unique = True, nullable = False)

    lol_id = db.Column(db.String(30), nullable = False)
    tier = db.Column(db.String(10), nullable = False)
    manner = db.Column(db.Integer, nullable = False)
    register_date = db.Column(db.DateTime(), nullable=False)

class Duo(db.Model):
    host = db.Column(db.String(20), primary_key = True)
    guest = db.Column(db.String(20), nullable = True)    
    search_time = db.Column(db.DateTime(), nullable=False)


