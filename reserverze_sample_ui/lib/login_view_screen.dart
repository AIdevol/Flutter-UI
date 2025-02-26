import 'package:flutter/material.dart';

class LoginViewScreen extends StatefulWidget {
  const LoginViewScreen({super.key});

  @override
  State<LoginViewScreen> createState() => _LoginViewScreenState();
}

class _LoginViewScreenState extends State<LoginViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4FD),
      body: ListView(
        children: [_headerWidget(context)],
      ),
    );
  }
}

///header login
_headerWidget(BuildContext context) {
  return Text("Log into Reserveze");
}

/// email and password textfield
/// _email Field 
/// password field
///login button
/// social Media login
/// 