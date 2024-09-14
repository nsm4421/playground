import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/shared.export.dart';
import '../dto/create_reels.dto.dart';
import '../dto/edit_reels.dto.dart';
import '../dto/fetch_reels.dto.dart';

part 'datasource.dart';

class ReelsDataSourceImpl extends ReelsDataSource {
  final SupabaseClient _supabaseClient;
  final Logger _logger;

  ReelsDataSourceImpl(
      {required SupabaseClient supabaseClient, required Logger logger})
      : _supabaseClient = supabaseClient,
        _logger = logger;

  @override
  Future<Iterable<FetchReelsDto>> fetchReels(
      {required DateTime beforeAt, int limit = 5}) async {
    try {
      _logger.d('fetch reels request beforeAt:$beforeAt limit : $limit');
      return await _supabaseClient.rest
          .from(Tables.reels.name)
          .select("*,author:${Tables.accounts.name}(id, username, avatar_url)")
          .lt('created_at', beforeAt.toUtc().toIso8601String())
          .limit(limit)
          .then((res) => res.map((json) => FetchReelsDto.fromJson(json)));
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> createReels(CreateReelsDto dto) async {
    try {
      return await _supabaseClient.rest.from(Tables.reels.name).insert(dto
          .copyWith(
              created_by: dto.created_by.isNotEmpty
                  ? dto.created_by
                  : _supabaseClient.auth.currentUser!.id,
              created_at: dto.created_at.isNotEmpty
                  ? dto.created_at
                  : DateTime.now().toUtc().toIso8601String())
          .toJson());
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> editReels(EditReelsDto dto) async {
    try {
      _logger.d('edit reels request ${dto.id}');
      await _supabaseClient.rest.from(Tables.feeds.name).update({
        if (dto.media != null) 'media': dto.media,
        if (dto.caption != null) 'caption': dto.caption,
        'updated_at': DateTime.now().toUtc().toIso8601String()
      }).eq('id', dto.id);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> deleteReelsById(String reelsId) async {
    try {
      _logger.d('delete reels request $reelsId');
      await _supabaseClient.rest
          .from(Tables.reels.name)
          .delete()
          .eq('id', reelsId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }
}
