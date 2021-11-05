import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/api/api.dart';
import 'package:places_autocomplete/src/screens/map/PickerMap.dart';
import 'package:places_autocomplete/src/screens/map/SearchMap.dart';

class UpdateRoute extends StatefulWidget {
  final int idForGetRoute;
  const UpdateRoute({key, @required this.idForGetRoute}) : super(key: key);

  @override
  _UpdateRouteState createState() => _UpdateRouteState();
}

class _UpdateRouteState extends State<UpdateRoute> {
  List latlonFromMap = [];
  bool reload = false;
  bool _isLoading = false;
  double latfromMap = null;
  double lonfromMap = null;
  var timefromMap = null;
  bool _loader = false;
  String busRoute;
  int busNo;
  bool _validate = false;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  TextEditingController _busRouteController = new TextEditingController();
  TextEditingController _busNoController = new TextEditingController();

  DateTime getTime = DateTime.now().add(new Duration(minutes: 15));

  //update new variables.
  int idForGetRoute;
  var _RoutesFromDB;
  List _PointsFromDB = [];

  @override
  void initState() {
    idForGetRoute = widget.idForGetRoute;
    print(idForGetRoute);
    _apiGetRoutes();
    _apiGetPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              autovalidate: _validate,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    busRouteInput(),
                    SizedBox(
                      height: 20,
                    ),
                    busNoInput(),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text(
                          'Additional Routes',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _showMyDialog();
                          },
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    latlonFromMap.length >= 2
                        ? Text("")
                        : Text(
                            '*Minimum 2 (Start & End) points required',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    reload
                        ? Text(" ")
                        : Column(
                            children: [
                              for (var item in latlonFromMap)
                                latLonListView(item),
                            ],
                          ),
                    Center(
                      child: _isLoading
                          ? CupertinoActivityIndicator()
                          : RaisedButton(
                              color: kPrimaryGreenColor,
                              textColor: Colors.white,
                              onPressed: () {
                                onClick();
                              },
                              child: Text("Add Routes"),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  latLonListView(item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Text(item.toString(),),
          Row(
            children: [
              Text(item['lat'].toStringAsFixed(7) +
                  " , " +
                  item['long'].toStringAsFixed(7)),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    showModalForTime(context, item['index']);
                  },
                  child: item['time'] == null
                      ? Text("00:00")
                      : Text(item['time'].toString())
                  // child: Text(
                  //   '${DateFormat.Hm().format(getTime)}',
                  //   style: TextStyle(fontSize: 15.0),
                  // ),
                  ),
              // Spacer(),
              SizedBox(width: 50),
              GestureDetector(
                onTap: () {
                  setState(() {
                    reload = true;
                  });
                  deletePoints(item['id']);
                  print(item);
                  latlonFromMap.removeWhere((element) => element['lat'] == item['lat']);
                  // latlonFromMap.removeAt(item['index']-1);
                  // print(latlonFromMap[0]);
                  setState(() {
                    reload = false;
                  });
                },
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField busRouteInput() {
    return TextFormField(
      
      decoration: new InputDecoration(
        filled: true,
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryGreenColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryGreenColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        hintText: "Enter the bus route",
      ),
      // textInputAction: TextInputAction.next,
      controller: _busRouteController,
      validator: (val) => val.isEmpty ? 'Bus Route Required' : null,
      // onSaved: (val) => busRoute = val,
    );
  }

  TextFormField busNoInput() {
    return TextFormField(
      decoration: new InputDecoration(
        filled: true,
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryGreenColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryGreenColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        hintText: "Enter the bus number",
      ),
      // textInputAction: TextInputAction.next,
      controller: _busNoController,
      validator: (val) => val.isEmpty ? 'Bus Number Required' : null,
      // onSaved: (val) => busNo = val,
    );
  }

  onClick() async {
    if (formKey.currentState.validate()) {
      // print("validated");
      // print(
      //     " BusRoute : ${_busRouteController.text}, BusNo : ${_busNoController.text}");
      // print(latlonFromMap);
      _apiUpdatePoints();
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  // get routes from DB
  _apiGetRoutes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var bodyRoutes;
      var res = await CallApi().getRoutes('getRouteById/$idForGetRoute');
      bodyRoutes = json.decode(res.body);

      // Add routes to _RoutesFromDB List
      print("---------");
      _RoutesFromDB = bodyRoutes;
      _busRouteController.text = _RoutesFromDB['name'];
      _busNoController.text = _RoutesFromDB['number'].toString();
      print("---------");
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  // get Points by route ID from DB
  _apiGetPoints() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var bodyRoutes;
      var res = await CallApi().getRoutes('getPointsByRouteId/$idForGetRoute');
      bodyRoutes = json.decode(res.body);

      // Add routes to _RoutesFromDB List
      print("---------");
      print(bodyRoutes);
      _PointsFromDB.add(bodyRoutes);
      print("---------------------");
      // print(_PointsFromDB[0]);
      print(_PointsFromDB[0].length);
      for (var i = 0; i < _PointsFromDB[0].length; i++) {
        // print(i);
        setState(() {
          latlonFromMap.add({
            "id" : _PointsFromDB[0][i]['id'],
            "index": latlonFromMap.length + 1,
            "lat": _PointsFromDB[0][i]['latitude'],
            "long": _PointsFromDB[0][i]['longitude'],
            "time": timefromMap
          });
        });
      }
      print(latlonFromMap);
      // _RoutesFromDB = bodyRoutes;
      // _busRouteController.text = _RoutesFromDB['name'];
      // _busNoController.text = _RoutesFromDB['number'].toString();
      print("---------");
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void deletePoints(id) async {
    try {
      var deleteRoute = {
          "id": id
      };
      var deletePoints;
      var res = await CallApi().deleteRoutes(deleteRoute, 'deletePointById');
      deletePoints = json.decode(res.body);
      print(deletePoints);

          if(deletePoints['errorMessage'] == false){
              _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(
                  "${deletePoints['message']}",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            //  _apiGetPoints();
          }

    } catch (e) {
      print(e);
    }
  }

  void _apiUpdatePoints() async {
    setState(() {
      _isLoading = true;
    });
    try {


      var bodyRoutes;
      var bodyPoints;
      print("body");

      if (latlonFromMap.length >= 2) {
        var addRoute = {
          "id": idForGetRoute,
          "name": _busRouteController.text,
          "number": _busNoController.text,
        };

        var res = await CallApi().updateRoutes(addRoute, 'updateRoute');
        bodyRoutes = json.decode(res.body);
        print(bodyRoutes);

        for (var data in latlonFromMap) {
          print(data);
          print(data['id'] == null);
          if(data['id'] == null){
            var addPoints = {
              "name": "J to USA",
              "time": data['time'],
              "latitude": data['lat'],
              "longitude": data['long'],
              "route_id": idForGetRoute,  // this would be dynamic - after routes added ID automatically need to assign
            };

            var res = await CallApi().postPoints(addPoints, 'addPoint');
            bodyPoints = json.decode(res.body);
          }
        }

        if (bodyPoints['errorMessage'] == false) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(
                "${bodyPoints['message']}",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
        // latlonFromMap.clear();
        // _busRouteController.clear();
        // _busNoController.clear();
      }
      print(bodyPoints);

    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void showModalForTime(ctx, index) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Row(
                  children: [
                    CupertinoButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          getTime = DateTime.now();
                        });
                        Navigator.pop(context);
                      },
                    ),
                    Spacer(),
                    CupertinoButton(
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        print(DateFormat.Hm().format(getTime));
                        print(index);
                        // getTimeCollection = getTime;
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                        use24hFormat: true,
                        initialDateTime: getTime,
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            getTime = dateTime;
                            latlonFromMap[index - 1]['time'] =
                                DateFormat.Hm().format(getTime).toString();
                            print(latlonFromMap);
                            print(DateFormat.Hm().format(getTime).toString());
                            // print(latlonFromMap[0]['time']);
                            // for (var item in latlonFromMap) print(item['index']);
                          });
                        }),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _awaitReturnValueFromSecondScreen(context);
                  },
                  child: Text("Add Location By Add Marker"),
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _awaitReturnValueFromSearchMap(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeScreen()),
                    // );
                  },
                  child: Text("Add Location By Search"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PickerMap(),
        ));
    print(result);
    if (result['lat'] != null) {
      setState(() {
        latfromMap = result['lat'];
        lonfromMap = result['lon'];
        latlonFromMap.add({
          "index": latlonFromMap.length + 1,
          "lat": latfromMap,
          "long": lonfromMap,
          "time": timefromMap
        });
      });
    }
    // close the popup
    Navigator.of(context).pop();
    print(latlonFromMap);
  }

  void _awaitReturnValueFromSearchMap(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchMap(),
        )
        );
    print("result");
    print(result);
    if (result['lat'] != null) {
      setState(() {
        latfromMap = result['lat'];
        lonfromMap = result['lon'];
        latlonFromMap.add({
          "index": latlonFromMap.length + 1,
          "lat": latfromMap,
          "long": lonfromMap,
          "time": timefromMap
        });
      });
    }
    // close the popup
    Navigator.of(context).pop();
    print(latlonFromMap);
  }

  void _sendRefresh(BuildContext context) {
    Navigator.pop(context, "textToSendBack01");
    // Navigator.pop(context, {"lat" : latfromMap , "lon" : lonfromMap});
  }
}
