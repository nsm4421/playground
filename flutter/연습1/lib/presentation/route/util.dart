import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/bloc/module.dart';

@lazySingleton
class AuthStateNotifier extends ChangeNotifier{
  final BlocModule _blocModule;

  AuthStateNotifier(this._blocModule) {
    _blocModule.auth.authStateStream.listen((data) {
      notifyListeners();
    });
  }
}
