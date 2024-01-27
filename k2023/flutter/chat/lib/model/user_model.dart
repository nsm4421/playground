import 'package:flutter/foundation.dart';

class User {
  // getter
  String get id => _id;

  // field
  String _id;
  String username;
  String photoUrl;
  bool active;
  DateTime lastSeen;

  // constructor
  User({
    @required this.username,
    @required this.photoUrl,
    @required this.active,
    @required this.lastSeen,
  });

  // class → json
  toJson()=>{
    'username':username,
    'photo_url':photoUrl,
    'active':active,
    'last_seen':lastSeen,
  };

  // json → class
  factory User.fromJson(Map<String, dynamic> json){
    final user = User(
        username: json['username'],
        photoUrl: json['photo_url'],
        active: json['active'],
        lastSeen: json['last_seen']
    );
    user._id = json['id'];
    return user;
  }
}
