import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(28.535517, 77.391029);

  //List<MapMarker> mapMarkers = [];
  List<Marker> customMarkers = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GoogleMap(
          onTap: (LatLng latLng) {
            Marker firsrMarker = Marker(
              markerId: MarkerId('SomeId'),
              position: LatLng(latLng.latitude, latLng.longitude),
              infoWindow: InfoWindow(title: 'The title of the marker'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
            );
            customMarkers.add(firsrMarker);
            //  id=id+1;
            setState(() {});

            print("Our Lattitute and Longitute is $latLng ");
          },
          onMapCreated: _onMapCreated,
          markers: customMarkers.toSet(),
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 10.0,
          ),
        ),
      ),
    );
  }
}
