import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/domain/entity/export.entity.dart';
import 'package:my_app/presentation/bloc/export.bloc.dart';

@lazySingleton
class RouterRefreshListenable extends ValueNotifier<UserEntity?> {
  final AuthBloc _authBloc;

  RouterRefreshListenable(this._authBloc) : super(null) {
    _authBloc.authStream.listen((user) {
      value = user;
    });
  }
}
