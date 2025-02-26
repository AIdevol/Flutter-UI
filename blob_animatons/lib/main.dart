import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

void main() {
  runApp(const LiquidBlobView());
}

class LiquidBlobView extends StatefulWidget {
  const LiquidBlobView({super.key});

  @override
  State<LiquidBlobView> createState() => _LiquidBlobViewState();
}

class _LiquidBlobViewState extends State<LiquidBlobView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<Offset> points = [];
  List<Offset> velocities = [];
  List<(Offset point, double age)> ripplePoints = [];
  final int numPoints = 200;
  final double radius = 140;
  double time = 0;

  @override
  void initState() {
    super.initState();
    _setupPoints();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _animationController.addListener(_update);
  }

  void _setupPoints() {
    final random = Random();
    for (int i = 0; i < numPoints; i++) {
      final angle = (2.0 * pi * i) / numPoints;
      points.add(Offset(
        cos(angle) * radius,
        sin(angle) * radius,
      ));
      velocities.add(Offset(
        random.nextDouble() * 1.0 - 0.5,
        random.nextDouble() * 1.0 - 0.5,
      ));
    }
  }

  void _update() {
    const springStrength = 0.08;
    const damping = 0.95;
    const rippleStrength = 30.0;
    const autonomousStrength = 0.3;

    time += 0.016;

    // Update ripple points
    ripplePoints = ripplePoints.where((element) {
      final newAge = element.$2 + 0.016;
      if (newAge < 1) {
        element = (element.$1, newAge);
        return true;
      }
      return false;
    }).toList();

    for (int i = 0; i < points.length; i++) {
      var velocity = velocities[i];
      var point = points[i];

      final noiseX = sin(-time * 2 + i * 0.1) * autonomousStrength;
      final noiseY = cos(-time * 2 + i * 0.1) * autonomousStrength;

      final angle = (2.0 * pi * i) / numPoints;
      final restX = cos(angle) * radius;
      final restY = sin(angle) * radius;

      var fx = (restX - point.dx) * springStrength + noiseX;
      var fy = (restY - point.dy) * springStrength + noiseY;

      for (final ripple in ripplePoints) {
        final dx = ripple.$1.dx - point.dx;
        final dy = ripple.$1.dy - point.dy;
        final distance = sqrt(dx * dx + dy * dy);
        final rippleFactor = sin(ripple.$2 * pi * 2) * (1 - ripple.$2);
        final force = rippleStrength * rippleFactor / (distance + 1);

        fx += dx * force * 0.01;
        fy += dy * force * 0.01;
      }

      velocity = Offset(
        velocity.dx * damping + fx,
        velocity.dy * damping + fy,
      );
      point = Offset(
        point.dx + velocity.dx,
        point.dy + velocity.dy,
      );

      points[i] = point;
      velocities[i] = velocity;
    }

    setState(() {});
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      ripplePoints.add((details.localPosition, 0));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      child: CustomPaint(
        painter: LiquidBlobPainter(
          points: points,
          time: time,
        ),
        child: Container(),
      ),
    );
  }
}

class LiquidBlobPainter extends CustomPainter {
  final List<Offset> points;
  final double time;

  LiquidBlobPainter({
    required this.points,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    if (points.isEmpty) return;

    path.moveTo(
      points[0].dx + centerX,
      points[0].dy + centerY,
    );

    for (int i = 0; i < points.length; i++) {
      final j = (i + 1) % points.length;
      final k = (i + 2) % points.length;

      final p1 = Offset(points[i].dx + centerX, points[i].dy + centerY);
      final p2 = Offset(points[j].dx + centerX, points[j].dy + centerY);
      final p3 = Offset(points[k].dx + centerX, points[k].dy + centerY);

      final cp1 = Offset(
        (p1.dx + p2.dx) / 2,
        (p1.dy + p2.dy) / 2,
      );
      final cp2 = Offset(
        (p2.dx + p3.dx) / 2,
        (p2.dy + p3.dy) / 2,
      );

      path.quadraticBezierTo(p2.dx, p2.dy, cp2.dx, cp2.dy);
    }

    path.close();

    // Draw shadow first
    canvas.drawPath(path, shadowPaint);
    // Draw the main blob
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LiquidBlobPainter oldDelegate) => true;
}

// Main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: LiquidBlobView(),
        ),
      ),
    );
  }
}
