part of '../usecase.dart';

class FetchMeetingUseCase {
  final MeetingRepository _repository;

  FetchMeetingUseCase(this._repository);

  Future<Either<ErrorResponse, List<MeetingEntity>>> call(String beforeAt,
      {int take = 20}) async {
    return await _repository.fetch(beforeAt, take: take).then((res) =>
        res.mapLeft((l) => l.copyWith(message: 'fail to fetch meeting')));
  }
}

class CreateMeetingUseCase {
  final MeetingRepository _repository;

  CreateMeetingUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String country,
      String? city,
      required DateTime startDate,
      required DateTime endDate,
      int headCount = 2,
      required TravelPeopleSexType sex,
      required TravelThemeType theme,
      int minCost = 0,
      int maxCost = 500,
      required String title,
      required String content,
      required List<String> hashtags,
      File? thumbnail}) async {
    return await _repository
        .edit(
            country: country,
            city: city,
            startDate: startDate,
            endDate: endDate,
            headCount: headCount,
            sex: sex,
            theme: theme,
            minCost: minCost,
            maxCost: maxCost,
            title: title,
            content: content,
            hashtags: hashtags,
            thumbnail: thumbnail)
        .then((res) =>
            res.mapLeft((l) => l.copyWith(message: 'fail to create meeting')));
  }
}

class ModifyMeetingUseCase {
  final MeetingRepository _repository;

  ModifyMeetingUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String id,
      required String country,
      String? city,
      required DateTime startDate,
      required DateTime endDate,
      int headCount = 2,
      required TravelPeopleSexType sex,
      required TravelThemeType theme,
      int minCost = 0,
      int maxCost = 500,
      required String title,
      required String content,
      required List<String> hashtags,
      File? thumbnail}) async {
    return await _repository
        .edit(
            id: id,
            update: true,
            country: country,
            city: city,
            startDate: startDate,
            endDate: endDate,
            headCount: headCount,
            sex: sex,
            theme: theme,
            minCost: minCost,
            maxCost: maxCost,
            title: title,
            content: content,
            hashtags: hashtags,
            thumbnail: thumbnail)
        .then((res) =>
            res.mapLeft((l) => l.copyWith(message: 'fail to modify meeting')));
  }
}

class DeleteMeetingUseCase {
  final MeetingRepository _repository;

  DeleteMeetingUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String id) async {
    return await _repository.deleteById(id).then((res) =>
        res.mapLeft((l) => l.copyWith(message: 'fail to delete meeting')));
  }
}
