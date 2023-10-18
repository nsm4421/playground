// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swipe.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SwipeState _$SwipeStateFromJson(Map<String, dynamic> json) {
  return _SwipeState.fromJson(json);
}

/// @nodoc
mixin _$SwipeState {
  Status get status => throw _privateConstructorUsedError;
  List<UserModel> get users => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwipeStateCopyWith<SwipeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwipeStateCopyWith<$Res> {
  factory $SwipeStateCopyWith(
          SwipeState value, $Res Function(SwipeState) then) =
      _$SwipeStateCopyWithImpl<$Res, SwipeState>;
  @useResult
  $Res call({Status status, List<UserModel> users});
}

/// @nodoc
class _$SwipeStateCopyWithImpl<$Res, $Val extends SwipeState>
    implements $SwipeStateCopyWith<$Res> {
  _$SwipeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? users = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SwipeStateImplCopyWith<$Res>
    implements $SwipeStateCopyWith<$Res> {
  factory _$$SwipeStateImplCopyWith(
          _$SwipeStateImpl value, $Res Function(_$SwipeStateImpl) then) =
      __$$SwipeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Status status, List<UserModel> users});
}

/// @nodoc
class __$$SwipeStateImplCopyWithImpl<$Res>
    extends _$SwipeStateCopyWithImpl<$Res, _$SwipeStateImpl>
    implements _$$SwipeStateImplCopyWith<$Res> {
  __$$SwipeStateImplCopyWithImpl(
      _$SwipeStateImpl _value, $Res Function(_$SwipeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? users = null,
  }) {
    return _then(_$SwipeStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SwipeStateImpl with DiagnosticableTreeMixin implements _SwipeState {
  const _$SwipeStateImpl(
      {this.status = Status.initial,
      final List<UserModel> users = const <UserModel>[]})
      : _users = users;

  factory _$SwipeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SwipeStateImplFromJson(json);

  @override
  @JsonKey()
  final Status status;
  final List<UserModel> _users;
  @override
  @JsonKey()
  List<UserModel> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SwipeState(status: $status, users: $users)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SwipeState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('users', users));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwipeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SwipeStateImplCopyWith<_$SwipeStateImpl> get copyWith =>
      __$$SwipeStateImplCopyWithImpl<_$SwipeStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SwipeStateImplToJson(
      this,
    );
  }
}

abstract class _SwipeState implements SwipeState {
  const factory _SwipeState(
      {final Status status, final List<UserModel> users}) = _$SwipeStateImpl;

  factory _SwipeState.fromJson(Map<String, dynamic> json) =
      _$SwipeStateImpl.fromJson;

  @override
  Status get status;
  @override
  List<UserModel> get users;
  @override
  @JsonKey(ignore: true)
  _$$SwipeStateImplCopyWith<_$SwipeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
