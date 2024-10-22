import 'package:either_dart/either.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../entity/comment/comment.dart';
import '../../repository/comment/repository.dart';

part 'scenario/meeting.dart';

class CommentUseCase {
  final CommentRepository _repository;

  CommentUseCase(this._repository);

  CreateMeetingCommentUseCase get createMeetingComment =>
      CreateMeetingCommentUseCase(_repository);

  ModifyMeetingCommentUseCase get modifyMeetingComment =>
      ModifyMeetingCommentUseCase(_repository);

  DeleteMeetingCommentUseCase get deleteMeetingComment =>
      DeleteMeetingCommentUseCase(_repository);

  FetchMeetingCommentUseCase get fetchMeetingComment =>
      FetchMeetingCommentUseCase(_repository);
}
