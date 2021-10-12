import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/parts/drawer.dart';
import 'package:places_autocomplete/src/parts/drawerByKithu.dart';
import 'package:places_autocomplete/src/screens/routes/AddRoute.dart';
import 'package:places_autocomplete/src/screens/routes/ViewRoutes.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.notes, color: Colors.white),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
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
      body: new Container(
          margin: const EdgeInsets.only(
            top: 30.0,
            left: 20,
            right: 20.0,
          ),
          child: new GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 4 / 6,
            controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: <Widget>[
              Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.people,
                                        color: kPrimaryGreenColor,
                                        size: 40,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 15, bottom: 0),
                                        child: Text('Users', style: cardTitle)),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('45',
                                                style: cardNumberText),
                                          ),
                                          Container(
                                            child: Text('Text',
                                                style: cardSubTitle),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                                'More Text'.toUpperCase(),
                                                style: cardMoreText),
                                          ),
                                        ])),
                              ])),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 200, height: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => JRoute()
                                              ),
                                        );
                              },
                              child: Text(
                                'New User',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryGreenColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                )),
                              ),
                            ),
                          )),
                    ],
                  )),
              Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.timeline,
                                        color: kPrimaryGreenColor,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              // builder: (context) => MyApp()
                                              ),
                                        );
                                      },
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 15, bottom: 0),
                                        child:
                                            Text('Routes', style: cardTitle)),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('45',
                                                style: cardNumberText),
                                          ),
                                          Container(
                                            child: Text('Text',
                                                style: cardSubTitle),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                                'More Text'.toUpperCase(),
                                                style: cardMoreText),
                                          ),
                                        ])),
                              ])),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 200, height: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddRoute()),
                                );
                              },
                              child: Text(
                                'New Route',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryGreenColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                )),
                              ),
                            ),
                          )),
                    ],
                  )),
              Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.business,
                                        color: kPrimaryGreenColor,
                                        size: 40,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 15, bottom: 0),
                                        child:
                                            Text('Cities', style: cardTitle)),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('45',
                                                style: cardNumberText),
                                          ),
                                          Container(
                                            child: Text('Text',
                                                style: cardSubTitle),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                                'More Text'.toUpperCase(),
                                                style: cardMoreText),
                                          ),
                                        ])),
                              ])),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 200, height: 50),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'New City',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryGreenColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                )),
                              ),
                            ),
                          )),
                    ],
                  )),
              Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.directions_bus_sharp,
                                      color: kPrimaryGreenColor,
                                      size: 40,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 15, bottom: 0),
                                      child: Text('Busses', style: cardTitle)),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25, left: 10, right: 10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child:
                                              Text('45', style: cardNumberText),
                                        ),
                                        Container(
                                          child:
                                              Text('Text', style: cardSubTitle),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text('More Text'.toUpperCase(),
                                              style: cardMoreText),
                                        ),
                                      ])),
                            ]),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints.tightFor(width: 200, height: 50),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'New Bus',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: kPrimaryGreenColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}


