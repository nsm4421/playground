import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/presentation/map/bloc/map.event.dart';
import 'package:hot_place/presentation/map/bloc/map.state.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import 'bloc/map.bloc.dart';

class MapFragment extends StatelessWidget {
  const MapFragment({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<MapBloc>()..add(InitMap()),
        child: Scaffold(
          appBar: AppBar(title: Text("Map")),
          body: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
            if (!state.isPermitted) {
              return const Center(child: Text("위치권한이 허용되지 않았습니다"));
            }
            if (state.isError) {
              return const Center(child: Text("오류"));
            }
            if (state.lat == null || state.lng == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _MapView();
          }),
        ),
      );
}

class _MapView extends StatefulWidget {
  const _MapView({super.key});

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  KakaoMapController? _controller;

  _moveCenter() async {
    _controller?.setCenter(LatLng(30.450696253381196, 126.57066123419618));
  }

  @override
  void initState() {
    super.initState();
    _moveCenter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KakaoMap(
        onMapCreated: ((controller) {
          _controller = controller;
        }),
      ),
      floatingActionButton: FloatingActionButton.large(onPressed: _moveCenter),
    );
  }
}
