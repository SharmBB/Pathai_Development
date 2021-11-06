import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final numbers;
  final String secondText;
  final String thirdText;
  final String buttonText;
  final Function buttonFunction;
  const DashboardCard({
    Key key, @required this.title,  @required this.numbers,  @required this.secondText,  @required this.thirdText,  @required this.buttonText,  @required this.buttonFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.people,
                              color: kPrimaryGreenColor,
                              size: 40,
                            ),
                            onPressed: () {},
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, bottom: 0),
                              child: Text(title, style: cardTitle)),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 25, left: 10, right: 10),
                          child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(numbers,
                                      style: cardNumberText),
                                ),
                                Container(
                                  child: Text(secondText,
                                      style: cardSubTitle),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                      thirdText.toUpperCase(),
                                      style: cardMoreText),
                                ),
                              ])),
                    ])),
            Align(
                alignment: Alignment.bottomLeft,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: 200, height: 50),
                  child: ElevatedButton(
                    onPressed: buttonFunction,
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryGreenColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      )),
                    ),
                  ),
                )),
          ],
        ));
  }
}