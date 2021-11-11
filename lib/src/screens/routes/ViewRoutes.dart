import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/api/api.dart';
import 'package:places_autocomplete/src/parts/ReminderAlertBox.dart';
import 'package:places_autocomplete/src/parts/RoutesCard.dart';
import 'package:places_autocomplete/src/parts/YesOrNoDialogBox.dart';
import 'package:places_autocomplete/src/screens/routes/AddRoute.dart';
import 'package:places_autocomplete/src/screens/routes/UpdateRoute.dart';

class ViewRoutes extends StatefulWidget {
  ViewRoutes({Key key}) : super(key: key);

  @override
  _ViewRoutesState createState() => _ViewRoutesState();
}

class _ViewRoutesState extends State<ViewRoutes> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // This list holds the data for the list view
  List<dynamic> _foundUsers = [];
  List _RoutesFromDB = [];
  @override
  initState() {
    _apiGetRoutes();
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = _RoutesFromDB[0];
    } else {
      results = _RoutesFromDB[0].where((user) {
        return user["name"].toLowerCase().contains(enteredKeyword.toLowerCase())
            ? true
            : false;
      }).toList();
    }

    setState(() {
      _foundUsers = results;
      // print(_foundUsers);
    });
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
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        ReminderAlertBox(onPressedYes: () {
                          Navigator.pop(context);
                          // deleteRoutes(_RoutesFromDB[0][index]['id']);
                        }));
              },
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
                    onChanged: (value) => _runFilter(value),
                    // onChanged : (value) {
                    //   print(value);
                    // },
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
                    ? _RoutesFromDB[0].length == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text("No routes available"),
                          )
                        : Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 80),
                              child: ListView.builder(
                                itemCount: _foundUsers.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 1.0),
                                  child: CustomRoutesCard(
                                    valueKey: _RoutesFromDB[0][index]["id"],
                                    title: _foundUsers[index]["name"],
                                    length: "length",
                                    time: "time",
                                    busFee: "busFee",
                                    busNumber:
                                        _foundUsers[index]['number'].toString(),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                YesOrNoDialogBox(
                                                    onPressedYes: () {
                                                  Navigator.pop(context);
                                                  deleteRoutes(_RoutesFromDB[0]
                                                      [index]['id']);
                                                }));
                                      } else if (value == 2) {
                                        //pass the Id to update route page
                                        _navigatorUpdateRoute(
                                            context,
                                            UpdateRoute(
                                                idForGetRoute:
                                                    _foundUsers[index]['id']));
                                      }
                                    },
                                  ),
                                ),
                              ),
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
                    bottom: 15,
                  ),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: width * 0.9, height: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        // _apiGetRoutes();
                        _navigatorAddRoute(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => AddRoute()),
                        // );
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

  void _apiGetRoutes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _RoutesFromDB.clear();
      var bodyRoutes;
      var res = await CallApi().getRoutes('getRoutes');
      bodyRoutes = json.decode(res.body);

      // Add routes to _RoutesFromDB List
      // print("---------");
      _RoutesFromDB.add(bodyRoutes);
      _foundUsers = _RoutesFromDB[0];
      // print(_RoutesFromDB[0]);
      // print("---------");
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void deleteRoutes(id) async {
    try {
      var deleteRoute = {"id": id};
      var bodyRoutes;
      var res = await CallApi().deleteRoutes(deleteRoute, 'deleteRouteAdmin');
      bodyRoutes = json.decode(res.body);
      // print(bodyRoutes);

      if (bodyRoutes['errorMessage'] == false) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              "${bodyRoutes['message']}",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
        _apiGetRoutes();
      }
    } catch (e) {
      print(e);
    }
  }

  void _navigatorAddRoute(BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddRoute()));
    _apiGetRoutes();
  }

  void _navigatorUpdateRoute(BuildContext context, updateRoute) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => updateRoute));
    _apiGetRoutes();
  }
}
