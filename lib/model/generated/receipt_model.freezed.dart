// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../receipt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) {
  return _ReceiptModel.fromJson(json);
}

/// @nodoc
mixin _$ReceiptModel {
  String? get receiptId => throw _privateConstructorUsedError;
  String? get messageId => throw _privateConstructorUsedError;
  ReceiptStatus? get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceiptModelCopyWith<ReceiptModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptModelCopyWith<$Res> {
  factory $ReceiptModelCopyWith(
          ReceiptModel value, $Res Function(ReceiptModel) then) =
      _$ReceiptModelCopyWithImpl<$Res, ReceiptModel>;
  @useResult
  $Res call(
      {String? receiptId,
      String? messageId,
      ReceiptStatus? status,
      DateTime? createdAt});
}

/// @nodoc
class _$ReceiptModelCopyWithImpl<$Res, $Val extends ReceiptModel>
    implements $ReceiptModelCopyWith<$Res> {
  _$ReceiptModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiptId = freezed,
    Object? messageId = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      receiptId: freezed == receiptId
          ? _value.receiptId
          : receiptId // ignore: cast_nullable_to_non_nullable
              as String?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReceiptStatus?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReceiptModelCopyWith<$Res>
    implements $ReceiptModelCopyWith<$Res> {
  factory _$$_ReceiptModelCopyWith(
          _$_ReceiptModel value, $Res Function(_$_ReceiptModel) then) =
      __$$_ReceiptModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? receiptId,
      String? messageId,
      ReceiptStatus? status,
      DateTime? createdAt});
}

/// @nodoc
class __$$_ReceiptModelCopyWithImpl<$Res>
    extends _$ReceiptModelCopyWithImpl<$Res, _$_ReceiptModel>
    implements _$$_ReceiptModelCopyWith<$Res> {
  __$$_ReceiptModelCopyWithImpl(
      _$_ReceiptModel _value, $Res Function(_$_ReceiptModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiptId = freezed,
    Object? messageId = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_ReceiptModel(
      receiptId: freezed == receiptId
          ? _value.receiptId
          : receiptId // ignore: cast_nullable_to_non_nullable
              as String?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReceiptStatus?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReceiptModel implements _ReceiptModel {
  _$_ReceiptModel(
      {this.receiptId, this.messageId, this.status, this.createdAt});

  factory _$_ReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$$_ReceiptModelFromJson(json);

  @override
  final String? receiptId;
  @override
  final String? messageId;
  @override
  final ReceiptStatus? status;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ReceiptModel(receiptId: $receiptId, messageId: $messageId, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReceiptModel &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, receiptId, messageId, status, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReceiptModelCopyWith<_$_ReceiptModel> get copyWith =>
      __$$_ReceiptModelCopyWithImpl<_$_ReceiptModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReceiptModelToJson(
      this,
    );
  }
}

abstract class _ReceiptModel implements ReceiptModel {
  factory _ReceiptModel(
      {final String? receiptId,
      final String? messageId,
      final ReceiptStatus? status,
      final DateTime? createdAt}) = _$_ReceiptModel;

  factory _ReceiptModel.fromJson(Map<String, dynamic> json) =
      _$_ReceiptModel.fromJson;

  @override
  String? get receiptId;
  @override
  String? get messageId;
  @override
  ReceiptStatus? get status;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_ReceiptModelCopyWith<_$_ReceiptModel> get copyWith =>
      throw _privateConstructorUsedError;
}
