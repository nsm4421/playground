import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/data/model/chat/fetch.dart';

class PrivateChatEntity extends BaseEntity {
  final String opponentId;
  final String latestMessage;
  final DateTime? deletedAt;

  PrivateChatEntity({
    super.id,
    super.createdAt,
    super.updatedAt,
    required this.opponentId,
    required this.latestMessage,
    required this.deletedAt,
  });

  @override
  Tables get table => Tables.privateChats;

  PrivateChatEntity copyWith({
    String? opponentId,
    String? latestMessage,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return PrivateChatEntity(
        opponentId: opponentId ?? this.opponentId,
        latestMessage: latestMessage ?? this.latestMessage,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt);
  }

  factory PrivateChatEntity.from(FetchPrivateChatDto dto) {
    return PrivateChatEntity(
      id: dto.id,
      opponentId: dto.opponent_id,
      latestMessage: dto.last_message,
      createdAt: DateTime.tryParse(dto.created_at),
      updatedAt: DateTime.tryParse(dto.updated_at),
      deletedAt:
          dto.deleted_at == null ? null : DateTime.tryParse(dto.deleted_at!),
    );
  }
}
