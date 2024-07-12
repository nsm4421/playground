import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.constant.dart';

abstract interface class ChatRepository<T> {
  Stream<List<T>> get chatStream;

  Future<Either<Failure, void>> deleteChatById(String chatId);
}
