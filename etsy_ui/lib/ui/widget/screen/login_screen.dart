import 'package:etsy_ui/ui/routes/routes.dart';
import 'package:etsy_ui/utilities/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/animations.dart';
import '../../custom_widget/register_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: AnimatedVisibilitySection(child: _mainScreen(context)),
    );
  }
}

Widget _mainScreen(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Stack(
      children: [
        // Top spacing
        const Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 20,
          ),
        ),

        // Guest button
        Positioned(
            top: 50,
            right: 10,
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Continue as guest",
                  style: TextStyle(color: Colors.black),
                ))),

        // Bottom content
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Original finds from small shops",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 20),
                _imageView(context), // Consider replacing with Image widget
                const SizedBox(height: 20),
                _textFieldView(context),
                const SizedBox(height: 20),
                _buttoneViewNavigator(context),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text:
                            "By Tapping continue with Apple, Facebook, or Google, you agree to Etsy's ",
                      ),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            'Terms of Use',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(text: ' . '),
                    ],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                _buttonSocial(context)
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

_textFieldView(BuildContext context) {
  final formkey = GlobalKey<FormState>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Enter your email to continue",
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.blue),
            borderRadius: BorderRadius.circular(12)),
        child: TextField(
          // onTap: () {
          //   FocusManager.instance.primaryFocus!.unfocus();
          // },
          key: formkey,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}

_buttoneViewNavigator(BuildContext context) {
  final sizeScreen = MediaQuery.of(context).size;
  return Column(
    children: [
      InkWell(
        onTap: () {
          RegisterView();
          print('HSFD');
        },
        child: Container(
          alignment: Alignment.center,
          height: sizeScreen.height * 0.05,
          width: sizeScreen.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            "Continue",
            style: TextStyle(color: whiteColor, fontSize: 20),
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Row(children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "or",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ]),
    ],
  );
}

_buttonSocial(BuildContext context) {
  final sizeScreen = MediaQuery.of(context).size;

  return Column(
    spacing: 10,
    children: [
      SizedBox(
        height: 20,
      ),
      InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: sizeScreen.height * 0.05,
          width: sizeScreen.width * 0.9,
          decoration: BoxDecoration(
            // color: Colors.black,
            border: Border.all(),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // spacing: 10,
            children: [
              Icon(Icons.apple),
              Text(
                "Continue with Apple",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: sizeScreen.height * 0.05,
          width: sizeScreen.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Container(
                height: 18,
                width: 18,
                child: Image.asset('assets/google.png'),
              ),
              Text(
                "Continue with Google",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: sizeScreen.height * 0.05,
          width: sizeScreen.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Icon(Icons.facebook),
              Text(
                "Continue with Facebook",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}

_imageView(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  return SizedBox(
    height: 250,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenSize.height * 0.2,
              width: screenSize.width * 0.35,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/apples-805124_1280.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: screenSize.height * 0.2,
              width: screenSize.width * 0.35,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/pexels-nietjuh-776656.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        Container(
          height: screenSize.height * 0.2,
          width: screenSize.width * 0.4,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.yellow,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/pexels-photo-1019771.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  );
}
