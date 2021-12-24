import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';

class ReminderAlertBox extends StatelessWidget {
  final Function onPressedYes;
  const ReminderAlertBox({Key key, @required this.onPressedYes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: new Text(
        "Getting Off",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          color: kPrimaryGreenColor,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
            padding: const EdgeInsets.only(
                bottom: 10.0, top: 30.0, left: 20.0, right: 20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Your are arriving your destination \n in 5 Mins.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[],
                  ))
            ])),
        Align(
            alignment: Alignment.bottomLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 400, height: 60),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Okay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            )),
      ]),
    );
  }
}
