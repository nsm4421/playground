import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/data_source/mock/mock_story.api.dart';
import 'package:my_app/data/data_source/remote/chat/chat.api.dart';
import 'package:my_app/data/data_source/remote/story/story.api.dart';

import '../../core/constant/rest_client.dart';
import 'remote/auth/auth.api.dart';

@module
abstract class DataSourceModule {
  final Dio _dio = RestClient().dio;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // TODO : Mock API 대신 Story API로 수정하기
  // StoryApi get storyApi => StoryApi(_dio);
  @singleton
  StoryApi get storyApi => MockStoryApi();

  @singleton
  AuthApi get userApi => AuthApi(auth: _auth, db: _db, storage: _storage);

  @singleton
  ChatApi get chatApi => ChatApi(auth: _auth, db: _db);
}
