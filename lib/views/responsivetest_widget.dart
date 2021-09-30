import 'package:flutter/material.dart';
import 'package:testsite/utils/animated_progress_indicator_widget.dart';
import 'package:testsite/utils/responsive_builder_widget.dart';

class ResponsiveTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: ResponsiveTestForm(),
          ),
        ),
      ),
    );
  }
}

class ResponsiveTestForm extends StatefulWidget {
  @override
  _ResponsiveTestFormState createState() => _ResponsiveTestFormState();
}

class _ResponsiveTestFormState extends State<ResponsiveTestForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController
    ];

    for (final controller in controllers) {
      if(controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  void _showLoginScreen() {
    Navigator.of(context).pushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      smallScreen: const Text("small"),
      mediumScreen: const Text("medium"),
      largeScreen: Form(
        onChanged: _updateFormProgress, // NEW
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedProgressIndicator(value: _formProgress),
            Text('Sign up', style: Theme
                .of(context)
                .textTheme
                .headline4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _firstNameTextController,
                decoration: const InputDecoration(hintText: 'First name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _lastNameTextController,
                decoration: const InputDecoration(hintText: 'Last name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _usernameTextController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled) ? null : Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled) ? null : Colors.blue;
                }),
              ),
              onPressed: _formProgress == 1 ? _showLoginScreen : null,
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}