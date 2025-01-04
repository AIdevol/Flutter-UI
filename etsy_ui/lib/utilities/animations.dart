import 'package:flutter/material.dart';

class AnimatedVisibilitySection extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AnimatedVisibilitySection({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _AnimatedVisibilitySectionState createState() =>
      _AnimatedVisibilitySectionState();
}

class _AnimatedVisibilitySectionState extends State<AnimatedVisibilitySection> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Add a small delay to trigger the animation after widget is built
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      opacity: _isVisible ? 1.0 : 0.0,
      curve: Curves.easeInOut,
      child: AnimatedSlide(
        duration: widget.duration,
        offset: _isVisible ? Offset.zero : const Offset(0, 0.1),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
