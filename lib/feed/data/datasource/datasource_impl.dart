import 'package:flutter_app/feed/data/dto/create_feed.dto.dart';
import 'package:flutter_app/feed/data/dto/fetch_feed.dto.dart';
import 'package:flutter_app/feed/data/dto/fetch_feed_by_rpc.dto.dart';
import 'package:flutter_app/shared/constant/constant.export.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../dto/edit_feed.dto.dart';

part 'datasource.dart';

class FeedDataSourceImpl extends FeedDataSource {
  final SupabaseClient _supabaseClient;
  final Logger _logger;

  FeedDataSourceImpl(
      {required SupabaseClient supabaseClient, required Logger logger})
      : _supabaseClient = supabaseClient,
        _logger = logger;

  @override
  Future<Iterable<FetchFeedDto>> fetchFeeds(
      {required DateTime beforeAt, int limit = 20}) async {
    try {
      _logger.d('fetch feed request beforeAt:$beforeAt limit : $limit');
      return await _supabaseClient.rest
          .from(Tables.feeds.name)
          .select("*,author:${Tables.accounts.name}(id, username, avatar_url)")
          .lt('created_at', beforeAt.toUtc().toIso8601String()) // 내림차순
          .limit(limit)
          .order('created_at', ascending: false)
          .then((res) => res.map((json) => FetchFeedDto.fromJson(json)));
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<Iterable<FetchFeedByRpcDto>> fetchFeedsByRPC(
      {required DateTime beforeAt, int take = 20}) async {
    try {
      _logger.d('fetch feed request by rpc beforeAt:$beforeAt limit : $take');
      return await _supabaseClient.rpc<List<Map<String, dynamic>>>(
          RpcFunctions.fetchFeeds.name,
          params: {
            'before_at': beforeAt.toUtc().toIso8601String(),
            'take': take
          }).then((res) => res.map((FetchFeedByRpcDto.fromJson)));
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> createFeed(CreateFeedDto dto) async {
    try {
      _logger.d('create feed request ${dto.id}');
      await _supabaseClient.rest.from(Tables.feeds.name).insert(dto
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
  Future<void> editFeed(EditFeedDto dto) async {
    try {
      _logger.d('edit feed request ${dto.id}');
      await _supabaseClient.rest.from(Tables.feeds.name).update({
        if (dto.media != null) 'media': dto.media,
        if (dto.caption != null) 'caption': dto.caption,
        if (dto.hashtags != null) 'hashtags': dto.hashtags,
        'updated_at': DateTime.now().toUtc().toIso8601String()
      }).eq('id', dto.id);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> deleteFeedById(String feedId) async {
    try {
      _logger.d('delete feed request $feedId');
      await _supabaseClient.rest
          .from(Tables.feeds.name)
          .delete()
          .eq('id', feedId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }
}
