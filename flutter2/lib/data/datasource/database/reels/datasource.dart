import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/data/model/reels/create.dart';
import 'package:travel/data/model/reels/fetch.dart';

part 'datasource_impl.dart';

abstract interface class ReelsDataSource {
  Future<void> create({required String id, required CreateReelsDto dto});

  Future<Iterable<FetchReelsDto>> fetch(
      {required String beforeAt, int take = 20});

  Future<void> edit({required String id, String? caption});

  Future<void> delete(String id);
}
