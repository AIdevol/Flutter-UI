import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    ));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: SingleChildScrollView(
            child: SizedBox(
              height: 900,
              child: Stack(
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -1),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: controller,
                      curve: Curves.elasticOut,
                    )),
                    child: _topViewWidget(context, controller),
                  ),
                  Positioned(
                    left: 22,
                    top: 260,
                    right: 22,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _circleViewWIdget(context),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 400,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildViewContainer(context),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 580,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _textViewWidget(context),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 630,
                    child: _sizedBoxWidget(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _topViewWidget(BuildContext context, AnimationController controller) {
  final screenWidth = MediaQuery.of(context).size.width;
  return Container(
    height: 300,
    width: screenWidth,
    decoration: const BoxDecoration(
      color: Color(0xffFF98CF),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 70,
          left: 20,
          right: 20,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: controller,
              curve: Curves.elasticOut,
            )),
            child: _searchBarWidget(context),
          ),
        ),
        Positioned(
          left: screenWidth * 0.3,
          top: 160,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: controller,
              curve: Curves.elasticOut,
            )),
            child: _locationViewWidget(),
          ),
        ),
      ],
    ),
  );
}

Widget _searchBarWidget(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: HexColor('181229'),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey),
              ),
              child: const Icon(Icons.shopping_bag, color: Colors.black),
            ),
          );
        },
      ),
    ],
  );
}

Widget _locationViewWidget() {
  return Column(
    children: <Widget>[
      Text(
        "Current Location",
        style: TextStyle(
          fontFamily: 'Arial',
          fontSize: 18,
          color: HexColor('ffffff'),
        ),
      ),
      Row(
        children: [
          Icon(
            Icons.location_pin,
            color: HexColor('FFFFFF'),
            size: 30,
          ),
          Text(
            "Texas, USA",
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: HexColor('ffffff'),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _circleViewWIdget(BuildContext context) {
  final items = [
    {'icon': Icons.candlestick_chart, 'label': 'Sweets'},
    {'icon': Icons.health_and_safety_rounded, 'label': 'Health'},
    {'icon': Icons.local_drink_rounded, 'label': 'Drink'},
    {'icon': Icons.icecream_rounded, 'label': 'Frozen'},
  ];

  return SizedBox(
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        items.length,
        (index) => TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500 + (index * 200)),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: HexColor('ffffff'),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 3,
                          offset: Offset(0, -3),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Color(0xffFF98CF),
                      radius: 35,
                      child: Icon(items[index]['icon'] as IconData),
                    ),
                  ),
                  Text(
                    items[index]['label'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HexColor('181229'),
                      fontFamily: 'Arial',
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}

Widget _buildViewContainer(BuildContext context) {
  final containerSize = MediaQuery.of(context).size;
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 800),
    builder: (context, value, child) {
      return Transform.scale(
        scale: value,
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: containerSize.height * 0.2,
            width: containerSize.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFB5A4FC),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  right: 0,
                  bottom: 0,
                  width: containerSize.width * 0.3,
                  child: Container(
                    height: containerSize.height * 1.5,
                    decoration: BoxDecoration(
                      color: Color(0xFFA3EE76),
                      border: Border(
                        left:
                            BorderSide(width: 8.0, color: Colors.grey.shade200),
                        top:
                            BorderSide(width: 8.0, color: Colors.grey.shade200),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Icon(Icons.arrow_forward_outlined, size: 45),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Get Your\n15% Cashback",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
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
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _textViewWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'You Might Need',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      TextButton(
        child: Text(
          'See More',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        onPressed: () {},
      ),
    ],
  );
}

Widget _sizedBoxWidget(BuildContext context) {
  final sizedContainer = MediaQuery.of(context).size;
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      height: 400,
      child: Row(
        children: List.generate(
          4,
          (index) => TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 500 + (index * 200)),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: CupertinoColors.white,
                    ),
                    height: sizedContainer.height * 0.3,
                    width: 170,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                height: 130,
                                width: 130,
                                child: Image.asset(
                                  "assets/annemarie-schaepman-C-bYGgfDZ7E-unsplash.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        _buildProductDetails(),
                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 300),
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: HexColor('FF98CF'),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: CupertinoColors.white,
                                    size: 45,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}

Widget _buildProductDetails() {
  return Positioned(
    top: 155,
    left: 20,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Beetroot",
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 2),
        Text(
          "500g",
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "\$4.00",
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

class AnimatedAddButton extends StatefulWidget {
  const AnimatedAddButton({Key? key}) : super(key: key);

  @override
  State<AnimatedAddButton> createState() => _AnimatedAddButtonState();
}

class _AnimatedAddButtonState extends State<AnimatedAddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HexColor('FF98CF'),
              ),
              child: Icon(
                Icons.add,
                color: CupertinoColors.white,
                size: 45,
              ),
            ),
          );
        },
      ),
    );
  }
}

// Custom Page Route for smooth transitions
class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
