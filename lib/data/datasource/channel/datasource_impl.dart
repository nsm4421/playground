part of 'datasource.dart';

class ChannelDataSourceImpl implements ChannelDataSource {
  final SupabaseClient _supabaseClient;

  ChannelDataSourceImpl(this._supabaseClient);

  @override
  RealtimeChannel getChannelOnInsert(
      {required String key,
      required Tables table,
      required void Function(PostgresChangePayload p1) onInsert}) {
    return _supabaseClient
        .channel(key, opts: RealtimeChannelConfig(key: key))
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: table.name,
            callback: onInsert);
  }
}
