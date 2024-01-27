// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatMessageDto _$ChatMessageDtoFromJson(Map<String, dynamic> json) {
  return _ChatMessageDto.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageDto {
  String? get chatRoomId => throw _privateConstructorUsedError;
  String? get senderUid => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageDtoCopyWith<ChatMessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageDtoCopyWith<$Res> {
  factory $ChatMessageDtoCopyWith(
          ChatMessageDto value, $Res Function(ChatMessageDto) then) =
      _$ChatMessageDtoCopyWithImpl<$Res, ChatMessageDto>;
  @useResult
  $Res call(
      {String? chatRoomId,
      String? senderUid,
      String? message,
      DateTime? createdAt});
}

/// @nodoc
class _$ChatMessageDtoCopyWithImpl<$Res, $Val extends ChatMessageDto>
    implements $ChatMessageDtoCopyWith<$Res> {
  _$ChatMessageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? senderUid = freezed,
    Object? message = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderUid: freezed == senderUid
          ? _value.senderUid
          : senderUid // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageDtoImplCopyWith<$Res>
    implements $ChatMessageDtoCopyWith<$Res> {
  factory _$$ChatMessageDtoImplCopyWith(_$ChatMessageDtoImpl value,
          $Res Function(_$ChatMessageDtoImpl) then) =
      __$$ChatMessageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? chatRoomId,
      String? senderUid,
      String? message,
      DateTime? createdAt});
}

/// @nodoc
class __$$ChatMessageDtoImplCopyWithImpl<$Res>
    extends _$ChatMessageDtoCopyWithImpl<$Res, _$ChatMessageDtoImpl>
    implements _$$ChatMessageDtoImplCopyWith<$Res> {
  __$$ChatMessageDtoImplCopyWithImpl(
      _$ChatMessageDtoImpl _value, $Res Function(_$ChatMessageDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? senderUid = freezed,
    Object? message = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ChatMessageDtoImpl(
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderUid: freezed == senderUid
          ? _value.senderUid
          : senderUid // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
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
class _$ChatMessageDtoImpl
    with DiagnosticableTreeMixin
    implements _ChatMessageDto {
  const _$ChatMessageDtoImpl(
      {this.chatRoomId = '',
      this.senderUid = '',
      this.message = '',
      this.createdAt});

  factory _$ChatMessageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageDtoImplFromJson(json);

  @override
  @JsonKey()
  final String? chatRoomId;
  @override
  @JsonKey()
  final String? senderUid;
  @override
  @JsonKey()
  final String? message;
  @override
  final DateTime? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessageDto(chatRoomId: $chatRoomId, senderUid: $senderUid, message: $message, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessageDto'))
      ..add(DiagnosticsProperty('chatRoomId', chatRoomId))
      ..add(DiagnosticsProperty('senderUid', senderUid))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageDtoImpl &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.senderUid, senderUid) ||
                other.senderUid == senderUid) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, chatRoomId, senderUid, message, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageDtoImplCopyWith<_$ChatMessageDtoImpl> get copyWith =>
      __$$ChatMessageDtoImplCopyWithImpl<_$ChatMessageDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageDtoImplToJson(
      this,
    );
  }
}

abstract class _ChatMessageDto implements ChatMessageDto {
  const factory _ChatMessageDto(
      {final String? chatRoomId,
      final String? senderUid,
      final String? message,
      final DateTime? createdAt}) = _$ChatMessageDtoImpl;

  factory _ChatMessageDto.fromJson(Map<String, dynamic> json) =
      _$ChatMessageDtoImpl.fromJson;

  @override
  String? get chatRoomId;
  @override
  String? get senderUid;
  @override
  String? get message;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ChatMessageDtoImplCopyWith<_$ChatMessageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
