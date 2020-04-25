import 'package:flutter/material.dart';

//Create a transition that fades in the new view, while fading out a white background
class BlankPageRoute extends PageRouteBuilder {
  final Widget enterPage;

  BlankPageRoute({this.enterPage})
      : super(
            transitionDuration: Duration(milliseconds: 600),
            pageBuilder: (context, animation, secondaryAnimation) => enterPage,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var fadeIn = Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(curve: Interval(.7, 1), parent: animation));
              var fadeOut = Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(curve: Interval(0, .2), parent: animation));
              return Stack(children: <Widget>[
                FadeTransition(
                    opacity: fadeOut, child: Container(color: Theme.of(context).backgroundColor)),
                FadeTransition(opacity: fadeIn, child: child)
              ]);
            });
}
