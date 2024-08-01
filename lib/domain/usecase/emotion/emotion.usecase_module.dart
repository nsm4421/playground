import 'package:injectable/injectable.dart';
import 'package:portfolio/core/constant/emotion_type.dart';
import 'package:portfolio/domain/entity/emotion/emotion.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../../core/constant/supabase_constant.dart';
import '../../../data/repository_impl/emotion/emotion.repository_impl.dart';

part "scenario/like_on_feed.usecase.dart";

part "scenario/cancel_like_on_feed.usecase.dart";

part "scenario/get_emotion_channel.usecase.dart";

@lazySingleton
class EmotionUseCase {
  final EmotionRepository _repository;

  EmotionUseCase(this._repository);

  GetEmotionChannelUseCase get emotionChannel =>
      GetEmotionChannelUseCase(_repository);

  LikeOnFeedUseCase get likeFeed => LikeOnFeedUseCase(_repository);

  CancelLikeOnFeedUseCase get cancelLikeFeed =>
      CancelLikeOnFeedUseCase(_repository);
}
