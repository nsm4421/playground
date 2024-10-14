import 'package:injectable/injectable.dart';
import 'package:travel/domain/repository/meeting/repository.dart';

import '../../data/datasource/datasource_module.dart';
import 'account/repository.dart';
import 'auth/repository.dart';
import 'chat/open_chat/repository.dart';
import 'chat/private_chat/repository.dart';
import 'diary/repository.dart';

@lazySingleton
class RepositoryModule {
  final DataSourceModule _dataSourceModule;

  RepositoryModule(this._dataSourceModule);

  @lazySingleton
  AuthRepository get auth => AuthRepositoryImpl(
      authDataSource: _dataSourceModule.auth,
      storageDataSource: _dataSourceModule.storage,
      localDataSource: _dataSourceModule.local);

  @lazySingleton
  AccountRepository get account =>
      AccountRepositoryImpl(_dataSourceModule.account);

  @lazySingleton
  OpenChatRepository get openChat => OpenChatRepositoryImpl(
      chatRoomDataSource: _dataSourceModule.openChat,
      messageDataSource: _dataSourceModule.openChatMessage,
      storageDataSource: _dataSourceModule.storage);

  @lazySingleton
  PrivateChatRepository get privateChat => PrivateChatRepositoryImpl(
      chatRoomDataSource: _dataSourceModule.privateChat,
      messageDataSource: _dataSourceModule.privateChatMessage,
      storageDataSource: _dataSourceModule.storage);

  @lazySingleton
  DiaryRepository get diary => DiaryRepositoryImpl(
      diaryDataSource: _dataSourceModule.diary,
      storageDataSource: _dataSourceModule.storage);

  @lazySingleton
  MeetingRepository get meeting => MeetingRepositoryImpl(
      meetingDataSource: _dataSourceModule.meeting,
      storageDataSource: _dataSourceModule.storage,
      channelDataSource: _dataSourceModule.channel);
}
