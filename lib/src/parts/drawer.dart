import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/api/Api.dart';
import 'package:places_autocomplete/src/screens/LandingPage.dart';
import 'package:places_autocomplete/src/screens/login/Signin.dart';
import 'package:places_autocomplete/src/screens/routes/ViewRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('PAATHAI APP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      )),
                  ClipOval(
                    child: Image.asset(
                      'assets/images/1.jpeg',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.people, color: kPrimaryGreenColor),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.timeline, color: kPrimaryGreenColor),
              title: Text('Routes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewRoutes()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.business, color: kPrimaryGreenColor),
              title: Text('Cities'),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddRoute()),
                // );
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.directions_bus_sharp, color: kPrimaryGreenColor),
              title: Text('Busses'),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddRoute()),
                // );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded, color: kPrimaryGreenColor),
              title: Text('Logout'),
              onTap: () async {
                _handleLogout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
    try {
      var data = {};
      var res = await CallApi().postData(data, 'logout');
      var body = json.decode(res.body);
      print(body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      localStorage.remove('userId');
      print("logged out.");
    } catch (e) {
      print(e);
    }
  }
}
