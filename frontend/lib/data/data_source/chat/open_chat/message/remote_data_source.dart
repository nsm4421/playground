import 'package:hot_place/domain/model/chat/open_chat/message/open_chat_message.model.dart';

import '../../base/message/remote_data_source.dart';

abstract interface class RemoteOpenChatMessageDataSource
    implements RemoteChatMessageDataSource<OpenChatMessageModel> {}
