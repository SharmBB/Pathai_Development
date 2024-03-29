import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/api/Api.dart';
import 'package:places_autocomplete/src/screens/map/PickerMap.dart';
import 'package:places_autocomplete/src/screens/map/SearchMap.dart';

class AddRoute extends StatefulWidget {
  const AddRoute({key}) : super(key: key);

  @override
  _AddRouteState createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  List latlonFromMap = [];
  bool reload = false;
  bool _isLoading = false;
  double latfromMap = null;
  double lonfromMap = null;
  var timefromMap = null;
  var pricefromMap = "";
  bool _loader = false;
  String busRoute;
  int busNo;
  bool _validate = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  TextEditingController _busRouteController = new TextEditingController();
  TextEditingController _busNoController = new TextEditingController();

  DateTime getTime = DateTime.now().add(new Duration(minutes: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _sendRefresh(context);
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
    TextEditingController _priceController = TextEditingController(text : latlonFromMap[item['index']-1]['price']) ;
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
              // Spacer(),
              SizedBox(width: 50),
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
          
          GestureDetector(
                onTap: (){ print(item); },
                child: Row(
                  children: [
                    Text("Price",style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width: 15),
                    Flexible(
                      child: TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Enter price",
                            ),
                            // textInputAction: TextInputAction.next,
                            controller: _priceController,
                            onChanged : (value) {
                              latlonFromMap[item['index']- 1]['price'] = _priceController.text;
                              print(latlonFromMap);
                            },
                          ),
                    ),
                  ],
                )
              ) ,
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


      var bodyRoutes;
      var bodyPoints;
      print("body");

      if (latlonFromMap.length >= 2) {
        var addRoute = {
          "name": _busRouteController.text,
          "number": _busNoController.text,
        };

        var res = await CallApi().postRoutes(addRoute, 'addRoute');
        bodyRoutes = json.decode(res.body);

        for (var data in latlonFromMap) {
          print(data);
          var addPoints = {
            "name": "Points${data['index']}",
            "time": data['time'],
            "price": data['price'],
            "latitude": data['lat'],
            "longitude": data['long'],
            "route_id": bodyRoutes['message']['id'],  // this would be dynamic - after routes added ID automatically need to assign
          };

          var res = await CallApi().postPoints(addPoints, 'addPoint');
          bodyPoints = json.decode(res.body);
        }

        if (bodyPoints['errorMessage'] == false) {
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(
                "${bodyPoints['message']}",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
        latlonFromMap.clear();
        _busRouteController.clear();
        _busNoController.clear();
      }
      print(bodyPoints);

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
          "time": timefromMap,
          "price": pricefromMap
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
          "time": timefromMap,
          "price": pricefromMap
        });
      });
    }
    // close the popup
    Navigator.of(context).pop();
      print(latlonFromMap);
    }

   void _sendRefresh(BuildContext context) {
    Navigator.pop(context, true);
  }

}
