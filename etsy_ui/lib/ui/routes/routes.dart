import 'package:etsy_ui/ui/widget/screen/home_screen.dart';
import 'package:etsy_ui/ui/widget/screen/login_screen.dart';
import 'package:flutter/material.dart';

class screenRoutes {
  static Future<void> navigateTologinScreen(BuildContext context) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  static Future<void> navigateTohomeScreen(BuildContext context) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
