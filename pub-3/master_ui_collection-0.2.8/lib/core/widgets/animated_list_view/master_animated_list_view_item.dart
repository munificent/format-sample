import 'package:flutter/material.dart';

enum AnimationVariant {
  scale,
  slide,
  fade,
}

class MasterAnimatedListViewItem extends StatefulWidget {
  final Widget child;
  final AnimationVariant animationVariant;
  final Duration duration;
  final Curve animaionCurve;

  /// Whether to animate the already animated list view item.
  final bool once;
  const MasterAnimatedListViewItem({
    super.key,
    required this.child,
    this.once = false,
    this.animationVariant = AnimationVariant.scale,
    required this.animaionCurve,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<MasterAnimatedListViewItem> createState() =>
      _MasterAnimatedListViewItemState();
}

class _MasterAnimatedListViewItemState extends State<MasterAnimatedListViewItem>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();
    if (widget.animationVariant == AnimationVariant.scale) {
      _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.animaionCurve,
        ),
      );
    }
    if (widget.animationVariant == AnimationVariant.slide) {
      _slideAnimation = Tween<Offset>(
        begin: const Offset(5, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.animaionCurve,
        ),
      );
    }
    if (widget.animationVariant == AnimationVariant.fade) {
      _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.animaionCurve,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.animationVariant == AnimationVariant.slide) {
      return SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      );
    }
    if (widget.animationVariant == AnimationVariant.fade) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      );
    }
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => widget.once;
}
