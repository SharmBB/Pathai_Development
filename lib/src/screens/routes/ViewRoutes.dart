import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/api/api.dart';
import 'package:places_autocomplete/src/screens/routes/AddRoute.dart';

class JRoute extends StatefulWidget {
  JRoute({Key key}) : super(key: key);

  @override
  _JRouteState createState() => _JRouteState();
}

class _JRouteState extends State<JRoute> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  List _RoutesFromDB = [];
  @override
  initState() {
    _apiGetPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        key: _scaffoldKey,
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
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications_rounded, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
          backgroundColor: kPrimaryGreenColor,
          elevation: 0,
        ),
        body: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(
                          color: kPrimaryGreenColor,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(20.0),
                      filled: true,
                      hintText: 'Search Places',
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                !_isLoading
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 90),
                          child: ListView.builder(
                              itemCount: _RoutesFromDB[0].length,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 1.0),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        // key: ValueKey(_foundUsers[index]["id"]),
                                        // color: Colors.amberAccent,
                                        elevation: 0,
                                        //    margin: EdgeInsets.symmetric(vertical: 10),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            bottom: 10.0,
                                          ),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                // leading: Text(
                                                //   _foundUsers[index]["id"].toString(),
                                                //   style: TextStyle(fontSize: 24),
                                                // ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10.0,
                                                                  top: 10.0),
                                                          child: Text(
                                                              "${_RoutesFromDB[0][index]['name']}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      PopupMenuButton<int>(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        15.0))),
                                                        itemBuilder:
                                                            (context) => [
                                                          PopupMenuItem(
                                                            value: 1,
                                                            child:
                                                                Text("Delete"),
                                                          ),
                                                          PopupMenuDivider(),
                                                          PopupMenuItem(
                                                            value: 2,
                                                            child: Text("Edit"),
                                                          ),
                                                        ],
                                                        onCanceled: () {
                                                          print(
                                                              "You have canceled the menu.");
                                                        },
                                                        onSelected: (value) {
                                                          if (value == 1) {
                                                            _valueFromDelete(context);

                                                          } else if (value ==
                                                              2) {
                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //       builder: (context) =>
                                                            //           EditRoute(
                                                            //               title:
                                                            //                   '')),
                                                            // );
                                                          }
                                                        },
                                                        icon: Icon(
                                                            Icons.more_horiz),
                                                      ),
                                                    ]),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    'Length : ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                    )),
                                                                Text(
                                                                  '${"title"} Km',
                                                                ),
                                                              ]),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                              child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'Time : ',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                                    Text(
                                                                        '${"title"} h'),
                                                                  ])),
                                                        ]),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('Bus Fee : ',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                              Text(
                                                                  '${"title"} Rs'),
                                                            ]),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0),
                                                            child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'Bus Number : ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      )),
                                                                  Text(
                                                                      '${_RoutesFromDB[0][index]['number']} '),
                                                                ])),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        )),
                                  )),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: CupertinoActivityIndicator(),
                      ),
              ],
            ),
          ),
          SafeArea(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: width * 0.9, height: 60),
                    child: ElevatedButton(
                      onPressed: () {
                        // _apiGetPoints();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddRoute()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New Routes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryGreenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ]));
  }

  AlertDialog dialog(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: EdgeInsets.zero,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
            padding: const EdgeInsets.only(
                bottom: 10.0, top: 30.0, left: 20.0, right: 20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Delete Route?',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context, 'Yes');
                        },
                        child: const Text(
                          'Yes',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ))
            ])),
        Align(
            alignment: Alignment.bottomLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 400, height: 60),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => JRoute()),
                  // );
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            )),
      ]),
    );
  }

  void _apiGetPoints() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var bodyRoutes;
      var res = await CallApi().getRoutes('getRoutes');
      bodyRoutes = json.decode(res.body);

      // Add routes to _RoutesFromDB List
      print("---------");
      _RoutesFromDB.add(bodyRoutes);
      // print(_RoutesFromDB);
      print("---------");
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _valueFromDelete(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await showDialog<String>(
        context: context, builder: (BuildContext context) => dialog(context));
    print(result);
  }
}
