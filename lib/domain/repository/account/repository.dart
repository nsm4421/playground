import 'package:injectable/injectable.dart';
import 'package:travel/core/response/response_wrapper.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/data/datasource/account/datasource.dart';

part  'repository_impl.dart';

abstract interface class AccountRepository {
  Future<bool> getIsUsernameDuplicated(String username);
}