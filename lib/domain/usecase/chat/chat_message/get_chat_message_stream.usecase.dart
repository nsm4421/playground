import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/error_response.dart';
import '../../../model/result/result.dart';
import '../../../repository/chat.repository.dart';
import '../../base/remote.usecase.dart';

class GetChatMessageStreamUseCase extends RemoteUseCase<ChatRepository> {
  final String chatRoomId;

  GetChatMessageStreamUseCase({required this.chatRoomId});

  @override
  Future call(ChatRepository repository) async {
    final result = repository.getChatMessageStream(chatRoomId);
    return result.status == ResponseStatus.success
        ? Result.success(result.data ?? [])
        : Result.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
