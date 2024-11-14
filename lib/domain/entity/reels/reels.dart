import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/domain/entity/auth/presence.dart';

class ReelsEntity extends BaseEntity {
  final String video;
  final String? caption;
  final PresenceEntity author;

  ReelsEntity(
      {super.id,
      super.createdAt,
      super.updatedAt,
      required this.video,
      this.caption,
      required this.author});
}
