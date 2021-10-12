import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/screens/LandingPage.dart';
import 'package:places_autocomplete/src/screens/routes/AddRoute.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric( vertical: 20, horizontal: 20),
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
              leading: Icon(Icons.people,color: kPrimaryGreenColor),
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
              leading: Icon(Icons.timeline,color: kPrimaryGreenColor),
              title: Text('Routes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddRoute()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.business,color: kPrimaryGreenColor),
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
              leading: Icon(Icons.directions_bus_sharp,color: kPrimaryGreenColor),
              title: Text('Busses'),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddRoute()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}