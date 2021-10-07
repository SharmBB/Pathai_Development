// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:places_autocomplete/Utils/Constraints.dart';

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:places_autocomplete/src/screens/add_marker_screen.dart';
// import 'package:places_autocomplete/src/screens/home_screen.dart';
// import 'package:places_autocomplete/src/screens/route_add.dart';

// class Options extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<Options> {
//   bool button1, button2;



//   @override
//   void initState() {
//     button1 = false;
//     button2 = false;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () { },
//           ),
//           leadingWidth: 70,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.circle, color: Colors.white),
//               onPressed: () { },
//             ),
//             IconButton(
//               icon: Icon(Icons.notifications_rounded, color: Colors.white),
//               onPressed: () { },
//             ),
//             IconButton(
//               icon: Icon(Icons.settings, color: Colors.white),
//               onPressed: () { },
//             ),
//           ],
//           backgroundColor: kPrimaryGreenColor,
//           elevation: 0,
//         ),
     
//         //   automaticallyImplyLeading: false,
//         //   title: Text("Flutter Sharing File"),
//         //   centerTitle: true,
//         // ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Align(
//                   alignment: Alignment.topCenter,
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 50,
//                     ),
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints.tightFor(
//                           width: width * 0.9, height: 60),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => GoogleMapScreen()),
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Add Location By Add Marker',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           primary: kPrimaryGreenColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.03,
//               ),
//               Align(
//                   alignment: Alignment.topCenter,
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 50,
//                     ),
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints.tightFor(
//                           width: width * 0.9, height: 60),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //       builder: (context) => HomeScreen()),
//                           // );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Add Location By Search',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           primary: kPrimaryGreenColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )),
//             ],
//           ),
//         ));
//   }
// }
