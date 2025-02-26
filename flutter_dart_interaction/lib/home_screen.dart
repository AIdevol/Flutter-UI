import 'package:flutter/material.dart';
import 'package:flutter_dart_interaction/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DotGrid(
      child: Scaffold(
        body: Text(
          'admafakanlsf',
          style: TextStyle(color: Colors.amber, fontSize: 30),
        ),
      ),
    );
  }
}
