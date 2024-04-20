import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';
import 'package:hot_place/domain/model/chat/private_chat/room/private_chat.model.dart';
import 'package:hot_place/domain/repository/chat/room/private_chat.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/custom_exception.dart';
import '../../../data_source/chat/private_chat/room/remote.data_source.dart';

@LazySingleton(as: PrivateChatRepository)
class PrivateChatRepositoryImpl implements PrivateChatRepository {
  final RemotePrivateChatDataSource _dataSource;

  PrivateChatRepositoryImpl(this._dataSource);

  @override
  Stream<List<PrivateChatEntity>> get chatStream => _dataSource
      .getChatStream()
      .asyncMap((event) => event.map(PrivateChatEntity.fromModel).toList());

  @override
  Future<Either<Failure, void>> createChat(PrivateChatEntity chat) async {
    try {
      return await _dataSource
          .createChat(PrivateChatModel.fromEntity(chat))
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChatById(String chatId) async {
    try {
      return await _dataSource.deleteChatById(chatId).then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
