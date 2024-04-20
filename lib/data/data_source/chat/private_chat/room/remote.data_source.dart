import 'package:hot_place/domain/model/user/user.model.dart';

import '../../../../../domain/model/chat/private_chat/room/private_chat.model.dart';
import '../../base/room/remote_data_source.dart';

abstract interface class RemotePrivateChatDataSource
    implements RemoteChatDataSource<PrivateChatModel> {
  Future<PrivateChatModel> getChatByUser(
      {required UserModel currentUser, required UserModel opponentUser});
}
