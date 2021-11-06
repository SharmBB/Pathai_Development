import 'package:flutter/material.dart';

class CustomRoutesCard extends StatelessWidget {
  final int valueKey;
  final String title;
  final String length;
  final String time;
  final String busFee;
  final String busNumber;
  final Function onSelected;
  const CustomRoutesCard({Key key, @required this.valueKey,@required  this.title,@required  this.length,@required  this.time,@required  this.busFee,@required  this.busNumber,@required  this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      key: ValueKey(valueKey),
      // color: Colors.amberAccent,
      elevation: 0,
      //    margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 10.0,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // leading: Text(
              //   _foundUsers[index]["id"].toString(),
              //   style: TextStyle(fontSize: 24),
              // ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Text(title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold))),
                PopupMenuButton<int>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text("Delete"),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      value: 2,
                      child: Text("Edit"),
                    ),
                  ],
                  onCanceled: () {
                    print("You have canceled the menu.");
                  },
                  onSelected: onSelected,
                  // (value) {
                  //   if (value == 1) {
                  //     showDialog<String>(
                  //         context: context,
                  //         builder: (BuildContext context) =>
                  //             dialog(context, _RoutesFromDB[0][index]['id']));
                  //     // print(result);

                  //   } else if (value == 2) {
                  //     //pass the Id to update route page
                  //     UpdateRoute(idForGetRoute: _RoutesFromDB[0][index]['id']);
                  //     _navigatorUpdateRoute(
                  //         context,
                  //         UpdateRoute(
                  //             idForGetRoute: _RoutesFromDB[0][index]['id']));

                  //     // print(_RoutesFromDB[0][index]);
                  //   }
                  // },
                  icon: Icon(Icons.more_horiz),
                ),
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Length : ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )),
                              Text(
                                '$length Km',
                              ),
                            ]),
                        Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Time : ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )),
                                  Text('$time h'),
                                ])),
                      ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bus Fee : ',
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                            Text('$busFee Rs'),
                          ]),
                      Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bus Number : ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    )),
                                Text(busNumber),
                              ])),
                    ],
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
