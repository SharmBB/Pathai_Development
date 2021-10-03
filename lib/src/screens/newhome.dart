import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/api/api.dart';
import 'package:places_autocomplete/src/screens/add_marker_screen.dart';
import 'package:places_autocomplete/src/screens/home_screen.dart';
import 'package:places_autocomplete/src/screens/options.dart';

class NewHome extends StatefulWidget {
  const NewHome({key}) : super(key: key);

  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
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
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  bool startPointCheck = false;

  TextEditingController _busRouteController = new TextEditingController();
  TextEditingController _busNoController = new TextEditingController();

  DateTime getTime = DateTime.now().add(new Duration(minutes: 15));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: Container(
              child: Form(
                key: formKey,
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
                            'Start Point',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                startPointCheck = true;
                                print(startPointCheck);
                              });
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
                      SizedBox(
                        height: 20,
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
                      SizedBox(
                        height: 20,
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
                                child: Text("Insert"),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
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
                    showModalBottomSheet(context, item['index']);
                  },
                  child: item['time'] == null
                      ? Text("00:00")
                      : Text(item['time'].toString())
                  // child: Text(
                  //   '${DateFormat.Hm().format(getTime)}',
                  //   style: TextStyle(fontSize: 15.0),
                  // ),
                  ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    reload = true;
                  });
                  latlonFromMap
                      .removeWhere((element) => element['lat'] == item['lat']);
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
      _apiGetPoints();
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  void _apiGetPoints() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var addRoute = {
        "name": _busRouteController.text,
        "number": _busNoController.text,
      };

      var body;
      print("body");
      print(latlonFromMap);
      if (latlonFromMap.length != 0) {
        for (var data in latlonFromMap) {
          print(data);
          var addPoints = {
            "name": "manipaynew",
            "time": data['time'],
            "latitude": data['lat'],
            "longitude": data['long'],
            "route_id": 2, // this would be dynamic - after routes added ID automatically need to assign
          };
          var res = await CallApi().postPoints(addPoints, 'addPoint');
          body = json.decode(res.body);
          
        }
        if(body['errorMessage'] == false){
            scaffoldKey.currentState.showSnackBar(
               SnackBar(
                content: Text("${body['message']}", style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.green,
              ),
            );
          }
        latlonFromMap.clear();
        _busRouteController.clear();
        _busNoController.clear();
      }
      print(body);

      // if (body['token'] != null) {
      //   SharedPreferences localStorage = await SharedPreferences.getInstance();
      //   var token = body['token'];
      //   localStorage.setString('token', token);
      //   print(body);
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (BuildContext context) => MainMenu()),
      //   );
      // } else {
      //   print(body['error']);
      // }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void showModalBottomSheet(ctx, index) {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
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
          builder: (context) => GoogleMapScreen(),
        ));
    print(startPointCheck);
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
}
