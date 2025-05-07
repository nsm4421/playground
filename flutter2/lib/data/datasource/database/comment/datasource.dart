import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/data/model/comment/create.dart';
import 'package:travel/data/model/comment/fetch.dart';

part 'datasource_impl.dart';

abstract interface class CommentDataSource {
  Future<void> create(CreateCommentDto dto);

  Future<Iterable<FetchCommentDto>> fetchParents(
      {required String beforeAt,
      required String referenceId,
      required String referenceTable,
      int take = 20});

  Future<Iterable<FetchCommentDto>> fetchChildren(
      {required String beforeAt,
      required String referenceId,
      required String referenceTable,
      required String parentId,
      int take = 20});

  Future<void> delete(String id);
}
