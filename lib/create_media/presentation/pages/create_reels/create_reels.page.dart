import 'package:flutter/material.dart';
import 'package:flutter_app/create_media/presentation/bloc/create_reels/create_reels.bloc.dart';
import 'package:flutter_app/create_media/presentation/widgets/video_thumbnail.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

import '../../../../shared/shared.export.dart';
import '../../../constant/constant.dart';
import '../../bloc/base/create_media.cubit.dart';
import '../../widgets/select_directory.fragment.dart';

part 'select_video.screen.dart';

part 'display_current_album.widget.dart';

part 'detail.screen.dart';

class CreateReelsPage extends StatelessWidget {
  const CreateReelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<CreateReelsBloc>()..add(FetchAlbumsEvent()),
        child: BlocBuilder<CreateReelsBloc, CreateReelsState>(
            builder: (context, state) {
          return switch (state.step) {
            CreateMediaStep.selectMedia => const SelectVideoScreen(),
            CreateMediaStep.detail => const DetailScreen(),
            _ => const Center(child: CircularProgressIndicator())
          };
        }));
  }
}
