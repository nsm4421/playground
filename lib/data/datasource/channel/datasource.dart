import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/constant.dart';

part 'datasource_impl.dart';

abstract interface class ChannelDataSource {
  RealtimeChannel getChannelOnInsert(
      {required String key,
      required Tables table,
      required void Function(PostgresChangePayload) onInsert});

  RealtimeChannel getMeetingChannel(
      {required void Function(PostgresChangePayload p) onInsert,
      required void Function(PostgresChangePayload p) onDelete});
}
