// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoryDto _$StoryDtoFromJson(Map<String, dynamic> json) {
  return _StoryDto.fromJson(json);
}

/// @nodoc
mixin _$StoryDto {
  UserDto? get user => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryDtoCopyWith<StoryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryDtoCopyWith<$Res> {
  factory $StoryDtoCopyWith(StoryDto value, $Res Function(StoryDto) then) =
      _$StoryDtoCopyWithImpl<$Res, StoryDto>;
  @useResult
  $Res call({UserDto? user, String? content, String? imageUrl});

  $UserDtoCopyWith<$Res>? get user;
}

/// @nodoc
class _$StoryDtoCopyWithImpl<$Res, $Val extends StoryDto>
    implements $StoryDtoCopyWith<$Res> {
  _$StoryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? content = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoryDtoImplCopyWith<$Res>
    implements $StoryDtoCopyWith<$Res> {
  factory _$$StoryDtoImplCopyWith(
          _$StoryDtoImpl value, $Res Function(_$StoryDtoImpl) then) =
      __$$StoryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserDto? user, String? content, String? imageUrl});

  @override
  $UserDtoCopyWith<$Res>? get user;
}

/// @nodoc
class __$$StoryDtoImplCopyWithImpl<$Res>
    extends _$StoryDtoCopyWithImpl<$Res, _$StoryDtoImpl>
    implements _$$StoryDtoImplCopyWith<$Res> {
  __$$StoryDtoImplCopyWithImpl(
      _$StoryDtoImpl _value, $Res Function(_$StoryDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? content = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$StoryDtoImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryDtoImpl with DiagnosticableTreeMixin implements _StoryDto {
  const _$StoryDtoImpl(
      {this.user = const UserDto(), this.content = '', this.imageUrl = ''});

  factory _$StoryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryDtoImplFromJson(json);

  @override
  @JsonKey()
  final UserDto? user;
  @override
  @JsonKey()
  final String? content;
  @override
  @JsonKey()
  final String? imageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StoryDto(user: $user, content: $content, imageUrl: $imageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StoryDto'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('imageUrl', imageUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryDtoImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, content, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryDtoImplCopyWith<_$StoryDtoImpl> get copyWith =>
      __$$StoryDtoImplCopyWithImpl<_$StoryDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryDtoImplToJson(
      this,
    );
  }
}

abstract class _StoryDto implements StoryDto {
  const factory _StoryDto(
      {final UserDto? user,
      final String? content,
      final String? imageUrl}) = _$StoryDtoImpl;

  factory _StoryDto.fromJson(Map<String, dynamic> json) =
      _$StoryDtoImpl.fromJson;

  @override
  UserDto? get user;
  @override
  String? get content;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$StoryDtoImplCopyWith<_$StoryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
