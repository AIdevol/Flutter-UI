import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dart_interaction/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class DotView extends StatefulWidget {
  final Offset position;
  final double size;
  final Offset? touchLocation;
  final double maxEffectRadius;

  const DotView({
    Key? key,
    required this.position,
    required this.size,
    required this.touchLocation,
    required this.maxEffectRadius,
  }) : super(key: key);

  @override
  State<DotView> createState() => _DotViewState();
}

class _DotViewState extends State<DotView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration:
          Duration(milliseconds: (Random().nextDouble() * 400 + 800).toInt()),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: Random().nextDouble() * 0.5 + 0.3,
      end: Random().nextDouble() * 0.5 + 0.3,
    ).animate(_animationController);

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double computeScale() {
    if (widget.touchLocation == null) return 1.0;

    final distance = sqrt(
        pow(widget.position.dx - widget.touchLocation!.dx, 2) +
            pow(widget.position.dy - widget.touchLocation!.dy, 2));

    if (distance < widget.maxEffectRadius) {
      final normalizedDistance = distance / widget.maxEffectRadius;
      return 0.3 + (normalizedDistance * 0.7);
    }

    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - widget.size / 2,
      top: widget.position.dy - widget.size / 2,
      child: AnimatedBuilder(
        animation: _opacityAnimation,
        builder: (context, child) {
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 1.0, end: computeScale()),
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutQuart,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(_opacityAnimation.value),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DotGrid extends StatefulWidget {
  Widget? child;
  DotGrid({this.child, super.key});

  @override
  State<DotGrid> createState() => _DotGridState();
}

class _DotGridState extends State<DotGrid> {
  Offset? touchLocation;
  DateTime lastFeedbackTime = DateTime.now();
  final columns = 15;
  final rows = 30;
  final dotSize = 6.0;
  final maxEffectRadius = 100.0;

  void _handleFeedback() {
    final now = DateTime.now();
    if (now.difference(lastFeedbackTime).inMilliseconds > 50) {
      HapticFeedback.mediumImpact();
      lastFeedbackTime = now;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() => touchLocation = details.localPosition);
        _handleFeedback();
      },
      onPanUpdate: (details) {
        setState(() => touchLocation = details.localPosition);
        _handleFeedback();
      },
      onPanEnd: (_) => setState(() => touchLocation = null),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          return Container(
            color: Colors.black,
            child: Stack(
              children: [
                for (var row = 0; row < rows; row++)
                  for (var col = 0; col < columns; col++)
                    DotView(
                      position: Offset(
                        col * width / (columns - 1),
                        row * height / (rows - 1),
                      ),
                      size: dotSize,
                      touchLocation: touchLocation,
                      maxEffectRadius: maxEffectRadius,
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
