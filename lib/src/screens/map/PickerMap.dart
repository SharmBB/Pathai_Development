import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/screens/routes/AddRoute.dart';

class PickerMap extends StatefulWidget {
  @override
  _PickerMapState createState() => _PickerMapState();
}

class _PickerMapState extends State<PickerMap> {
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
              Navigator.pop(context);
            },
          ),
          leadingWidth: 70,
          actions: [
            IconButton(
              icon: Icon(Icons.circle, color: Colors.white),
              onPressed: () { },
            ),
            IconButton(
              icon: Icon(Icons.notifications_rounded, color: Colors.white),
              onPressed: () { },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () { },
            ),
          ],
          backgroundColor: kPrimaryGreenColor,
          elevation: 0,
        ),
      
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
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
            SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: RaisedButton(
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: kPrimaryGreenColor,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.white,
                onPressed: (latfromMap != null)
                                  ? () async {
                                      _sendDataBack(context);
                                    }
                                  : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Add Points')
                    ],
                  ),
                ),
              ),
            ),
          ),
              ),
          ],
        ),
      ),
    );
  }

  void _sendDataBack(BuildContext context) {
    // Navigator.pop(context, textToSendBack);
    Navigator.pop(context, {"lat" : latfromMap , "lon" : lonfromMap});
  }
}
