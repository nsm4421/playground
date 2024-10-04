part of 'router.dart';

// 인증상태 변경 시 redirect 시키기 위해 notifier class를 만듬
class AuthStateNotifier extends ChangeNotifier {
  final Stream<PresenceEntity?> _authStream;

  AuthStateNotifier(this._authStream) {
    _authStream.listen((data) {
      notifyListeners();
    });
  }
}
