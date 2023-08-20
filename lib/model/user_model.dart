class UserModel {
  final String username;
  final String uid;
  final String profileImageUrl;
  final bool active;
  final String phoneNumber;
  final List<String> groupId;

  UserModel({
    required this.username,
    required this.uid,
    required this.profileImageUrl,
    required this.active,
    required this.phoneNumber,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uid': uid,
      'profileImageUrl': profileImageUrl,
      'active': active,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      uid: json['uid'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      active: json['active'] ?? false,
      phoneNumber: json['phoneNumber'] ?? '',
      groupId: List<String>.from(json['groupId']) ?? [],
    );
  }
}
