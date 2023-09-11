// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model/receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReceiptModel _$$_ReceiptModelFromJson(Map<String, dynamic> json) =>
    _$_ReceiptModel(
      docId: json['docId'] as String?,
      receiptId: json['receiptId'] as String?,
      messageId: json['messageId'] as String?,
      status: $enumDecodeNullable(_$ReceiptStatusEnumMap, json['status']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_ReceiptModelToJson(_$_ReceiptModel instance) =>
    <String, dynamic>{
      'docId': instance.docId,
      'receiptId': instance.receiptId,
      'messageId': instance.messageId,
      'status': _$ReceiptStatusEnumMap[instance.status],
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$ReceiptStatusEnumMap = {
  ReceiptStatus.sent: 'sent',
  ReceiptStatus.delivered: 'delivered',
  ReceiptStatus.read: 'read',
};
