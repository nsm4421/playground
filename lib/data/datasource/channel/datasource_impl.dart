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

  @override
  RealtimeChannel getMeetingChannel(
      {required void Function(PostgresChangePayload p) onInsert,
      required void Function(PostgresChangePayload p) onDelete}) {
    final key = Channels.meeting.name;
    return _supabaseClient
        .channel(key, opts: RealtimeChannelConfig(key: key))
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: Tables.meeting.name,
            callback: onInsert)
        .onPostgresChanges(
            event: PostgresChangeEvent.delete,
            schema: 'public',
            table: Tables.meeting.name,
            callback: onDelete);
  }
}
