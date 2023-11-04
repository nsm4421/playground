import 'package:my_app/data/dto/story/story.dto.dart';
import 'package:my_app/data/mapper/user_mapper.dart';

import '../../domain/model/story/story.model.dart';

extension StorydtoEx on StoryDto {
  StoryModel toModel() =>
      StoryModel(user: user?.toModel(), content: content, imageUrls: imageUrls);
}
