import 'package:hot_place/data/data_source/chat/base/message/remote_data_source.dart';
import 'package:hot_place/domain/model/chat/private_chat/message/private_chat_message.model.dart';

abstract interface class RemotePrivateChatMessageDataSource
    implements RemoteChatMessageDataSource<PrivateChatMessageModel> {}
