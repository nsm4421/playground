// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignUpState {
  SignUpStatus get status => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  List<Asset> get images => throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignUpStateCopyWith<SignUpState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpStateCopyWith<$Res> {
  factory $SignUpStateCopyWith(
          SignUpState value, $Res Function(SignUpState) then) =
      _$SignUpStateCopyWithImpl<$Res, SignUpState>;
  @useResult
  $Res call(
      {SignUpStatus status,
      String uid,
      UserModel user,
      List<Asset> images,
      ErrorResponse error});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$SignUpStateCopyWithImpl<$Res, $Val extends SignUpState>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? uid = null,
    Object? user = null,
    Object? images = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignUpStatus,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignUpStateImplCopyWith<$Res>
    implements $SignUpStateCopyWith<$Res> {
  factory _$$SignUpStateImplCopyWith(
          _$SignUpStateImpl value, $Res Function(_$SignUpStateImpl) then) =
      __$$SignUpStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SignUpStatus status,
      String uid,
      UserModel user,
      List<Asset> images,
      ErrorResponse error});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$SignUpStateImplCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpStateImpl>
    implements _$$SignUpStateImplCopyWith<$Res> {
  __$$SignUpStateImplCopyWithImpl(
      _$SignUpStateImpl _value, $Res Function(_$SignUpStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? uid = null,
    Object? user = null,
    Object? images = null,
    Object? error = null,
  }) {
    return _then(_$SignUpStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignUpStatus,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ));
  }
}

/// @nodoc

class _$SignUpStateImpl with DiagnosticableTreeMixin implements _SignUpState {
  const _$SignUpStateImpl(
      {this.status = SignUpStatus.initial,
      this.uid = '',
      this.user = const UserModel(),
      final List<Asset> images = const <Asset>[],
      this.error = const ErrorResponse()})
      : _images = images;

  @override
  @JsonKey()
  final SignUpStatus status;
  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final UserModel user;
  final List<Asset> _images;
  @override
  @JsonKey()
  List<Asset> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey()
  final ErrorResponse error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SignUpState(status: $status, uid: $uid, user: $user, images: $images, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SignUpState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('images', images))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, uid, user,
      const DeepCollectionEquality().hash(_images), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpStateImplCopyWith<_$SignUpStateImpl> get copyWith =>
      __$$SignUpStateImplCopyWithImpl<_$SignUpStateImpl>(this, _$identity);
}

abstract class _SignUpState implements SignUpState {
  const factory _SignUpState(
      {final SignUpStatus status,
      final String uid,
      final UserModel user,
      final List<Asset> images,
      final ErrorResponse error}) = _$SignUpStateImpl;

  @override
  SignUpStatus get status;
  @override
  String get uid;
  @override
  UserModel get user;
  @override
  List<Asset> get images;
  @override
  ErrorResponse get error;
  @override
  @JsonKey(ignore: true)
  _$$SignUpStateImplCopyWith<_$SignUpStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
