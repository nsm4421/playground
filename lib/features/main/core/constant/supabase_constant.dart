enum TableName {
  account("accounts"),
  openChatRoom("open_chat_rooms");

  final String name;

  const TableName(this.name);
}

enum BucketName {
  profileImage("profile-image");

  final String name;

  const BucketName(this.name);
}
