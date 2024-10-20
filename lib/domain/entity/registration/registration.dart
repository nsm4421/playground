import '../../../core/constant/constant.dart';
import '../../../data/model/registration/fetch_registrations.dart';
import '../auth/presence.dart';

class RegistrationEntity extends BaseEntity {
  final String? meetingId;
  final PresenceEntity? manager;
  final PresenceEntity? proposer;
  final bool? isPermitted;
  final String? introduce;

  RegistrationEntity(
      {super.id,
      super.createdAt,
      super.updatedAt,
      super.createdBy,
      this.meetingId,
      this.manager,
      this.proposer,
      this.isPermitted,
      this.introduce});

  factory RegistrationEntity.from(FetchRegistrationsModel model) {
    return RegistrationEntity(
        id: model.id,
        createdAt: DateTime.tryParse(model.created_at),
        updatedAt: null,
        createdBy: model.created_by,
        meetingId: model.meeting_id,
        manager: model.manager_id.isEmpty
            ? null
            : PresenceEntity(
                uid: model.manager_id,
                username: model.manager_username,
                avatarUrl: model.manager_avatar_url),
        proposer: model.proposer_id.isEmpty
            ? null
            : PresenceEntity(
                uid: model.proposer_id,
                username: model.proposer_username,
                avatarUrl: model.proposer_avatar_url),
        isPermitted: model.is_permitted,
        introduce: model.introduce.isNotEmpty ? model.introduce : null);
  }
}
