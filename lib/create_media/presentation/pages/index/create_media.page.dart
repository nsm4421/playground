import 'package:flutter/material.dart';
import 'package:flutter_app/create_media/constant/constant.dart';
import 'package:flutter_app/create_media/presentation/pages/create_feed/create_feed.page.dart';
import 'package:flutter_app/create_media/presentation/pages/create_reels/create_reels.page.dart';
import 'package:flutter_app/feed/feed.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/shared.export.dart';
import '../../bloc/base/create_media.cubit.dart';

part 'create_media.screen.dart';

part 'select_mode_button.widget.dart';

part 'create_media_success.screen.dart';

class CreateMediaPage extends StatelessWidget {
  const CreateMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMediaCubit, CreateMediaState>(
        builder: (context, state) {
      return state.step == CreateMediaStep.done
          ? const CreateMediaSuccessScreen()
          : const CreateMediaScreen();
    });
  }
}
