import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/constant.dart';

part 'datasource_impl.dart';

abstract interface class AccountDataSource {
  Future<bool> isUsernameDuplicated(String username);
}
