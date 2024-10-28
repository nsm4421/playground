import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/domain/entity/meeting/meeting.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../repository/meeting/repository.dart';

part 'scenario/crud.dart';

part 'scenario/channel.dart';

class MeetingUseCase {
  final MeetingRepository _repository;

  MeetingUseCase(this._repository);

  GetMeetingChannelUseCase get channel => GetMeetingChannelUseCase(_repository);

  CreateMeetingUseCase get create => CreateMeetingUseCase(_repository);

  ModifyMeetingUseCase get modify => ModifyMeetingUseCase(_repository);

  FetchMeetingUseCase get fetch => FetchMeetingUseCase(_repository);

  SearchMeetingUseCase get search => SearchMeetingUseCase(_repository);

  DeleteMeetingUseCase get delete => DeleteMeetingUseCase(_repository);
}
