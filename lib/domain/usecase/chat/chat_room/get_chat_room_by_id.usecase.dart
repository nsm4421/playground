import 'package:my_app/domain/repository/chat.repository.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/error_response.dart';
import '../../../model/result/result.dart';
import '../../base/remote.usecase.dart';

class GetChatRoomByIdUseCase extends RemoteUseCase<ChatRepository> {
  final String chatRoomId;

  GetChatRoomByIdUseCase({required this.chatRoomId});

  @override
  Future call(ChatRepository repository) async {
    final result = await repository.getChatRoomById(chatRoomId);
    return result.status == ResponseStatus.success
        ? Result.success(result.data)
        : Result.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
