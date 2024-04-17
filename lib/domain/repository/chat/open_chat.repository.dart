import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';

abstract class OpenChatRepository {
  Stream<List<OpenChatEntity>> get openChatStream;

  Future<Either<Failure, OpenChatEntity>> createOpenChat(
      OpenChatEntity openChat);

  Future<Either<Failure, String>> modifyOpenChat(OpenChatEntity openChat);

  Future<Either<Failure, void>> deleteOpenChatById(String openChatId);
}
