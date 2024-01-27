// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeedDto _$FeedDtoFromJson(Map<String, dynamic> json) {
  return _FeedDto.fromJson(json);
}

/// @nodoc
mixin _$FeedDto {
  String? get feedId => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  List<String> get hashtags => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedDtoCopyWith<FeedDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedDtoCopyWith<$Res> {
  factory $FeedDtoCopyWith(FeedDto value, $Res Function(FeedDto) then) =
      _$FeedDtoCopyWithImpl<$Res, FeedDto>;
  @useResult
  $Res call(
      {String? feedId,
      String? content,
      List<String> hashtags,
      List<String> images,
      String? uid,
      DateTime? createdAt});
}

/// @nodoc
class _$FeedDtoCopyWithImpl<$Res, $Val extends FeedDto>
    implements $FeedDtoCopyWith<$Res> {
  _$FeedDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feedId = freezed,
    Object? content = freezed,
    Object? hashtags = null,
    Object? images = null,
    Object? uid = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      feedId: freezed == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _value.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
abstract class _$$FeedDtoImplCopyWith<$Res> implements $FeedDtoCopyWith<$Res> {
  factory _$$FeedDtoImplCopyWith(
          _$FeedDtoImpl value, $Res Function(_$FeedDtoImpl) then) =
      __$$FeedDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? feedId,
      String? content,
      List<String> hashtags,
      List<String> images,
      String? uid,
      DateTime? createdAt});
}

/// @nodoc
class __$$FeedDtoImplCopyWithImpl<$Res>
    extends _$FeedDtoCopyWithImpl<$Res, _$FeedDtoImpl>
    implements _$$FeedDtoImplCopyWith<$Res> {
  __$$FeedDtoImplCopyWithImpl(
      _$FeedDtoImpl _value, $Res Function(_$FeedDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feedId = freezed,
    Object? content = freezed,
    Object? hashtags = null,
    Object? images = null,
    Object? uid = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$FeedDtoImpl(
      feedId: freezed == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _value._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
class _$FeedDtoImpl with DiagnosticableTreeMixin implements _FeedDto {
  const _$FeedDtoImpl(
      {this.feedId = '',
      this.content = '',
      final List<String> hashtags = const <String>[],
      final List<String> images = const <String>[],
      this.uid = '',
      this.createdAt})
      : _hashtags = hashtags,
        _images = images;

  factory _$FeedDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedDtoImplFromJson(json);

  @override
  @JsonKey()
  final String? feedId;
  @override
  @JsonKey()
  final String? content;
  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey()
  final String? uid;
  @override
  final DateTime? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FeedDto(feedId: $feedId, content: $content, hashtags: $hashtags, images: $images, uid: $uid, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FeedDto'))
      ..add(DiagnosticsProperty('feedId', feedId))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('hashtags', hashtags))
      ..add(DiagnosticsProperty('images', images))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedDtoImpl &&
            (identical(other.feedId, feedId) || other.feedId == feedId) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      feedId,
      content,
      const DeepCollectionEquality().hash(_hashtags),
      const DeepCollectionEquality().hash(_images),
      uid,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedDtoImplCopyWith<_$FeedDtoImpl> get copyWith =>
      __$$FeedDtoImplCopyWithImpl<_$FeedDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedDtoImplToJson(
      this,
    );
  }
}

abstract class _FeedDto implements FeedDto {
  const factory _FeedDto(
      {final String? feedId,
      final String? content,
      final List<String> hashtags,
      final List<String> images,
      final String? uid,
      final DateTime? createdAt}) = _$FeedDtoImpl;

  factory _FeedDto.fromJson(Map<String, dynamic> json) = _$FeedDtoImpl.fromJson;

  @override
  String? get feedId;
  @override
  String? get content;
  @override
  List<String> get hashtags;
  @override
  List<String> get images;
  @override
  String? get uid;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FeedDtoImplCopyWith<_$FeedDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
