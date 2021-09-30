import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testsite/utils/authentication_global.dart';
import 'package:testsite/views/auth/login_widget.dart';
import 'package:testsite/views/welcome_widget.dart';

class ShowUserData extends StatelessWidget {
  const ShowUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isAuthenticated(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("State :" + (snapshot.data == 200).toString());
          if (snapshot.data == 200) {
            return WelcomeScreen();
          } else {
            return LoginScreen();
          }
        });
  }
}
