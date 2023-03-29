import 'dart:math';

import 'package:flutter/widgets.dart';

class TouchableHighlight extends StatefulWidget {
  const TouchableHighlight({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.highlightColor = const Color.fromARGB(255, 66, 66, 66),
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color highlightColor;

  @override
  State<TouchableHighlight> createState() => _TouchableHighlightState();
}

class _TouchableHighlightState extends State<TouchableHighlight>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  void _onTap() => widget.onTap?.call();
  void _onTapDown(_) => _controller.forward(from: 0.5);
  void _onTapUp(_) => _controller.reverse(from: _controller.value);
  void _onCancel() => _controller.reverse(from: _controller.value);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTap,
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      onLongPress: widget.onLongPress,
      onTapCancel: _onCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            color: widget.highlightColor.withOpacity(_controller.value),
            child: Opacity(
              opacity: max(1 - _controller.value, 0.5),
              child: Transform.scale(
                scale: max(1 - _controller.value, 0.996),
                child: child,
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class TouchableOpacity extends StatefulWidget {
  const TouchableOpacity({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.activeOpacity = 0.5,
  });

  final Widget child;
  final double activeOpacity;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  State<TouchableOpacity> createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  void _onTap() => widget.onTap?.call();
  void _onTapDown(_) => _controller.forward();
  void _onTapUp(_) => _controller.reverse(from: widget.activeOpacity);
  void _onCancel() => _controller.reverse(from: widget.activeOpacity);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: widget.activeOpacity)
        .animate(_controller);
  }

  @override
  void didUpdateWidget(covariant TouchableOpacity oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animation = Tween<double>(begin: 1.0, end: widget.activeOpacity)
        .animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _onTap,
        onTapUp: _onTapUp,
        onTapDown: _onTapDown,
        onLongPress: widget.onLongPress,
        onTapCancel: _onCancel,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
