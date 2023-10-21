// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) {
  return _ChatRoomModel.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomModel {
  String? get chatRoomId => throw _privateConstructorUsedError;
  String? get chatRoomName => throw _privateConstructorUsedError;
  String? get hostUserId => throw _privateConstructorUsedError;
  List<String> get hashtags => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get removedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomModelCopyWith<ChatRoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomModelCopyWith<$Res> {
  factory $ChatRoomModelCopyWith(
          ChatRoomModel value, $Res Function(ChatRoomModel) then) =
      _$ChatRoomModelCopyWithImpl<$Res, ChatRoomModel>;
  @useResult
  $Res call(
      {String? chatRoomId,
      String? chatRoomName,
      String? hostUserId,
      List<String> hashtags,
      DateTime? createdAt,
      DateTime? removedAt});
}

/// @nodoc
class _$ChatRoomModelCopyWithImpl<$Res, $Val extends ChatRoomModel>
    implements $ChatRoomModelCopyWith<$Res> {
  _$ChatRoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? chatRoomName = freezed,
    Object? hostUserId = freezed,
    Object? hashtags = null,
    Object? createdAt = freezed,
    Object? removedAt = freezed,
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
      hostUserId: freezed == hostUserId
          ? _value.hostUserId
          : hostUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _value.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      removedAt: freezed == removedAt
          ? _value.removedAt
          : removedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomModelImplCopyWith<$Res>
    implements $ChatRoomModelCopyWith<$Res> {
  factory _$$ChatRoomModelImplCopyWith(
          _$ChatRoomModelImpl value, $Res Function(_$ChatRoomModelImpl) then) =
      __$$ChatRoomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? chatRoomId,
      String? chatRoomName,
      String? hostUserId,
      List<String> hashtags,
      DateTime? createdAt,
      DateTime? removedAt});
}

/// @nodoc
class __$$ChatRoomModelImplCopyWithImpl<$Res>
    extends _$ChatRoomModelCopyWithImpl<$Res, _$ChatRoomModelImpl>
    implements _$$ChatRoomModelImplCopyWith<$Res> {
  __$$ChatRoomModelImplCopyWithImpl(
      _$ChatRoomModelImpl _value, $Res Function(_$ChatRoomModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? chatRoomName = freezed,
    Object? hostUserId = freezed,
    Object? hashtags = null,
    Object? createdAt = freezed,
    Object? removedAt = freezed,
  }) {
    return _then(_$ChatRoomModelImpl(
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      chatRoomName: freezed == chatRoomName
          ? _value.chatRoomName
          : chatRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      hostUserId: freezed == hostUserId
          ? _value.hostUserId
          : hostUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _value._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      removedAt: freezed == removedAt
          ? _value.removedAt
          : removedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomModelImpl
    with DiagnosticableTreeMixin
    implements _ChatRoomModel {
  const _$ChatRoomModelImpl(
      {this.chatRoomId = '',
      this.chatRoomName = '',
      this.hostUserId = '',
      final List<String> hashtags = const <String>[],
      this.createdAt,
      this.removedAt})
      : _hashtags = hashtags;

  factory _$ChatRoomModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomModelImplFromJson(json);

  @override
  @JsonKey()
  final String? chatRoomId;
  @override
  @JsonKey()
  final String? chatRoomName;
  @override
  @JsonKey()
  final String? hostUserId;
  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? removedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatRoomModel(chatRoomId: $chatRoomId, chatRoomName: $chatRoomName, hostUserId: $hostUserId, hashtags: $hashtags, createdAt: $createdAt, removedAt: $removedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatRoomModel'))
      ..add(DiagnosticsProperty('chatRoomId', chatRoomId))
      ..add(DiagnosticsProperty('chatRoomName', chatRoomName))
      ..add(DiagnosticsProperty('hostUserId', hostUserId))
      ..add(DiagnosticsProperty('hashtags', hashtags))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('removedAt', removedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomModelImpl &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.chatRoomName, chatRoomName) ||
                other.chatRoomName == chatRoomName) &&
            (identical(other.hostUserId, hostUserId) ||
                other.hostUserId == hostUserId) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.removedAt, removedAt) ||
                other.removedAt == removedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      chatRoomId,
      chatRoomName,
      hostUserId,
      const DeepCollectionEquality().hash(_hashtags),
      createdAt,
      removedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomModelImplCopyWith<_$ChatRoomModelImpl> get copyWith =>
      __$$ChatRoomModelImplCopyWithImpl<_$ChatRoomModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomModelImplToJson(
      this,
    );
  }
}

abstract class _ChatRoomModel implements ChatRoomModel {
  const factory _ChatRoomModel(
      {final String? chatRoomId,
      final String? chatRoomName,
      final String? hostUserId,
      final List<String> hashtags,
      final DateTime? createdAt,
      final DateTime? removedAt}) = _$ChatRoomModelImpl;

  factory _ChatRoomModel.fromJson(Map<String, dynamic> json) =
      _$ChatRoomModelImpl.fromJson;

  @override
  String? get chatRoomId;
  @override
  String? get chatRoomName;
  @override
  String? get hostUserId;
  @override
  List<String> get hashtags;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get removedAt;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomModelImplCopyWith<_$ChatRoomModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
