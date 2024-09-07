part of 'router.dart';

class AuthStateNotifier extends ChangeNotifier {
  final Stream<User?> _userStream;

  AuthStateNotifier(this._userStream) {
    _userStream.listen((data) {
      notifyListeners();
    });
  }
}
