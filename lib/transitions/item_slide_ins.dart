import 'package:flutter/material.dart';

class ComponentSlideIns extends StatefulWidget {
  final Widget child;
  final Offset? beginOffset;
  final Offset? endOffset;
  final Duration? duration;

  ComponentSlideIns({
    this.beginOffset,
    this.endOffset,
    this.duration,
    required this.child,
  });

  @override
  _ComponentSlideInsState createState() => _ComponentSlideInsState();
}

class _ComponentSlideInsState extends State<ComponentSlideIns>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 1200),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: widget.beginOffset ?? Offset(0.0, 0.0),
        end: widget.endOffset ?? Offset(0.0, 0.0),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      ),
      child: widget.child,
    );
  }
}
