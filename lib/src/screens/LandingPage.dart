import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/api/Api.dart';
import 'package:places_autocomplete/src/parts/DashboardCard.dart';
import 'package:places_autocomplete/src/parts/Drawer.dart';
import 'package:places_autocomplete/src/screens/routes/ViewRoutes.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String finalRoutes;
  bool loaderRoutes = false;

  @override
  void initState() {
    _apiGetRoutes();
    super.initState();
  }

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
              DashboardCard(
                  title: "Users",
                  numbers: "45",
                  secondText: "Text",
                  thirdText: "More Text",
                  buttonText: "New  Users",
                  buttonFunction: () {}),
              DashboardCard(
                  title: "Routes",
                  numbers: loaderRoutes ? "-" : finalRoutes,
                  secondText: "Text",
                  thirdText: "More Text",
                  buttonText: "New  Route",
                  buttonFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewRoutes()),
                    );
                  }),
              DashboardCard(
                  title: "Cities",
                  numbers: "45",
                  secondText: "Text",
                  thirdText: "More Text",
                  buttonText: "New  City",
                  buttonFunction: () {}),
              DashboardCard(
                  title: "Bussess",
                  numbers: "45",
                  secondText: "Text",
                  thirdText: "More Text",
                  buttonText: "New  Bus",
                  buttonFunction: () {})
            ],
          )),
    );
  }

  // get Routes number
  void _apiGetRoutes() async {
    setState(() {
      loaderRoutes = true;
    });
    try {
      var res = await CallApi().getRoutes('getRoutes');
      finalRoutes = json.decode(res.body).length.toString();
    } catch (e) {
      print(e);
    }
    setState(() {
      loaderRoutes = false;
    });
  }
}
