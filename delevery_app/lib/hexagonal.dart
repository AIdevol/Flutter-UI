import 'package:flutter/material.dart';

class HexagonalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final containerSize = MediaQuery.of(context).size;

    return Center(
      child: Material(
        elevation: 4,
        child: ClipPath(
          clipper: HexagonalClipper(),
          child: Container(
            height: containerSize.height * 0.2,
            width: containerSize.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Stack(
              children: [
                // Purple background
                Positioned.fill(
                  child: Container(
                    color: Color(0xFFB5A4FC),
                  ),
                ),
                // Green overlay
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  width: containerSize.width * 0.25, // Adjust width
                  child: Container(
                    color: Color(0xFFA3EE76),
                  ),
                ),
                // Text and arrow
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Get Your\n15% Cashback",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Make it to October 20",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double width = size.width;
    final double height = size.height;
    final double inset = height * 0.2;

    path.moveTo(inset, 0);
    path.lineTo(width - inset, 0);
    path.lineTo(width, height * 0.5);
    path.lineTo(width - inset, height);
    path.lineTo(inset, height);
    path.lineTo(0, height * 0.5);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
