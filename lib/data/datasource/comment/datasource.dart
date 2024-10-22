import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constant/constant.dart';
import '../../../core/util/util.dart';
import '../../model/comment/fetch_comment.dart';

part 'datasource_impl.dart';

abstract interface class CommentDataSource {
  Future<Iterable<FetchCommentModel>> fetch(
      {required Tables refTable,
      required String refId,
      required String beforeAt,
      int take = 20});

  Future<String> create(
      {required Tables refTable, required String refId, required String content});

  Future<void> modifyById({required String commentId, required String content});

  Future<void> modifyByRef(
      {required Tables refTable,
      required String refId,
      required String content});

  Future<void> deleteById(String commentId);

  Future<void> deleteByRef({required Tables refTable, required String refId});
}
