import 'package:supabase_flutter/supabase_flutter.dart';

part 'datasource_impl.dart';

abstract interface class AccountDataSource {
  Future<bool> isUsernameDuplicated(String username);
}
