import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/AppSignIn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// A custom app bar widget with a title image and an action icon.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleImagePath;
  final double titleImageWidth;
  final double titleImageHeight;
  final IconData actionIcon;
  final Color actionIconColor;

  const CustomAppBar({
    Key? key,
    this.titleImagePath = "assets/images/ic_app_icon.png",
    this.titleImageWidth = 80,
    this.titleImageHeight = 40,
    this.actionIcon = FontAwesomeIcons.user,
    this.actionIconColor = const Color(0xFF323232),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Image.asset(
        titleImagePath,
        width: titleImageWidth,
        height: titleImageHeight,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppSignIn()),
            );
          },
          icon: Icon(actionIcon),
          color: actionIconColor,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
