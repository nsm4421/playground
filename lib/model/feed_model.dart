import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/feed_model.g.dart';

part 'generated/feed_model.freezed.dart';

/**
 * 채팅방
 ** feedId : 피드 id
 ** uid : 작성자 uid
 ** content : 본문
 ** hashtags : 해시태그를 #로 연결한 문자열
 ** image : 이미지 다운로드 링크
 ** createdAt : 생성시간
 ** modifiedAt : 수정시간
 ** removedAt : 삭제시간
 */
@freezed
sealed class FeedModel with _$FeedModel {
  factory FeedModel({
    String? feedId,
    String? uid,
    String? content,
    @Default([])List<String> hashtags,
    String? image,
    DateTime? createdAt,
    DateTime? modifiedAt,
    DateTime? removedAt,
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);
}
