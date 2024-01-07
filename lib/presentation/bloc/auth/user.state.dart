import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/enums/status.enum.dart';
import 'package:my_app/core/response/error_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(AuthStatus.initial) AuthStatus authStatus,
    @Default(Status.initial) Status status,
    User? user,
    @Default(ErrorResponse()) error,
  }) = _UserState;
}
