import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/bloc/search_bloc.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/domain/entity/feed/feed.dart';
import 'package:travel/presentation/bloc/bottom_nav/cubit.dart';
import 'package:travel/presentation/bloc/feed/search/bloc.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/widget/widget.dart';

part 's_search.dart';

part 'f_searched.dart';

part 'w_option.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().searchFeed
        ..add(FetchEvent<FeedEntity, SearchFeedOption>()),
      child: BlocListener<SearchFeedBloc,
          CustomSearchState<FeedEntity, SearchFeedOption>>(
        listener: (context, state) async {
          if (state.status == Status.error) {
            getIt<CustomSnackBar>()
                .error(title: 'Error', description: state.errorMessage);
            await Future.delayed(
              300.ms,
              () {
                context.read<SearchFeedBloc>().add(
                    InitSearchEvent(status: Status.initial, errorMessage: ''));
              },
            );
          }
        },
        child: BlocBuilder<SearchFeedBloc,
            CustomSearchState<FeedEntity, SearchFeedOption>>(
          builder: (context, state) {
            return LoadingOverLayWidget(
              isLoading: state.status == Status.loading ||
                  state.status == Status.error,
              loadingWidget: const Center(child: CircularProgressIndicator()),
              childWidget: const SearchScreen(),
            );
          },
        ),
      ),
    );
  }
}
