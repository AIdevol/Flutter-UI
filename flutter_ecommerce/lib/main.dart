import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common_widget/AppBarWidget.dart';
import 'package:flutter_ecommerce/common_widget/BottomNavBarWidget.dart';
import 'package:flutter_ecommerce/common_widget/DrawerWidget.dart';
import 'package:flutter_ecommerce/screens/HomeScreen.dart';
import 'package:flutter_ecommerce/screens/ShoppingCartScreen.dart';
import 'package:flutter_ecommerce/screens/WishListScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.white,
        primaryColorDark: Colors.white,
        colorScheme: ColorScheme(
          background: Colors.white,
          brightness: Brightness.light,
          primary: Colors.blue,
          onPrimary: Colors.white,
          secondary: Colors.grey,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  final List<Widget> viewContainer = [
    HomeScreen(),
    WishListScreen(),
    ShoppingCartScreen(),
    HomeScreen()
  ];

  void navigateToScreens(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(),
        drawer: DrawerWidget(),
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}
