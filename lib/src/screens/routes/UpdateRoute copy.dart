import 'package:flutter/material.dart';

class UpdateRoute extends StatefulWidget {
   final int text;
  const UpdateRoute({ Key key, @required this.text }) : super(key: key);

  @override
  _UpdateRouteState createState() => _UpdateRouteState();
}

class _UpdateRouteState extends State<UpdateRoute> {

@override
  void initState() {
    print(widget.text.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Column(
          children: [
            Text("data"),
            Text(widget.text.toString()),
          ],
        ))
      ),
    );
  }
}