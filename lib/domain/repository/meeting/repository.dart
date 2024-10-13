import 'dart:io';

import 'package:either_dart/either.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../../core/util/util.dart';
import '../../../data/datasource/meeting/datasource.dart';
import '../../../data/datasource/storage/datasource.dart';
import '../../../data/model/meeting/edit_meeting.dart';
import '../../entity/meeting/meeting.dart';

part 'repository_impl.dart';

abstract interface class MeetingRepository {
  Future<Either<ErrorResponse, Iterable<MeetingEntity>>> fetch(String beforeAt,
      {int take = 20});

  // create -> id = null  /  update = false
  // update -> update = true
  Future<Either<ErrorResponse, void>> edit(
      {String? id,
      bool update = false,
      required String country,
      String? city,
      required DateTime startDate,
      required DateTime endDate,
      int headCount = 2,
      required TravelPeopleSexType sex,
      required TravelPreferenceType preference,
      int minCost = 0,
      int maxCost = 500,
      required String title,
      required String content,
      required List<String> hashtags,
      required List<File> images});

  Future<Either<ErrorResponse, void>> deleteById(String id);
}
