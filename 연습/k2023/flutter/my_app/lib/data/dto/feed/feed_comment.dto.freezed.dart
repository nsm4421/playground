// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_comment.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeedCommentDto _$FeedCommentDtoFromJson(Map<String, dynamic> json) {
  return _FeedCommentDto.fromJson(json);
}

/// @nodoc
mixin _$FeedCommentDto {
  String get commentId => throw _privateConstructorUsedError;
  String get feedId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedCommentDtoCopyWith<FeedCommentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedCommentDtoCopyWith<$Res> {
  factory $FeedCommentDtoCopyWith(
          FeedCommentDto value, $Res Function(FeedCommentDto) then) =
      _$FeedCommentDtoCopyWithImpl<$Res, FeedCommentDto>;
  @useResult
  $Res call(
      {String commentId,
      String feedId,
      String content,
      String uid,
      DateTime? createdAt});
}

/// @nodoc
class _$FeedCommentDtoCopyWithImpl<$Res, $Val extends FeedCommentDto>
    implements $FeedCommentDtoCopyWith<$Res> {
  _$FeedCommentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? feedId = null,
    Object? content = null,
    Object? uid = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      commentId: null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      feedId: null == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedCommentDtoImplCopyWith<$Res>
    implements $FeedCommentDtoCopyWith<$Res> {
  factory _$$FeedCommentDtoImplCopyWith(_$FeedCommentDtoImpl value,
          $Res Function(_$FeedCommentDtoImpl) then) =
      __$$FeedCommentDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String commentId,
      String feedId,
      String content,
      String uid,
      DateTime? createdAt});
}

/// @nodoc
class __$$FeedCommentDtoImplCopyWithImpl<$Res>
    extends _$FeedCommentDtoCopyWithImpl<$Res, _$FeedCommentDtoImpl>
    implements _$$FeedCommentDtoImplCopyWith<$Res> {
  __$$FeedCommentDtoImplCopyWithImpl(
      _$FeedCommentDtoImpl _value, $Res Function(_$FeedCommentDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? feedId = null,
    Object? content = null,
    Object? uid = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$FeedCommentDtoImpl(
      commentId: null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      feedId: null == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedCommentDtoImpl
    with DiagnosticableTreeMixin
    implements _FeedCommentDto {
  const _$FeedCommentDtoImpl(
      {this.commentId = '',
      this.feedId = '',
      this.content = '',
      this.uid = '',
      this.createdAt});

  factory _$FeedCommentDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedCommentDtoImplFromJson(json);

  @override
  @JsonKey()
  final String commentId;
  @override
  @JsonKey()
  final String feedId;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey()
  final String uid;
  @override
  final DateTime? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FeedCommentDto(commentId: $commentId, feedId: $feedId, content: $content, uid: $uid, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FeedCommentDto'))
      ..add(DiagnosticsProperty('commentId', commentId))
      ..add(DiagnosticsProperty('feedId', feedId))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedCommentDtoImpl &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.feedId, feedId) || other.feedId == feedId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, commentId, feedId, content, uid, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedCommentDtoImplCopyWith<_$FeedCommentDtoImpl> get copyWith =>
      __$$FeedCommentDtoImplCopyWithImpl<_$FeedCommentDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedCommentDtoImplToJson(
      this,
    );
  }
}

abstract class _FeedCommentDto implements FeedCommentDto {
  const factory _FeedCommentDto(
      {final String commentId,
      final String feedId,
      final String content,
      final String uid,
      final DateTime? createdAt}) = _$FeedCommentDtoImpl;

  factory _FeedCommentDto.fromJson(Map<String, dynamic> json) =
      _$FeedCommentDtoImpl.fromJson;

  @override
  String get commentId;
  @override
  String get feedId;
  @override
  String get content;
  @override
  String get uid;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FeedCommentDtoImplCopyWith<_$FeedCommentDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
