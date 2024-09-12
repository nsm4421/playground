part of 'router.dart';

@lazySingleton
class AuthStateNotifier extends ChangeNotifier {
  final AuthenticationBloc _authBloc;

  AuthStateNotifier(this._authBloc) {
    _authBloc.userStream.listen((data) {
      notifyListeners();
    });
  }
}
