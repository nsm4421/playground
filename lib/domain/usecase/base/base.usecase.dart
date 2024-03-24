import 'package:hot_place/domain/repository/base/base.repository.dart';

abstract class BaseUseCase<T extends BaseRepository> {
  Future call(T repository);
}
