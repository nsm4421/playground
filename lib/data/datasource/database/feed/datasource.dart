import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/data/model/feed/create.dart';
import 'package:travel/data/model/feed/fetch.dart';
import 'package:travel/data/model/feed/update.dart';

part 'datasource_impl.dart';

abstract interface class FeedDataSource {
  Future<void> create({required String id, required CreateFeedDto dto});

  Future<Iterable<FetchFeedResDto>> fetch(FetchFeedReqDto dto);

  Future<void> edit({required String id, required UpdateFeedDto dto});

  Future<void> delete(String id);
}
