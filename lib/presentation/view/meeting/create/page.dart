import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/presentation/bloc/bloc_module.dart';
import 'package:travel/presentation/bloc/meeting/create_meeting.cubit.dart';
import 'package:travel/presentation/bloc/meeting/create_meeting.state.dart';
import 'package:travel/presentation/view/diary/display/page.dart';
import 'package:travel/presentation/widgets/widgets.dart';

part 's_create_meeting.dart';

part 'f_select_country.dart';

part 'f_select_date.dart';

part 'f_select_preference.dart';

part 'f_select_budget.dart';

part 'f_detail.dart';

part 'f_hashtag.dart';

part 'f_select_thumbnail.dart';

class CreateMeetingPage extends StatelessWidget {
  const CreateMeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<BlocModule>().createMeeting,
        child: const CreateMeetingScreen());
  }
}
