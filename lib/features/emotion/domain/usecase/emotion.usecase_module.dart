import 'package:injectable/injectable.dart';
import 'package:portfolio/features/emotion/data/repository_impl/emotion.repository_impl.dart';

@lazySingleton
class EmotionUseCase {
  final EmotionRepository _repository;

  EmotionUseCase(this._repository);
}
