import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/receipt_model.g.dart';

part '../generated/receipt_model.freezed.dart';


enum ReceiptStatus { sent, delivered, read }

extension EnumParsing on ReceiptStatus {
  String value() {
    return toString().split(".").last;
  }

  static ReceiptStatus fromString(String text) {
    return ReceiptStatus.values
        .firstWhere((element) => element.value() == text);
  }
}

/**
 * 메세지 수신 여부
 ** receiptId
 ** messageId : 메세지 id
 ** status : 메세지 수신 상태
 ** createdAt : 메세지 보낸 시간
 */
@freezed
sealed class ReceiptModel with _$ReceiptModel {
  factory ReceiptModel(
      {
        String? receiptId,
        String? messageId,
        ReceiptStatus? status,
        DateTime? createdAt,
      }) = _ReceiptModel;

  factory ReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptModelFromJson(json);
}
