import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/map/widget/map_view.widget.dart';

import '../../core/di/dependency_injection.dart';
import 'bloc/map.bloc.dart';
import 'bloc/map.event.dart';
import 'bloc/map.state.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  _pop() => context.pop();

  _goToSearchPage() {}

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<MapBloc>()..add(InitMap()),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Google Map"),
              // 뒤로가기 버튼
              leading:
                  IconButton(icon: const Icon(Icons.clear), onPressed: _pop),
              actions: [
                IconButton(
                    icon: const Icon(Icons.search), onPressed: _goToSearchPage),
              ],
            ),
            body: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.isError) {
                return Center(
                    child: Text("오류",
                        style: Theme.of(context).textTheme.displayLarge));
              }
              if (state.currentLocation == null) {
                debugPrint("현재 위치정보를 조회하지 못함. 일단 우리 동네로 현재 위치 조회");
              }

              return MapViewWidget(
                  initialLatitude: 37.502,
                  // context.read<MapBloc>().state.currentLocation?.latitude!
                  initialLongitude:
                      126.947 // context.read<MapBloc>().state.currentLocation?.longitude!
                  );
            }),
          ),
        ),
      );
}
