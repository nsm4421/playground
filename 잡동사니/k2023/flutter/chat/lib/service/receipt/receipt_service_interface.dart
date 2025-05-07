import '../../model/receipt_model.dart';
import '../../model/user_model.dart';

abstract class IReceiptService {
  Future<bool> send(Receipt receipt);

  Stream<Receipt> receipts(User user);

  void dispose();
}
