import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portfolio/core/dependency_injection/configure_dependencies.dart';
import 'package:portfolio/presentation/bloc/travel/recommend/recommend_travel.cubit.dart';
import 'package:portfolio/presentation/bloc/travel/travel.bloc_module.dart';
import 'package:portfolio/presentation/pages/main/components/error.screen.dart';
import 'package:portfolio/presentation/pages/main/components/loading.screen.dart';
import 'package:country_picker/country_picker.dart';

import '../../../../core/constant/status.dart';
import '../../../../core/constant/travel_constant.dart';

part "recommend_itinerary.screen.dart";

part 'searched_itinerary.screen.dart';

class RecommendItineraryPage extends StatelessWidget {
  const RecommendItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<TravelBlocModule>().recommend,
        child: BlocBuilder<RecommendItineraryCubit, RecommendItineraryState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
                return const RecommendItineraryScreen();
              case Status.success:
                return const SearchedItineraryScreen();
              case Status.loading:
                return const LoadingScreen();
              case Status.error:
                return const ErrorScreen();
            }
          },
        ));
  }
}
