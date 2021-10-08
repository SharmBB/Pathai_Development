import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/screens/routes/AddRoute.dart';

class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _active = false;
  bool _active2 = false;
  bool _active3 = false;
  bool _active4 = false;

  void _handleTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddRoute()),
    );
    setState(() {
      _active = !_active;
    });
  }

  void _handleTap2() {
    setState(() {
      _active2 = !_active2;
    });
  }

  void _handleTap3() {
    setState(() {
      _active3 = !_active3;
    });
  }

  void _handleTap4() {
    setState(() {
      _active4 = !_active4;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
        width: width * 0.7,
        child: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('PAATHAI APP',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    )),
                ClipOval(
                  child: Image.asset(
                    'assets/images/1.jpeg',
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                ),
              ],
            ),
          ),
          Container(
              color: _active ? kPrimarylightGreenColor : Colors.transparent,
              child: ListTile(
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  minLeadingWidth: 50,
                  leading: Icon(Icons.people),
                  title: Text('Dashboard',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      )),
                  onTap: () {
                    _handleTap();
                  })),
          Container(
              color: _active2 ? kPrimarylightGreenColor : Colors.transparent,
              child: ListTile(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                minLeadingWidth: 50,
                leading: Icon(Icons.directions),
                title: Text('Routes',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    )),
                onTap: _handleTap2,
              )),
          Container(
              color: _active3 ? kPrimarylightGreenColor : Colors.transparent,
              child: ListTile(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                minLeadingWidth: 50,
                leading: Icon(Icons.business),
                title: Text('Cities',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    )),
                onTap: _handleTap3,
              )),
          Container(
              color: _active4 ? kPrimarylightGreenColor : Colors.transparent,
              child: ListTile(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                minLeadingWidth: 50,
                leading: Icon(Icons.directions_bus_sharp),
                title: Text('Busses',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    )),
                onTap: _handleTap4,
              )),
        ])));
  }
}
