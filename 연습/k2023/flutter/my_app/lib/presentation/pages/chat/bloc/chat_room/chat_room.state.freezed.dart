// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatRoomState {
  Status get status => throw _privateConstructorUsedError;
  List<ChatRoomModel> get chatRooms => throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatRoomStateCopyWith<ChatRoomState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomStateCopyWith<$Res> {
  factory $ChatRoomStateCopyWith(
          ChatRoomState value, $Res Function(ChatRoomState) then) =
      _$ChatRoomStateCopyWithImpl<$Res, ChatRoomState>;
  @useResult
  $Res call(
      {Status status, List<ChatRoomModel> chatRooms, ErrorResponse error});
}

/// @nodoc
class _$ChatRoomStateCopyWithImpl<$Res, $Val extends ChatRoomState>
    implements $ChatRoomStateCopyWith<$Res> {
  _$ChatRoomStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? chatRooms = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      chatRooms: null == chatRooms
          ? _value.chatRooms
          : chatRooms // ignore: cast_nullable_to_non_nullable
              as List<ChatRoomModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomStateImplCopyWith<$Res>
    implements $ChatRoomStateCopyWith<$Res> {
  factory _$$ChatRoomStateImplCopyWith(
          _$ChatRoomStateImpl value, $Res Function(_$ChatRoomStateImpl) then) =
      __$$ChatRoomStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Status status, List<ChatRoomModel> chatRooms, ErrorResponse error});
}

/// @nodoc
class __$$ChatRoomStateImplCopyWithImpl<$Res>
    extends _$ChatRoomStateCopyWithImpl<$Res, _$ChatRoomStateImpl>
    implements _$$ChatRoomStateImplCopyWith<$Res> {
  __$$ChatRoomStateImplCopyWithImpl(
      _$ChatRoomStateImpl _value, $Res Function(_$ChatRoomStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? chatRooms = null,
    Object? error = null,
  }) {
    return _then(_$ChatRoomStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      chatRooms: null == chatRooms
          ? _value._chatRooms
          : chatRooms // ignore: cast_nullable_to_non_nullable
              as List<ChatRoomModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ));
  }
}

/// @nodoc

class _$ChatRoomStateImpl
    with DiagnosticableTreeMixin
    implements _ChatRoomState {
  const _$ChatRoomStateImpl(
      {this.status = Status.initial,
      final List<ChatRoomModel> chatRooms = const <ChatRoomModel>[],
      this.error = const ErrorResponse()})
      : _chatRooms = chatRooms;

  @override
  @JsonKey()
  final Status status;
  final List<ChatRoomModel> _chatRooms;
  @override
  @JsonKey()
  List<ChatRoomModel> get chatRooms {
    if (_chatRooms is EqualUnmodifiableListView) return _chatRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatRooms);
  }

  @override
  @JsonKey()
  final ErrorResponse error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatRoomState(status: $status, chatRooms: $chatRooms, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatRoomState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('chatRooms', chatRooms))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._chatRooms, _chatRooms) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_chatRooms), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomStateImplCopyWith<_$ChatRoomStateImpl> get copyWith =>
      __$$ChatRoomStateImplCopyWithImpl<_$ChatRoomStateImpl>(this, _$identity);
}

abstract class _ChatRoomState implements ChatRoomState {
  const factory _ChatRoomState(
      {final Status status,
      final List<ChatRoomModel> chatRooms,
      final ErrorResponse error}) = _$ChatRoomStateImpl;

  @override
  Status get status;
  @override
  List<ChatRoomModel> get chatRooms;
  @override
  ErrorResponse get error;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomStateImplCopyWith<_$ChatRoomStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
