import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  final bool animated; // Kinda hacky
  final String imagePath;
  final Duration duration;
  final double finalHeight;

  const Logo({
    this.animated = true,
    this.imagePath = 'images/logo.png',
    this.duration = const Duration(milliseconds: 1500),
    this.finalHeight,
  });

  _State createState() => _State();
}

class _State extends State<Logo> with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();

    // Animation
    _iconAnimationController =
        AnimationController(vsync: this, duration: widget.duration);
    _iconAnimation = CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      height: (widget.animated ? _iconAnimation.value : 1) * widget.finalHeight,
      image: AssetImage(widget.imagePath),
    );
  }
}
