import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.model.freezed.dart';

part 'message.model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    @Default('') String? messageId,
    @Default('') String? chatRoomId,
    @Default('') String? senderUid,
    @Default('') String? content,
    DateTime? createdAt,
    DateTime? removedAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
