import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hot_place/data/entity/geo/load_address/load_address.entity.dart';
import 'package:hot_place/presentation/geo/bloc/address/address.bloc.dart';
import 'package:hot_place/presentation/geo/bloc/address/address.event.dart';
import 'package:hot_place/presentation/geo/bloc/address/address.state.dart';
import 'package:hot_place/presentation/geo/widget/geo_appbar.widget.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';

class GeoScreen extends StatelessWidget {
  const GeoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<AddressBloc>()..add(InitAddressEvent()),
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (_, state) {
            if (state is InitialAddressState || state is AddressLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LocationFetchedState) {
              return Scaffold(
                appBar: GeoAppBarWidget(state.address),
                body: _View(position: state.position, address: state.address),
              );
            } else {
              return const Center(child: Text("ERROR"));
            }
          },
        ));
  }
}

class _View extends StatefulWidget {
  const _View({required this.position, this.address});

  final Position position;
  final LoadAddressEntity? address;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  Set<Marker> _markes = {};
  late GoogleMapController _googleMapController;

  @override
  void initState() {
    super.initState();
    final currentMarker = Marker(
      markerId: const MarkerId('current-location'),
      position: LatLng(widget.position.latitude, widget.position.longitude),
      infoWindow: InfoWindow(
        title: context.read<UserBloc>().state.user.nickname ?? '현재사용자',
        snippet: widget.address?.addressName ?? '현재위치',
      ),
    );
    _markes.add(currentMarker);
  }

  @override
  void dispose() {
    super.dispose();
    _googleMapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.terrain,
      onMapCreated: (controller) {
        _googleMapController = controller;
      },
      initialCameraPosition: CameraPosition(
          zoom: 15,
          target: LatLng(widget.position.latitude, widget.position.longitude)),
      markers: _markes,
    );
  }
}
