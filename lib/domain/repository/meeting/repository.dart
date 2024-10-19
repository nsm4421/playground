import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../../core/util/util.dart';
import '../../../data/datasource/channel/datasource.dart';
import '../../../data/datasource/meeting/datasource.dart';
import '../../../data/datasource/storage/datasource.dart';
import '../../../data/model/meeting/edit_meeting.dart';
import '../../entity/meeting/meeting.dart';

part 'repository_impl.dart';

abstract interface class MeetingRepository {
  RealtimeChannel getMeetingChannel(
      {required void Function(Map<String, dynamic> newRecord) onInsert,
      required void Function(Map<String, dynamic> oldRecord) onDelete});

  Future<Either<ErrorResponse, List<MeetingEntity>>> fetch(String beforeAt,
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
      required TravelThemeType theme,
      int minCost = 0,
      int maxCost = 500,
      required String title,
      required String content,
      required List<String> hashtags,
      File? thumbnail});

  Future<Either<ErrorResponse, void>> deleteById(String id);
}
