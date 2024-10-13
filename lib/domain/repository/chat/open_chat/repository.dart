import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:travel/data/model/chat/create_chat_message.dart';
import 'package:travel/data/model/chat/create_chat_room.dart';
import 'package:travel/data/model/chat/edit_chat_room.dart';
import 'package:travel/domain/entity/chat/chat.entity.dart';
import 'package:travel/domain/entity/chat/chat_message.entity.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/response/error_response.dart';
import '../../../../core/util/util.dart';
import '../../../../data/datasource/chat/open_chat/datasource.dart';
import '../../../../data/datasource/storage/datasource.dart';

part 'repository_impl.dart';

abstract interface class OpenChatRepository {
  /// chat room
  Future<Either<ErrorResponse, String>> createChat(
      {required String title, required List<String> hashtags});

  Future<Either<ErrorResponse, List<OpenChatEntity>>> fetchChats(
      {required DateTime beforeAt, int take = 20});

  Future<Either<ErrorResponse, void>> modifyChat(
      {required String chatId, String? title, List<String>? hashtags});

  Future<Either<ErrorResponse, void>> deleteChat(String chatId);

  /// send message
  Future<Either<ErrorResponse, String>> sendMessage(
      {required String chatId, String? content, File? media});

  Future<Either<ErrorResponse, List<OpenChatMessageEntity>>> fetchMessages(
      {required String chatId, required DateTime beforeAt, int take = 20});

  Future<Either<ErrorResponse, void>> deleteChatMessage({
    required String chatId,
    required String messageId,
  });
}
