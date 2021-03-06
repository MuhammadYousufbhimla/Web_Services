// ignore_for_file: unnecessary_new

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:web_services/controller.dart/local_auth_api.dart';
import 'package:web_services/customwiget.dart/custom_widgets.dart';
import 'package:web_services/screen/home..dart';

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool isAvailable;
  late bool hasFingerprint;

  bool _showPassword = false;
  checkAvablity() async {
    isAvailable = await LocalAuthApi.hasBiometrics();
    final biometrics = await LocalAuthApi.getBiometrics();

    hasFingerprint = biometrics.contains(BiometricType.fingerprint);

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildText('Biometrics', isAvailable),
        buildText('Fingerprint', hasFingerprint),
      ],
    );
  }

  List colors = [Colors.red, Colors.green, Colors.yellow];
  Random random = new Random();

  int index = 0;

  void changeIndex(BuildContext context) {
    setState(() => index = random.nextInt(3));
    Navigator.push(context, MaterialPageRoute(builder: ((context) => Home())));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xFF009C10),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF009C10),
          title: const Text(""),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(
                  MediaQuery.of(context).size.height * 0.02,
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 8,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                    border: Border.all(color: Colors.transparent)),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login ",
                        style: TextStyle(
                            fontSize: 29,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.8)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "let us know it's you by one click authentication",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey.withOpacity(0.8)),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                            controller: username,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Email',
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                            controller: password,
                            cursorColor: Colors.green,
                            obscureText: !this._showPassword,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: this._showPassword
                                        ? Colors.green
                                        : Colors.blue,
                                  ),
                                  onPressed: () {
                                    setState(() => this._showPassword =
                                        !this._showPassword);
                                  }),
                            )),
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.05),
                              ),
                              minimumSize: Size(
                                  20,
                                  MediaQuery.of(context).size.height *
                                      0.06) // put the width and height you want

                              ),
                          onPressed: () {
                            _navigateToNextScreen(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Home()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder(
                              future: checkAvablity(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator(
                                    color: Colors.green,
                                    strokeWidth: 2,
                                  );
                                } else {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // buildText('Biometrics Hardware  ', isAvailable),
                                      // buildText(
                                      //     'Fingerprint Availability ', hasFingerprint),
                                      authenticateButton(context)
                                    ],
                                  );
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

_navigateToNextScreen(BuildContext context) {
  if (username.text == "admin@gmail.com" && password.text == "admin") {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
    username.clear();
    password.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('login'),
    ));
  } else if (username != "admin@gmail.com" && password == "admin") {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Please enter valid credentials'),
    ));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Email Credentials"),
            content: Text("Please enter valid credentials"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  } else if (username == "admin@gmail.com" && password != "admin") {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Please enter valid credentials'),
    ));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Password Credentials"),
            content: Text("Please enter valid credentials"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Please enter valid credentials'),
    ));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid  Credentials"),
            content: Text("Please enter valid credentials"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
