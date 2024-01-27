// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_comment.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeedCommentModel _$FeedCommentModelFromJson(Map<String, dynamic> json) {
  return _FeedCommentModel.fromJson(json);
}

/// @nodoc
mixin _$FeedCommentModel {
  String? get commentId => throw _privateConstructorUsedError;
  String? get feedId => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedCommentModelCopyWith<FeedCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedCommentModelCopyWith<$Res> {
  factory $FeedCommentModelCopyWith(
          FeedCommentModel value, $Res Function(FeedCommentModel) then) =
      _$FeedCommentModelCopyWithImpl<$Res, FeedCommentModel>;
  @useResult
  $Res call(
      {String? commentId,
      String? feedId,
      String? content,
      String? uid,
      DateTime? createdAt});
}

/// @nodoc
class _$FeedCommentModelCopyWithImpl<$Res, $Val extends FeedCommentModel>
    implements $FeedCommentModelCopyWith<$Res> {
  _$FeedCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = freezed,
    Object? feedId = freezed,
    Object? content = freezed,
    Object? uid = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      commentId: freezed == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String?,
      feedId: freezed == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedCommentModelImplCopyWith<$Res>
    implements $FeedCommentModelCopyWith<$Res> {
  factory _$$FeedCommentModelImplCopyWith(_$FeedCommentModelImpl value,
          $Res Function(_$FeedCommentModelImpl) then) =
      __$$FeedCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? commentId,
      String? feedId,
      String? content,
      String? uid,
      DateTime? createdAt});
}

/// @nodoc
class __$$FeedCommentModelImplCopyWithImpl<$Res>
    extends _$FeedCommentModelCopyWithImpl<$Res, _$FeedCommentModelImpl>
    implements _$$FeedCommentModelImplCopyWith<$Res> {
  __$$FeedCommentModelImplCopyWithImpl(_$FeedCommentModelImpl _value,
      $Res Function(_$FeedCommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = freezed,
    Object? feedId = freezed,
    Object? content = freezed,
    Object? uid = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$FeedCommentModelImpl(
      commentId: freezed == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String?,
      feedId: freezed == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedCommentModelImpl
    with DiagnosticableTreeMixin
    implements _FeedCommentModel {
  const _$FeedCommentModelImpl(
      {this.commentId, this.feedId, this.content, this.uid, this.createdAt});

  factory _$FeedCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedCommentModelImplFromJson(json);

  @override
  final String? commentId;
  @override
  final String? feedId;
  @override
  final String? content;
  @override
  final String? uid;
  @override
  final DateTime? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FeedCommentModel(commentId: $commentId, feedId: $feedId, content: $content, uid: $uid, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FeedCommentModel'))
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
            other is _$FeedCommentModelImpl &&
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
  _$$FeedCommentModelImplCopyWith<_$FeedCommentModelImpl> get copyWith =>
      __$$FeedCommentModelImplCopyWithImpl<_$FeedCommentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedCommentModelImplToJson(
      this,
    );
  }
}

abstract class _FeedCommentModel implements FeedCommentModel {
  const factory _FeedCommentModel(
      {final String? commentId,
      final String? feedId,
      final String? content,
      final String? uid,
      final DateTime? createdAt}) = _$FeedCommentModelImpl;

  factory _FeedCommentModel.fromJson(Map<String, dynamic> json) =
      _$FeedCommentModelImpl.fromJson;

  @override
  String? get commentId;
  @override
  String? get feedId;
  @override
  String? get content;
  @override
  String? get uid;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FeedCommentModelImplCopyWith<_$FeedCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
