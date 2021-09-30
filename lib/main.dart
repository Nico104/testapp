import 'package:flutter/material.dart';
import 'package:testsite/views/auth/login_widget.dart';
import 'package:testsite/views/responsivetest_widget.dart';
import 'package:testsite/views/show_user_data_widget.dart';
import 'package:testsite/views/video_test.dart';
import 'package:testsite/views/auth/signup_widget.dart';
import 'package:testsite/views/welcome_widget.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/video': (context) => ChapterVideoPlayer(),
        '/welcome': (context) => WelcomeScreen(),
        '/responsive': (context) => ResponsiveTestScreen(),
        '/isauth': (context) => ShowUserData(),
      },
    );
  }
}
