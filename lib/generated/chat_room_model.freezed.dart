// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../model/chat_room_model.dart';

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
  String? get docId => throw _privateConstructorUsedError;
  String? get chatRoomId => throw _privateConstructorUsedError;
  List<String>? get uidList => throw _privateConstructorUsedError;
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
      {String? docId,
      String? chatRoomId,
      List<String>? uidList,
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
    Object? docId = freezed,
    Object? chatRoomId = freezed,
    Object? uidList = freezed,
    Object? createdAt = freezed,
    Object? removedAt = freezed,
  }) {
    return _then(_value.copyWith(
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      uidList: freezed == uidList
          ? _value.uidList
          : uidList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
abstract class _$$_ChatRoomModelCopyWith<$Res>
    implements $ChatRoomModelCopyWith<$Res> {
  factory _$$_ChatRoomModelCopyWith(
          _$_ChatRoomModel value, $Res Function(_$_ChatRoomModel) then) =
      __$$_ChatRoomModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? docId,
      String? chatRoomId,
      List<String>? uidList,
      DateTime? createdAt,
      DateTime? removedAt});
}

/// @nodoc
class __$$_ChatRoomModelCopyWithImpl<$Res>
    extends _$ChatRoomModelCopyWithImpl<$Res, _$_ChatRoomModel>
    implements _$$_ChatRoomModelCopyWith<$Res> {
  __$$_ChatRoomModelCopyWithImpl(
      _$_ChatRoomModel _value, $Res Function(_$_ChatRoomModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = freezed,
    Object? chatRoomId = freezed,
    Object? uidList = freezed,
    Object? createdAt = freezed,
    Object? removedAt = freezed,
  }) {
    return _then(_$_ChatRoomModel(
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      uidList: freezed == uidList
          ? _value._uidList
          : uidList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
class _$_ChatRoomModel implements _ChatRoomModel {
  _$_ChatRoomModel(
      {this.docId,
      this.chatRoomId,
      final List<String>? uidList,
      this.createdAt,
      this.removedAt})
      : _uidList = uidList;

  factory _$_ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatRoomModelFromJson(json);

  @override
  final String? docId;
  @override
  final String? chatRoomId;
  final List<String>? _uidList;
  @override
  List<String>? get uidList {
    final value = _uidList;
    if (value == null) return null;
    if (_uidList is EqualUnmodifiableListView) return _uidList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? removedAt;

  @override
  String toString() {
    return 'ChatRoomModel(docId: $docId, chatRoomId: $chatRoomId, uidList: $uidList, createdAt: $createdAt, removedAt: $removedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatRoomModel &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            const DeepCollectionEquality().equals(other._uidList, _uidList) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.removedAt, removedAt) ||
                other.removedAt == removedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, docId, chatRoomId,
      const DeepCollectionEquality().hash(_uidList), createdAt, removedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatRoomModelCopyWith<_$_ChatRoomModel> get copyWith =>
      __$$_ChatRoomModelCopyWithImpl<_$_ChatRoomModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatRoomModelToJson(
      this,
    );
  }
}

abstract class _ChatRoomModel implements ChatRoomModel {
  factory _ChatRoomModel(
      {final String? docId,
      final String? chatRoomId,
      final List<String>? uidList,
      final DateTime? createdAt,
      final DateTime? removedAt}) = _$_ChatRoomModel;

  factory _ChatRoomModel.fromJson(Map<String, dynamic> json) =
      _$_ChatRoomModel.fromJson;

  @override
  String? get docId;
  @override
  String? get chatRoomId;
  @override
  List<String>? get uidList;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get removedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ChatRoomModelCopyWith<_$_ChatRoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}
