import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/data/model/registration/fetch_registrations.dart';

import '../../../core/constant/constant.dart';
import '../../../core/util/util.dart';

part 'datsource_impl.dart';

abstract interface class RegistrationDataSource {
  Future<Iterable<FetchRegistrationsModel>> fetch(String meetingId);

  Future<String> create({required String meetingId, required String introduce});

  Future<void> update({required String registrationId, required bool isPermitted});

  Future<void> deleteByMeetingId(String meetingId);
}
