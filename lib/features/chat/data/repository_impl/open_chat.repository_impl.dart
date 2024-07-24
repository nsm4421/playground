import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/features/chat/data/datasource/open_chat.datasource.dart';
import 'package:portfolio/features/chat/data/model/open_chat.model.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main/core/constant/response_wrapper.dart';

part 'package:portfolio/features/chat/domain/repository/open_chat.repository.dart';

@LazySingleton(as: OpenChatRepository)
class OpenChatRepositoryImpl implements OpenChatRepository {
  final OpenChatDataSource _dataSource;
  final _logger = Logger();

  OpenChatRepositoryImpl(this._dataSource);

  @override
  Future<ResponseWrapper<void>> createChat(OpenChatEntity chat) async {
    try {
      await _dataSource.createChat(OpenChatModel.fromEntity(chat));
      return ResponseWrapper.success(null);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error("create open chat fail");
    }
  }
}
