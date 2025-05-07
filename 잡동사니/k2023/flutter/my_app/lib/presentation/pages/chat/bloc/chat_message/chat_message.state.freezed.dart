// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatMessageState {
  Status get status => throw _privateConstructorUsedError;
  List<ChatMessageModel> get messages => throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatMessageStateCopyWith<ChatMessageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageStateCopyWith<$Res> {
  factory $ChatMessageStateCopyWith(
          ChatMessageState value, $Res Function(ChatMessageState) then) =
      _$ChatMessageStateCopyWithImpl<$Res, ChatMessageState>;
  @useResult
  $Res call(
      {Status status, List<ChatMessageModel> messages, ErrorResponse error});
}

/// @nodoc
class _$ChatMessageStateCopyWithImpl<$Res, $Val extends ChatMessageState>
    implements $ChatMessageStateCopyWith<$Res> {
  _$ChatMessageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? messages = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageStateImplCopyWith<$Res>
    implements $ChatMessageStateCopyWith<$Res> {
  factory _$$ChatMessageStateImplCopyWith(_$ChatMessageStateImpl value,
          $Res Function(_$ChatMessageStateImpl) then) =
      __$$ChatMessageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Status status, List<ChatMessageModel> messages, ErrorResponse error});
}

/// @nodoc
class __$$ChatMessageStateImplCopyWithImpl<$Res>
    extends _$ChatMessageStateCopyWithImpl<$Res, _$ChatMessageStateImpl>
    implements _$$ChatMessageStateImplCopyWith<$Res> {
  __$$ChatMessageStateImplCopyWithImpl(_$ChatMessageStateImpl _value,
      $Res Function(_$ChatMessageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? messages = null,
    Object? error = null,
  }) {
    return _then(_$ChatMessageStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ));
  }
}

/// @nodoc

class _$ChatMessageStateImpl
    with DiagnosticableTreeMixin
    implements _ChatMessageState {
  const _$ChatMessageStateImpl(
      {this.status = Status.initial,
      final List<ChatMessageModel> messages = const <ChatMessageModel>[],
      this.error = const ErrorResponse()})
      : _messages = messages;

  @override
  @JsonKey()
  final Status status;
  final List<ChatMessageModel> _messages;
  @override
  @JsonKey()
  List<ChatMessageModel> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final ErrorResponse error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessageState(status: $status, messages: $messages, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessageState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_messages), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageStateImplCopyWith<_$ChatMessageStateImpl> get copyWith =>
      __$$ChatMessageStateImplCopyWithImpl<_$ChatMessageStateImpl>(
          this, _$identity);
}

abstract class _ChatMessageState implements ChatMessageState {
  const factory _ChatMessageState(
      {final Status status,
      final List<ChatMessageModel> messages,
      final ErrorResponse error}) = _$ChatMessageStateImpl;

  @override
  Status get status;
  @override
  List<ChatMessageModel> get messages;
  @override
  ErrorResponse get error;
  @override
  @JsonKey(ignore: true)
  _$$ChatMessageStateImplCopyWith<_$ChatMessageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
