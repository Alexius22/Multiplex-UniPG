import 'package:flutter/material.dart';

class SlideTopRoute extends PageRouteBuilder {
  final Widget page;
  static Duration duration = const Duration(milliseconds: 500);

  SlideTopRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: duration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
            ),
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: Curves.ease,
                  ),
                ),
                child: child,
              ),
            ),
          ),
        );
}
