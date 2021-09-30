import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testsite/utils/animated_progress_indicator_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _usernameTextController = TextEditingController();
  final _useremailTextController = TextEditingController();
  final _userpasswordTextController = TextEditingController();
  final _userpasswordControlTextController = TextEditingController();
  final _profilePicturePathTextController = TextEditingController();
  final _profileDisplayNameTextController = TextEditingController();
  final _profileBioTextController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _usernameTextController,
      _useremailTextController,
      _userpasswordTextController,
      _userpasswordControlTextController,
      _profilePicturePathTextController,
      _profileDisplayNameTextController,
      _profileBioTextController,
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  Future<void> _showLoginScreen(
      String username,
      String useremail,
      String userpassword,
      String profilePicturePath,
      String profileDisplayName,
      String profileBio) async {
    var url = Uri.parse('http://localhost:3000/user/signup');
    var response = await http.post(url, body: {
      "username": "$username",
      "useremail": "$useremail",
      "userpassword": "$userpassword",
      "userSignUpDateTime":
          // "$DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.now())}",
          "2012-04-23T18:25:43.511Z",
      "profilePicturePath": "$profilePicturePath",
      "profileDisplayName": "$profileDisplayName",
      "profileBio": "$profileBio",
      "profilePoints": "0",
      "userLanguage": "en"
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      print("yes");
      Navigator.of(context).pushNamed('/login');
    } else {
      print("nope");
      Navigator.of(context).pushNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress, // NEW
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Text('Sign up', style: Theme.of(context).textTheme.headline4),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _useremailTextController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _userpasswordTextController,
              decoration: const InputDecoration(hintText: 'password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _userpasswordControlTextController,
              decoration: const InputDecoration(hintText: 'password2'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _profilePicturePathTextController,
              decoration: const InputDecoration(hintText: 'picturepath'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _profileDisplayNameTextController,
              decoration: const InputDecoration(hintText: 'displayname'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _profileBioTextController,
              decoration: const InputDecoration(hintText: 'bio'),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: (_formProgress >= 0 &&
                    _userpasswordTextController.text ==
                        _userpasswordControlTextController.text)
                ? () => _showLoginScreen(
                    _usernameTextController.text,
                    _useremailTextController.text,
                    _userpasswordTextController.text,
                    _profilePicturePathTextController.text,
                    _profileDisplayNameTextController.text,
                    _profileBioTextController.text)
                : null,
            child: const Text('Sign up'),
          ),
        ],
      ),
    );
  }
}
