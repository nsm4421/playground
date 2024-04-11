import 'package:fpdart/fpdart.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.constant.dart';

@lazySingleton
class DeleteOpenChatUseCase {
  final ChatRepository _repository;

  DeleteOpenChatUseCase(this._repository);

  Future<Either<Failure, void>> call(String openChatId) async {
    return await _repository.deleteOpenChatById(openChatId);
  }
}
