import 'package:my_app/domain/repository/chat.repository.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/error_response.dart';
import '../../../model/result/result.dart';
import '../../base/remote.usecase.dart';

class CreateChatRoomUseCase extends RemoteUseCase<ChatRepository> {
  final String chatRoomName;
  final List<String> hashtags;

  CreateChatRoomUseCase({required this.chatRoomName, required this.hashtags});

  @override
  Future call(ChatRepository repository) async {
    final result = await repository.createChatRoom(
        chatRoomName: chatRoomName, hashtags: hashtags);
    return result.status == ResponseStatus.success
        ? const Result.success(null)
        : Result.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
