// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'write_feed.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WriteFeedState {
  Status get status => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<Asset> get images => throw _privateConstructorUsedError;
  List<String> get hashtags => throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WriteFeedStateCopyWith<WriteFeedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WriteFeedStateCopyWith<$Res> {
  factory $WriteFeedStateCopyWith(
          WriteFeedState value, $Res Function(WriteFeedState) then) =
      _$WriteFeedStateCopyWithImpl<$Res, WriteFeedState>;
  @useResult
  $Res call(
      {Status status,
      String content,
      List<Asset> images,
      List<String> hashtags,
      ErrorResponse error});
}

/// @nodoc
class _$WriteFeedStateCopyWithImpl<$Res, $Val extends WriteFeedState>
    implements $WriteFeedStateCopyWith<$Res> {
  _$WriteFeedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? content = null,
    Object? images = null,
    Object? hashtags = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
      hashtags: null == hashtags
          ? _value.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WriteFeedStateImplCopyWith<$Res>
    implements $WriteFeedStateCopyWith<$Res> {
  factory _$$WriteFeedStateImplCopyWith(_$WriteFeedStateImpl value,
          $Res Function(_$WriteFeedStateImpl) then) =
      __$$WriteFeedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Status status,
      String content,
      List<Asset> images,
      List<String> hashtags,
      ErrorResponse error});
}

/// @nodoc
class __$$WriteFeedStateImplCopyWithImpl<$Res>
    extends _$WriteFeedStateCopyWithImpl<$Res, _$WriteFeedStateImpl>
    implements _$$WriteFeedStateImplCopyWith<$Res> {
  __$$WriteFeedStateImplCopyWithImpl(
      _$WriteFeedStateImpl _value, $Res Function(_$WriteFeedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? content = null,
    Object? images = null,
    Object? hashtags = null,
    Object? error = null,
  }) {
    return _then(_$WriteFeedStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
      hashtags: null == hashtags
          ? _value._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ));
  }
}

/// @nodoc

class _$WriteFeedStateImpl
    with DiagnosticableTreeMixin
    implements _WriteFeedState {
  const _$WriteFeedStateImpl(
      {this.status = Status.initial,
      this.content = '',
      final List<Asset> images = const <Asset>[],
      final List<String> hashtags = const <String>[],
      this.error = const ErrorResponse()})
      : _images = images,
        _hashtags = hashtags;

  @override
  @JsonKey()
  final Status status;
  @override
  @JsonKey()
  final String content;
  final List<Asset> _images;
  @override
  @JsonKey()
  List<Asset> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  @override
  @JsonKey()
  final ErrorResponse error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WriteFeedState(status: $status, content: $content, images: $images, hashtags: $hashtags, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WriteFeedState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('images', images))
      ..add(DiagnosticsProperty('hashtags', hashtags))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WriteFeedStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      content,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_hashtags),
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WriteFeedStateImplCopyWith<_$WriteFeedStateImpl> get copyWith =>
      __$$WriteFeedStateImplCopyWithImpl<_$WriteFeedStateImpl>(
          this, _$identity);
}

abstract class _WriteFeedState implements WriteFeedState {
  const factory _WriteFeedState(
      {final Status status,
      final String content,
      final List<Asset> images,
      final List<String> hashtags,
      final ErrorResponse error}) = _$WriteFeedStateImpl;

  @override
  Status get status;
  @override
  String get content;
  @override
  List<Asset> get images;
  @override
  List<String> get hashtags;
  @override
  ErrorResponse get error;
  @override
  @JsonKey(ignore: true)
  _$$WriteFeedStateImplCopyWith<_$WriteFeedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
