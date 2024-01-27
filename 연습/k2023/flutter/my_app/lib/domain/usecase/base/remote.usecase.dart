import 'package:my_app/domain/repository/repository.dart';

abstract class RemoteUseCase<T extends Repository>{
  Future call(T repository);
}