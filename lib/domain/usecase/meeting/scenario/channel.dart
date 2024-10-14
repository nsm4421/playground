part of '../usecase.dart';

class GetMeetingChannelUseCase {
  final MeetingRepository _repository;

  GetMeetingChannelUseCase(this._repository);

  Future<RealtimeChannel> call(
      {required void Function(Map<String, dynamic> newRecord) onInsert,
      required void Function(Map<String, dynamic> oldRecord) onDelete}) async {
    return _repository.getMeetingChannel(
        onInsert: onInsert, onDelete: onDelete);
  }
}
