part of 'router.dart';

// 인증상태 변경 시 redirect 시키기 위해 notifier class를 만듬
@lazySingleton
class AuthStateNotifier extends ChangeNotifier {
  final BlocModule _blocModule;

  AuthStateNotifier(this._blocModule) {
    _blocModule.auth.authStateStream.listen((data) {
      notifyListeners();
    });
  }
}
