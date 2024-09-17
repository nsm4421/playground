import 'package:flutter_app/like/data/dto/send_like.dto.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

part 'datasource.dart';

class LikeDataSourceImpl extends LikeDataSource {
  final SupabaseClient _supabaseClient;
  final Logger _logger;

  LikeDataSourceImpl(
      {required SupabaseClient supabaseClient, required Logger logger})
      : _supabaseClient = supabaseClient,
        _logger = logger;

  @override
  Future<String> sendLike(SendLikeDto dto) async {
    try {
      final likeId = dto.id.isNotEmpty ? dto.id : const Uuid().v4();
      _logger.d('like request id:${likeId} table:${dto.reference_table.name}');
      return await _supabaseClient.rest
          .from(Tables.likes.name)
          .insert(dto.copyWith(id: likeId).toJson())
          .then((_) => likeId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> cancelLike(
      {required String referenceId, required Tables referenceTable}) async {
    try {
      _logger.d(
          'cancel like request id:$referenceId reference table:${referenceTable.name}');
      await _supabaseClient.rest
          .from(referenceTable.name)
          .delete()
          .eq('reference_id', referenceId)
          .eq('reference_table', referenceTable.name);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> cancelLikeById(String likeId) async {
    try {
      _logger.d('cancel like by id request like id :$likeId');
      await _supabaseClient.rest
          .from(Tables.likes.name)
          .delete()
          .eq('id', likeId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }
}
