import 'package:flutter/material.dart';
import 'package:flutter_app/create_media/constant/constant.dart';
import 'package:flutter_app/create_media/presentation/pages/create_feed/create_feed.page.dart';
import 'package:flutter_app/feed/feed.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../shared/shared.export.dart';
import '../../bloc/base/create_media.cubit.dart';
import '../create_reels/create_reels.page.dart';

part 'create_media.screen.dart';

part 'select_mode_button.widget.dart';

part 'create_media_success.screen.dart';

part 'un_authorized.screen.dart';

class CreateMediaPage extends StatefulWidget {
  const CreateMediaPage({super.key});

  @override
  State<CreateMediaPage> createState() => _CreateMediaPageState();
}

class _CreateMediaPageState extends State<CreateMediaPage> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CreateMediaCubit>().askPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMediaCubit, CreateMediaState>(
        builder: (context, state) {
      if (!state.mounted) {
        return const Center(child: CircularProgressIndicator());
      } else if (!state.isAuth) {
        return const UnAuthorizedScreen();
      } else if (state.step == CreateMediaStep.done) {
        return const CreateMediaSuccessScreen();
      } else {
        return const CreateMediaScreen();
      }
    });
  }
}
