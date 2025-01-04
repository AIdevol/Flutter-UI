import 'package:etsy_ui/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screen/home_screen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the home screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      screenRoutes.navigateTologinScreen(context);
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SVG Logo
              SvgPicture.asset(
                'assets/Etsy_logo.svg',
                height: 70,
                width: 70,
                fit: BoxFit.contain,
              ),
              // const SizedBox(height: 20),
              // const SizedBox(height: 40),
              // const CircularProgressIndicator(
              //   color: Color(0xFFF16529),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
