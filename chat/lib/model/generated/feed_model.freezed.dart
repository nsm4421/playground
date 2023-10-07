// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../feed_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeedModel _$FeedModelFromJson(Map<String, dynamic> json) {
  return _FeedModel.fromJson(json);
}

/// @nodoc
mixin _$FeedModel {
  String? get feedId => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  List<String> get hashtags => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get modifiedAt => throw _privateConstructorUsedError;
  DateTime? get removedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedModelCopyWith<FeedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedModelCopyWith<$Res> {
  factory $FeedModelCopyWith(FeedModel value, $Res Function(FeedModel) then) =
      _$FeedModelCopyWithImpl<$Res, FeedModel>;
  @useResult
  $Res call(
      {String? feedId,
      String? uid,
      String? content,
      List<String> hashtags,
      String? image,
      DateTime? createdAt,
      DateTime? modifiedAt,
      DateTime? removedAt});
}

/// @nodoc
class _$FeedModelCopyWithImpl<$Res, $Val extends FeedModel>
    implements $FeedModelCopyWith<$Res> {
  _$FeedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feedId = freezed,
    Object? uid = freezed,
    Object? content = freezed,
    Object? hashtags = null,
    Object? image = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? removedAt = freezed,
  }) {
    return _then(_value.copyWith(
      feedId: freezed == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _value.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      removedAt: freezed == removedAt
          ? _value.removedAt
          : removedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FeedModelCopyWith<$Res> implements $FeedModelCopyWith<$Res> {
  factory _$$_FeedModelCopyWith(
          _$_FeedModel value, $Res Function(_$_FeedModel) then) =
      __$$_FeedModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? feedId,
      String? uid,
      String? content,
      List<String> hashtags,
      String? image,
      DateTime? createdAt,
      DateTime? modifiedAt,
      DateTime? removedAt});
}

/// @nodoc
class __$$_FeedModelCopyWithImpl<$Res>
    extends _$FeedModelCopyWithImpl<$Res, _$_FeedModel>
    implements _$$_FeedModelCopyWith<$Res> {
  __$$_FeedModelCopyWithImpl(
      _$_FeedModel _value, $Res Function(_$_FeedModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feedId = freezed,
    Object? uid = freezed,
    Object? content = freezed,
    Object? hashtags = null,
    Object? image = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? removedAt = freezed,
  }) {
    return _then(_$_FeedModel(
      feedId: freezed == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _value._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      removedAt: freezed == removedAt
          ? _value.removedAt
          : removedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FeedModel implements _FeedModel {
  _$_FeedModel(
      {this.feedId,
      this.uid,
      this.content,
      final List<String> hashtags = const [],
      this.image,
      this.createdAt,
      this.modifiedAt,
      this.removedAt})
      : _hashtags = hashtags;

  factory _$_FeedModel.fromJson(Map<String, dynamic> json) =>
      _$$_FeedModelFromJson(json);

  @override
  final String? feedId;
  @override
  final String? uid;
  @override
  final String? content;
  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  @override
  final String? image;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? modifiedAt;
  @override
  final DateTime? removedAt;

  @override
  String toString() {
    return 'FeedModel(feedId: $feedId, uid: $uid, content: $content, hashtags: $hashtags, image: $image, createdAt: $createdAt, modifiedAt: $modifiedAt, removedAt: $removedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FeedModel &&
            (identical(other.feedId, feedId) || other.feedId == feedId) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.removedAt, removedAt) ||
                other.removedAt == removedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      feedId,
      uid,
      content,
      const DeepCollectionEquality().hash(_hashtags),
      image,
      createdAt,
      modifiedAt,
      removedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FeedModelCopyWith<_$_FeedModel> get copyWith =>
      __$$_FeedModelCopyWithImpl<_$_FeedModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeedModelToJson(
      this,
    );
  }
}

abstract class _FeedModel implements FeedModel {
  factory _FeedModel(
      {final String? feedId,
      final String? uid,
      final String? content,
      final List<String> hashtags,
      final String? image,
      final DateTime? createdAt,
      final DateTime? modifiedAt,
      final DateTime? removedAt}) = _$_FeedModel;

  factory _FeedModel.fromJson(Map<String, dynamic> json) =
      _$_FeedModel.fromJson;

  @override
  String? get feedId;
  @override
  String? get uid;
  @override
  String? get content;
  @override
  List<String> get hashtags;
  @override
  String? get image;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get modifiedAt;
  @override
  DateTime? get removedAt;
  @override
  @JsonKey(ignore: true)
  _$$_FeedModelCopyWith<_$_FeedModel> get copyWith =>
      throw _privateConstructorUsedError;
}
