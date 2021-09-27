


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/screens/add_marker_screen.dart';
import 'package:places_autocomplete/src/screens/home_screen.dart';
import 'package:places_autocomplete/src/screens/options.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
 
  TextEditingController _nameController;
  String _selectedTime;
  String _selectedTime1;

  Future<void> _show() async {
    final TimeOfDay result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  Future<void> _show1() async {
    final TimeOfDay result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime1 = result.format(context);
      });
    }
  }

  static List<String> friendsList = [null];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  DateTime selectedDay = DateTime.now();
  String selectedDayCollection = DateTime.now().toString();
  DateTime getTimeCollection = DateTime.now();
  DateTime getTime = DateTime.now().add(new Duration(minutes: 15));

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
          leadingWidth: 70,
          actions: [
            IconButton(
              icon: Icon(Icons.circle, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications_rounded, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ],
          backgroundColor: kPrimaryGreenColor,
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Form(
          
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name textfield
                  Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: new InputDecoration(
                          filled: true,
                          hintText: "Enter the Bus Number",
                          fillColor: Colors.grey[100],
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: InputBorder.none,
                          errorStyle: TextStyle(color: kPrimaryGreenColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: kPrimaryGreenColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: kPrimaryGreenColor,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: kPrimaryGreenColor,
                              width: 2,
                            ),
                          ),
                          //focusedBorder: InputBorder.none,
                          //fillColor: Colors.blueAccent[500],
                          //filled: true,
                        ),
                        validator: (v) {
                          if (v.trim().isEmpty) return ' enter bus number';
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: new InputDecoration(
                        filled: true,
                        hintText: "Enter the Route",
                        fillColor: Colors.grey[100],
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: InputBorder.none,
                        errorStyle: TextStyle(color: kPrimaryGreenColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: kPrimaryGreenColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: kPrimaryGreenColor,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: kPrimaryGreenColor,
                            width: 2,
                          ),
                        ),
                        //focusedBorder: InputBorder.none,
                        //fillColor: Colors.blueAccent[500],
                        //filled: true,
                      ),
                      validator: (v) {
                        if (v.trim().isEmpty) return ' enter route';
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          flex: 1,
                          child: TextField(
                            decoration: new InputDecoration(
                              filled: true,
                              hintText: "Enter the Starting Route",
                              fillColor: Colors.grey[100],
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: InputBorder.none,
                              errorStyle: TextStyle(color: kPrimaryGreenColor),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  color: kPrimaryGreenColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  color: kPrimaryGreenColor,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  color: kPrimaryGreenColor,
                                  width: 2,
                                ),
                              ),
                              //focusedBorder: InputBorder.none,
                              //fillColor: Colors.blueAccent[500],
                              //filled: true,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        _timePicker(
                          context,
                        )
                      ],
                    ),
                  ),

                  // Padding(
                  //     padding: const EdgeInsets.only(left: 60.0, top: 20),
                  //     child: SizedBox.fromSize(
                  //       size: Size(56, 56), // button width and height
                  //       child: ClipOval(
                  //         child: Material(
                  //           color: Colors.grey, // button color
                  //           child: InkWell(
                  //             splashColor: Colors.green, // splash color
                  //             onTap: () {
                  //               _show();
                  //             }, // button pressed
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: <Widget>[
                  //                 Icon(Icons.timer), // icon
                  //                 Text("Time"), // text
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )),

                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        // optional flex property if flex is 1 because the default flex is 1
                        flex: 1,
                        child: TextField(
                          decoration: new InputDecoration(
                            filled: true,
                            hintText: "Enter the Ending Route",
                            fillColor: Colors.grey[100],
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: InputBorder.none,
                            errorStyle: TextStyle(color: kPrimaryGreenColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: kPrimaryGreenColor,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: kPrimaryGreenColor,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: kPrimaryGreenColor,
                                width: 2,
                              ),
                            ),
                            //focusedBorder: InputBorder.none,
                            //fillColor: Colors.blueAccent[500],
                            //filled: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      _timePicker(
                        context,
                      )
                    ],
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Additional Routes',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  ..._getFriends(),
                  // SizedBox(
                  //   height: 40,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 90.0),
                  //   child: FlatButton(
                  //     onPressed: () {
                  //       if (_formKey.currentState.validate()) {
                  //         _formKey.currentState.save();
                  //       }
                  //     },
                  //     child: Text('Save Routes'),
                  //     color: Colors.greenAccent,
                  //   ),
                  // ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: width * 0.9, height: 60),
                          child: ElevatedButton(
                            onPressed: () {
                              //   if (_formKey.currentState!.validate()) {}
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Save Routes',
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
                      )
                      ),
                ],
              ),
            ),
          ),
        ));
  }

  Column _timePicker(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              //  margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration:
                  BoxDecoration(border: Border.all(color: kPrimaryGreenColor)),
              child: Text("Select time", style: TextStyle(fontSize: 18.0)),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text(
                '(${DateFormat.Hm().format(getTime)})',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    builder: (BuildContext context) {
                      return Container(
                        height: 300,
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
                                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                                    // prefs.setString('selectedTime','(${DateFormat.Hm().format(_dateTime)})');
                                    print(DateFormat.Hm().format(getTime));
                                    getTimeCollection = getTime;
                                    // getTime = '(${DateFormat.Hm().format(getTime)})';
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
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ],
    );
  }

  /// get firends text-fields
  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(i)),
            SizedBox(
              width: 16,
            ),
            //Text("data"),
            // we need add button at last friends row
            _addRemoveButton(i == friendsList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Options()),
          );
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, null);
          print("object");
        } else
          friendsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.greenAccent,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  String _selectedTime;

  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  String _selectedTime3;

  // CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  String selectedDayCollection = DateTime.now().toString();
  DateTime getTimeCollection = DateTime.now();
  DateTime getTime = DateTime.now().add(new Duration(minutes: 15));
  Future<void> _show3() async {
    final TimeOfDay result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime3 = result.format(context);
      });
    }
  }

  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _MyFormState.friendsList[widget.index] ?? '';
    });

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            // optional flex property if flex is 1 because the default flex is 1
            flex: 1,
            child: TextField(
              decoration: new InputDecoration(
                filled: true,
                hintText: "Enter the Additional  Route",
                fillColor: Colors.grey[100],
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                border: InputBorder.none,
                errorStyle: TextStyle(color: kPrimaryGreenColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: kPrimaryGreenColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: kPrimaryGreenColor,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: kPrimaryGreenColor,
                    width: 2,
                  ),
                ),
                //focusedBorder: InputBorder.none,
                //fillColor: Colors.blueAccent[500],
                //filled: true,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          _timePicker(
            context,
          )
        ]);
  }

  Column _timePicker(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Select time", style: TextStyle(fontSize: 18.0)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text(
                '(${DateFormat.Hm().format(getTime)})',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    builder: (BuildContext context) {
                      return Container(
                        height: 300,
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
                                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                                    // prefs.setString('selectedTime','(${DateFormat.Hm().format(_dateTime)})');
                                    print(DateFormat.Hm().format(getTime));
                                    getTimeCollection = getTime;
                                    // getTime = '(${DateFormat.Hm().format(getTime)})';
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
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ],
    );
  }
}
