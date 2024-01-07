import '../../repository/base.repository.dart';

abstract class BaseUseCase<T extends Repository> {
  Future call(T repository);
}