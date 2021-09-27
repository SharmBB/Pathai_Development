import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_autocomplete/src/blocs/application_bloc.dart';
import 'package:places_autocomplete/src/models/place.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final startAddressController = TextEditingController();
  Geolocator _geolocator = Geolocator();
  String latitude = "";
  String longitude = "";
  String address = "";
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  StreamSubscription boundsSubscription;
  final _locationController = TextEditingController();
  var test = 'sharmilan';

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
      } else
        _locationController.text = "";
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
  }

 
  Future<bool>  getAddressFromLatLng() async {
    try{
      
    print("jitnhu");

    List<Location> locations = await locationFromAddress(_startAddress);
    print(locations);
    // String kPLACES_API_KEY = "AIzaSyDM8U1e_9FPJqaCu4Vv0YrMxj6vqEyWyiA";
    // String _host = 'https://maps.google.com/maps/api/geocode/json';
    // final url = '$_host?key=$kPLACES_API_KEY&language=en&latlng=$lat,$lng';
    // if (lat != null && lng != null) {
    //   var response = await http.get(Uri.parse(url));
    //   if (response.statusCode == 200) {
    //     Map data = jsonDecode(response.body);
    //     String _formattedAddress = data["results"][0]["formatted_address"];
    //     print("response ==== $_formattedAddress");
    //     return _formattedAddress;
    //   } else
    //     return null;
    // } else
    //   return null;
      } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();

    _locationController.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    super.dispose();
  }

  String _startAddress = '';

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
        body: (applicationBloc.currentLocation == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          controller: _locationController,
                          textCapitalization: TextCapitalization.words,
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue.shade300,
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            hintText: 'Search Your Location',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.my_location),
                              onPressed: () {},
                            ),
                          ),
                          onChanged: (value) => {
                                setState(() {
                                  _startAddress = value;

                                  applicationBloc.searchPlaces(value);
                                })
                              }
                          //   onTap: () => applicationBloc.clearSelectedLocation(),
                          ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 500.0,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                applicationBloc.currentLocation.latitude,
                                applicationBloc.currentLocation.longitude),
                            zoom: 7,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                          },
                          markers: Set<Marker>.of(applicationBloc.markers),
                        ),
                      ),
                      if (applicationBloc.searchResults != null &&
                          applicationBloc.searchResults.length != 0)
                        Container(
                            height: 300.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.6),
                                backgroundBlendMode: BlendMode.darken)),
                      if (applicationBloc.searchResults != null)
                        Container(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: applicationBloc.searchResults.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    applicationBloc
                                        .searchResults[index].description,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    getAddressFromLatLng();
                                    applicationBloc.setCurrentLocation();
                                    print(applicationBloc.setCurrentLocation());
                                    print("sacAAAAAAAAAAA");

                                    applicationBloc.setSelectedLocation(
                                        applicationBloc
                                            .searchResults[index].placeId);
                                  },
                                );
                              }),
                        ),
                    ],
                  ),
                ],
              ));
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }
}
