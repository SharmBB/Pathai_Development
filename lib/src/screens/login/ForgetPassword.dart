import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:places_autocomplete/Utils/Constraints.dart';
import 'package:places_autocomplete/src/api/Api.dart';
import 'package:places_autocomplete/src/screens/LandingPage.dart';
import 'package:places_autocomplete/src/screens/login/OtpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ForgotPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  String email, password;
  bool showPassword = true;
  bool _isLoading = false;
  bool _validate = false;
  String bodyError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: kPrimaryGreenColor),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Stack(children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        "Forget Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            autovalidate: true,
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                            offset: Offset(0, 3),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                          ),
                                          emailInput(),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          SizedBox(height: 15.0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                              ],
                            ),
                          )),
                      SafeArea(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlatButton(
                                onPressed: () async {
                                  await onClick();
                                },
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(0.0),
                                shape: CircleBorder(
                                  side: BorderSide(
                                      color: Colors.white,
                                      width: 5,
                                      style: BorderStyle.solid),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100.0)),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                      colors: [
                                        Colors.green,
                                        Colors.greenAccent,
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                  child: _isLoading
                                      ? CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.arrow_forward,
                                          size: 35.0,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ])
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailInput() {
    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return TextFormField(
      decoration: new InputDecoration(
        labelText: "Email",
        hintText: "e.g abc@gmail.com",
        labelStyle: TextStyle(fontSize: 14),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.length == 0) {
          return 'Email Required';
        } else if (!regex.hasMatch(value)) {
          return 'Enter Valid Email';
        } else {
          return null;
        }
      },
      onSaved: (String val) {
        email = val;
      },
      controller: _emailController,
    );
  }

  // onclick method to login
  onClick() async {
    if (formKey.currentState.validate()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => ForgetOTPPage()),
      );

      setState(() {
        _isLoading = true;
      });
    } else {
      _validate = true;
    }
  }
}
