import '../../repository/user.repository.dart';

class AllUserStream {
  final UserRepository repository;

  AllUserStream(this.repository);

  Future<void> call() async => repository.allUserStream();
}
