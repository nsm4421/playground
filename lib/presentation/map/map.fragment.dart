import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/presentation/map/bloc/map/map.event.dart';
import '../../core/constant/route.constant.dart';
import 'bloc/map/map.bloc.dart';

class MapFragment extends StatelessWidget {
  const MapFragment({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocProvider(
        create: (context) =>
        getIt<MapBloc>()
          ..add(InitMap()),
        child: Scaffold(
          appBar: AppBar(title: Text("Map")),
          body: ElevatedButton(onPressed: () {
            context.push(Routes.searchByCategory.path);
          }, child: Text("test"),),
        ),
      );
}

