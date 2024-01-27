// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_module.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ViewModuleDto _$ViewModuleDtoFromJson(Map<String, dynamic> json) {
  return _ViewModuleDto.fromJson(json);
}

/// @nodoc
mixin _$ViewModuleDto {
  ViewModuleType? get type => throw _privateConstructorUsedError;
  UserDto? get user => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ViewModuleDtoCopyWith<ViewModuleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewModuleDtoCopyWith<$Res> {
  factory $ViewModuleDtoCopyWith(
          ViewModuleDto value, $Res Function(ViewModuleDto) then) =
      _$ViewModuleDtoCopyWithImpl<$Res, ViewModuleDto>;
  @useResult
  $Res call(
      {ViewModuleType? type, UserDto? user, String? content, String? imageUrl});

  $UserDtoCopyWith<$Res>? get user;
}

/// @nodoc
class _$ViewModuleDtoCopyWithImpl<$Res, $Val extends ViewModuleDto>
    implements $ViewModuleDtoCopyWith<$Res> {
  _$ViewModuleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? user = freezed,
    Object? content = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ViewModuleType?,
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
abstract class _$$ViewModuleDtoImplCopyWith<$Res>
    implements $ViewModuleDtoCopyWith<$Res> {
  factory _$$ViewModuleDtoImplCopyWith(
          _$ViewModuleDtoImpl value, $Res Function(_$ViewModuleDtoImpl) then) =
      __$$ViewModuleDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ViewModuleType? type, UserDto? user, String? content, String? imageUrl});

  @override
  $UserDtoCopyWith<$Res>? get user;
}

/// @nodoc
class __$$ViewModuleDtoImplCopyWithImpl<$Res>
    extends _$ViewModuleDtoCopyWithImpl<$Res, _$ViewModuleDtoImpl>
    implements _$$ViewModuleDtoImplCopyWith<$Res> {
  __$$ViewModuleDtoImplCopyWithImpl(
      _$ViewModuleDtoImpl _value, $Res Function(_$ViewModuleDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? user = freezed,
    Object? content = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$ViewModuleDtoImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ViewModuleType?,
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
class _$ViewModuleDtoImpl
    with DiagnosticableTreeMixin
    implements _ViewModuleDto {
  const _$ViewModuleDtoImpl(
      {this.type = ViewModuleType.none,
      this.user = const UserDto(),
      this.content = '',
      this.imageUrl = ''});

  factory _$ViewModuleDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ViewModuleDtoImplFromJson(json);

  @override
  @JsonKey()
  final ViewModuleType? type;
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
    return 'ViewModuleDto(type: $type, user: $user, content: $content, imageUrl: $imageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ViewModuleDto'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('imageUrl', imageUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewModuleDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, user, content, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewModuleDtoImplCopyWith<_$ViewModuleDtoImpl> get copyWith =>
      __$$ViewModuleDtoImplCopyWithImpl<_$ViewModuleDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ViewModuleDtoImplToJson(
      this,
    );
  }
}

abstract class _ViewModuleDto implements ViewModuleDto {
  const factory _ViewModuleDto(
      {final ViewModuleType? type,
      final UserDto? user,
      final String? content,
      final String? imageUrl}) = _$ViewModuleDtoImpl;

  factory _ViewModuleDto.fromJson(Map<String, dynamic> json) =
      _$ViewModuleDtoImpl.fromJson;

  @override
  ViewModuleType? get type;
  @override
  UserDto? get user;
  @override
  String? get content;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$ViewModuleDtoImplCopyWith<_$ViewModuleDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
