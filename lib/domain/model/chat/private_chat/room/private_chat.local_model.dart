import 'package:hive/hive.dart';

import '../../../../../data/entity/chat/private_chat/room/private_chat.entity.dart';

part 'private_chat.local_model.g.dart';

@HiveType(typeId: 3)
class LocalPrivateChatModel {
  @HiveField(0)
  String id;

  // 현재 로그인 유저
  @HiveField(1)
  String user_id;

  @HiveField(2)
  String nickname;

  @HiveField(3)
  String profile_image;

  // 대화 상대방
  @HiveField(4)
  String opponent_id;

  @HiveField(5)
  String opponent_nickname;

  @HiveField(6)
  String opponent_profile_image;

  @HiveField(7)
  String last_message;

  @HiveField(8)
  int un_read_count;

  @HiveField(9)
  DateTime? created_at;
  @HiveField(10)
  DateTime? updated_at;

  LocalPrivateChatModel(
      {required this.id,
      required this.user_id,
      required this.nickname,
      required this.profile_image,
      required this.opponent_id,
      required this.opponent_nickname,
      required this.opponent_profile_image,
      required this.last_message,
      required this.un_read_count,
      this.created_at,
      this.updated_at});

  factory LocalPrivateChatModel.fromEntity(PrivateChatEntity entity) =>
      LocalPrivateChatModel(
          id: entity.id ?? '',
          user_id: entity.currentUser?.id ?? '',
          nickname: entity.currentUser?.nickname ?? '',
          profile_image: entity.currentUser?.profileImage ?? '',
          opponent_id: entity.opponent?.id ?? '',
          opponent_nickname: entity.opponent?.nickname ?? '',
          opponent_profile_image: entity.opponent?.profileImage ?? '',
          last_message: entity.lateMessage ?? '',
          un_read_count: entity.unReadCount ?? 0,
          created_at: entity.createdAt,
          updated_at: entity.updatedAt);
}
