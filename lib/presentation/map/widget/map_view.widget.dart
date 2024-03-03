import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewWidget extends StatefulWidget {
  const MapViewWidget(
      {super.key,
      required this.initialLatitude,
      required this.initialLongitude});

  final double initialLatitude;
  final double initialLongitude;

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  GoogleMapController? _controller;

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          _controller = controller;
        },
        onLongPress: (LatLng location) {},
        myLocationEnabled: false,
        initialCameraPosition: CameraPosition(
            zoom: 15,
            target: LatLng(widget.initialLatitude, widget.initialLongitude)),
      ),
    );
  }
}
