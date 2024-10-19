import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/domain/entity/meeting/meeting.dart';
import 'package:travel/presentation/bloc/bloc_module.dart';
import 'package:travel/presentation/bloc/meeting/display/display_meeting.bloc.dart';

import '../../../route/router.dart';
import '../../../widgets/widgets.dart';

part 's_meeting.dart';

part 'f_appbar.dart';

part 'f_meetings.dart';

part 'w_meeting_item.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().displayMeeting
        ..add(FetchMeetingEvent(refresh: true)),
      child: BlocBuilder<DisplayMeetingBloc, CustomDisplayState<MeetingEntity>>(
          builder: (context, state) {
        return LoadingOverLayScreen(
            isLoading: state.status == Status.loading,
            loadingWidget: const Center(child: CircularProgressIndicator()),
            childWidget: const DisplayMeetingScreen());
      }),
    );
  }
}
