enum NotificationType {
  none('none'),
  like('게시글에 좋아요를 누른 경우'),
  comment('게시글에 댓글을 단 경우'),
  privateChat('DM을 보낸 경우'),
  ;

  final String description;

  const NotificationType(this.description);
}
