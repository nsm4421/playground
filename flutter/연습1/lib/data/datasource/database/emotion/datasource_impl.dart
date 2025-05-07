part of 'datasource.dart';

class EmotionDataSourceImpl with CustomLogger implements EmotionDataSource {
  final SupabaseClient _supabaseClient;

  EmotionDataSourceImpl(this._supabaseClient);

  String get _table => Tables.emotions.name;

  @override
  Future<void> edit(EditEmotionDto dto) async {
    await _supabaseClient.rest
        .from(_table)
        .upsert({
          ...dto.toJson(),
          'created_at': now,
          'created_by': _supabaseClient.auth.currentUser!.id
        })
        .eq('reference_id', dto.reference_id)
        .eq('reference_table', dto.reference_table);
  }

  @override
  Future<void> delete(DeleteEmotionDto dto) async {
    await _supabaseClient.rest
        .from(_table)
        .delete()
        .eq('reference_id', dto.reference_id)
        .eq('reference_table', dto.reference_table);
  }
}
