import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/screens/newhome.dart';
import 'package:places_autocomplete/src/screens/options.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(28.535517, 77.391029);

  //List<MapMarker> mapMarkers = [];
  List<Marker> customMarkers = [];

  double latfromMap ;
  double lonfromMap ;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              _sendDataBack(context);
            },
          ),
          leadingWidth: 70,
          actions: [
            IconButton(
              icon: Icon(Icons.circle, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Options()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications_rounded, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Options()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewHome()),
                );
              },
            ),
          ],
          backgroundColor: kPrimaryGreenColor,
          elevation: 0,
        ),
      
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
            latfromMap = latLng.latitude;
            lonfromMap = latLng.longitude;
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

  void _sendDataBack(BuildContext context) {
    // Navigator.pop(context, textToSendBack);
    Navigator.pop(context, {"lat" : latfromMap , "lon" : lonfromMap});
  }
}