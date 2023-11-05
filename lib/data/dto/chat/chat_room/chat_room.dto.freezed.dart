// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatRoomDto _$ChatRoomDtoFromJson(Map<String, dynamic> json) {
  return _ChatRoomDto.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomDto {
  String? get chatRoomId => throw _privateConstructorUsedError;
  String? get chatRoomName => throw _privateConstructorUsedError;
  List<String> get hashtags => throw _privateConstructorUsedError;
  List<String> get uidList => throw _privateConstructorUsedError;
  String? get hostUid => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomDtoCopyWith<ChatRoomDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomDtoCopyWith<$Res> {
  factory $ChatRoomDtoCopyWith(
          ChatRoomDto value, $Res Function(ChatRoomDto) then) =
      _$ChatRoomDtoCopyWithImpl<$Res, ChatRoomDto>;
  @useResult
  $Res call(
      {String? chatRoomId,
      String? chatRoomName,
      List<String> hashtags,
      List<String> uidList,
      String? hostUid,
      DateTime? createdAt});
}

/// @nodoc
class _$ChatRoomDtoCopyWithImpl<$Res, $Val extends ChatRoomDto>
    implements $ChatRoomDtoCopyWith<$Res> {
  _$ChatRoomDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? chatRoomName = freezed,
    Object? hashtags = null,
    Object? uidList = null,
    Object? hostUid = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      chatRoomName: freezed == chatRoomName
          ? _value.chatRoomName
          : chatRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _value.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      uidList: null == uidList
          ? _value.uidList
          : uidList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hostUid: freezed == hostUid
          ? _value.hostUid
          : hostUid // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomDtoImplCopyWith<$Res>
    implements $ChatRoomDtoCopyWith<$Res> {
  factory _$$ChatRoomDtoImplCopyWith(
          _$ChatRoomDtoImpl value, $Res Function(_$ChatRoomDtoImpl) then) =
      __$$ChatRoomDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? chatRoomId,
      String? chatRoomName,
      List<String> hashtags,
      List<String> uidList,
      String? hostUid,
      DateTime? createdAt});
}

/// @nodoc
class __$$ChatRoomDtoImplCopyWithImpl<$Res>
    extends _$ChatRoomDtoCopyWithImpl<$Res, _$ChatRoomDtoImpl>
    implements _$$ChatRoomDtoImplCopyWith<$Res> {
  __$$ChatRoomDtoImplCopyWithImpl(
      _$ChatRoomDtoImpl _value, $Res Function(_$ChatRoomDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? chatRoomName = freezed,
    Object? hashtags = null,
    Object? uidList = null,
    Object? hostUid = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ChatRoomDtoImpl(
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      chatRoomName: freezed == chatRoomName
          ? _value.chatRoomName
          : chatRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _value._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      uidList: null == uidList
          ? _value._uidList
          : uidList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hostUid: freezed == hostUid
          ? _value.hostUid
          : hostUid // ignore: cast_nullable_to_non_nullable
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
class _$ChatRoomDtoImpl with DiagnosticableTreeMixin implements _ChatRoomDto {
  const _$ChatRoomDtoImpl(
      {this.chatRoomId = '',
      this.chatRoomName = '',
      final List<String> hashtags = const <String>[],
      final List<String> uidList = const <String>[],
      this.hostUid = '',
      this.createdAt})
      : _hashtags = hashtags,
        _uidList = uidList;

  factory _$ChatRoomDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomDtoImplFromJson(json);

  @override
  @JsonKey()
  final String? chatRoomId;
  @override
  @JsonKey()
  final String? chatRoomName;
  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  final List<String> _uidList;
  @override
  @JsonKey()
  List<String> get uidList {
    if (_uidList is EqualUnmodifiableListView) return _uidList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uidList);
  }

  @override
  @JsonKey()
  final String? hostUid;
  @override
  final DateTime? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatRoomDto(chatRoomId: $chatRoomId, chatRoomName: $chatRoomName, hashtags: $hashtags, uidList: $uidList, hostUid: $hostUid, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatRoomDto'))
      ..add(DiagnosticsProperty('chatRoomId', chatRoomId))
      ..add(DiagnosticsProperty('chatRoomName', chatRoomName))
      ..add(DiagnosticsProperty('hashtags', hashtags))
      ..add(DiagnosticsProperty('uidList', uidList))
      ..add(DiagnosticsProperty('hostUid', hostUid))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomDtoImpl &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.chatRoomName, chatRoomName) ||
                other.chatRoomName == chatRoomName) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            const DeepCollectionEquality().equals(other._uidList, _uidList) &&
            (identical(other.hostUid, hostUid) || other.hostUid == hostUid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      chatRoomId,
      chatRoomName,
      const DeepCollectionEquality().hash(_hashtags),
      const DeepCollectionEquality().hash(_uidList),
      hostUid,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomDtoImplCopyWith<_$ChatRoomDtoImpl> get copyWith =>
      __$$ChatRoomDtoImplCopyWithImpl<_$ChatRoomDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomDtoImplToJson(
      this,
    );
  }
}

abstract class _ChatRoomDto implements ChatRoomDto {
  const factory _ChatRoomDto(
      {final String? chatRoomId,
      final String? chatRoomName,
      final List<String> hashtags,
      final List<String> uidList,
      final String? hostUid,
      final DateTime? createdAt}) = _$ChatRoomDtoImpl;

  factory _ChatRoomDto.fromJson(Map<String, dynamic> json) =
      _$ChatRoomDtoImpl.fromJson;

  @override
  String? get chatRoomId;
  @override
  String? get chatRoomName;
  @override
  List<String> get hashtags;
  @override
  List<String> get uidList;
  @override
  String? get hostUid;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomDtoImplCopyWith<_$ChatRoomDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
