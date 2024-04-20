import 'package:hot_place/data/data_source/chat/base/room/local.data_source.dart';

import '../../../../../domain/model/chat/private_chat/room/private_chat.local_model.dart';

abstract interface class LocalPrivateChatDataSource
    implements LocalChatDataSource<LocalPrivateChatModel> {}
