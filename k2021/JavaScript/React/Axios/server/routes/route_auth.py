from pymysql import cursors
from server import app
import os
import json
from flask import request, jsonify, Blueprint
import pymysql
from werkzeug.security import generate_password_hash
from server.model.manage_user import ManageUser


bp_auth = Blueprint('server', __name__, url_prefix='/auth')
mu = ManageUser()

@bp_auth.route('/register', methods = ['POST'])
def register():
    # Get data
    user_id = request.form['user_id']
    password = request.form['password']
    email = request.form['email']
    nickname = request.form['nickname']
    return jsonify(mu.register(user_id,password, email, nickname))
    
@bp_auth.route('/changePassword', methods = ['POST'])
def changePassword():
    user_id = request.form['user_id']
    new_password = request.form['new_password']
    return jsonify(mu.changePassword(user_id, new_password))
        
@bp_auth.route('/withdrawal', methods = ['POST'])
def withdrawal():
    user_id = request.form['user_id']
    return jsonify(mu.withdrawal(user_id))

