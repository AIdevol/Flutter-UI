import 'package:etsy_ui/utilities/color.dart';
import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the home screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF4C5A5), // Light orange
              Color(0xFFF7EFE1), // Off-white or beige
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Placeholder
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/Etsy_logo.svg'), // Add your logo here
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Tagline
              const Text(
                'Discover Unique Finds',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333), // Neutral dark color
                ),
              ),
              const SizedBox(height: 40),
              // Loading Indicator
              const CircularProgressIndicator(
                color: Color(0xFFF16529), // Etsy orange
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
