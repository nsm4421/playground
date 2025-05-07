import '../../repository/repository.dart';

abstract class UseCase<T extends Repository> {
  Future call(T repository);
}
