import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/dependency_injection/configure_dependencies.dart';
import 'package:portfolio/core/route/router.dart';
import 'package:portfolio/core/util/date.util.dart';
import 'package:portfolio/domain/entity/feed/feed.entity.dart';
import 'package:portfolio/presentation/bloc/auth/auth.bloc.dart';
import 'package:portfolio/presentation/bloc/feed/display/feed/display_feed.bloc.dart';
import 'package:portfolio/presentation/bloc/feed/feed.bloc_module.dart';
import 'package:portfolio/presentation/pages/main/components/hashtags.widget.dart';

import '../../../../../core/constant/status.dart';

part "display_feed.screen.dart";

part "display_media.widget.dart";

part "feed_list.fragment.dart";

part "feed_item.widget.dart";

part "fetch_more_button.widget.dart";

class DisplayFeedPage extends StatelessWidget {
  const DisplayFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            getIt<FeedBlocModule>().displayFeed..add(FetchFeedEvent()),
        child: const DisplayFeedScreen());
  }
}
