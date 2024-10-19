import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/util.dart';

import '../../../bloc/bloc_module.dart';
import '../../../bloc/meeting/create/create_meeting.cubit.dart';
import '../../../widgets/widgets.dart';

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
        child: BlocListener<CreateMeetingCubit, CreateMeetingState>(
          listener: (BuildContext context, CreateMeetingState state) {
            if (state.status == Status.success) {
              customUtil.showSuccessSnackBar(
                  context: context, message: 'Success');
              context.pop();
            } else if (state.status == Status.error) {
              customUtil.showErrorSnackBar(
                  context: context, message: state.errorMessage);
              Timer(const Duration(seconds: 1), () {
                context
                    .read<CreateMeetingCubit>()
                    .updateState(status: Status.initial, errorMessage: '');
              });
            }
          },
          child: BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
            builder: (context, state) {
              return LoadingOverLayScreen(
                  isLoading: state.status == Status.loading,
                  loadingWidget:
                      const Center(child: CircularProgressIndicator()),
                  childWidget: const CreateMeetingScreen());
            },
          ),
        ));
  }
}
