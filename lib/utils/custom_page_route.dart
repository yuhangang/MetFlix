import 'package:flutter/material.dart';

abstract class CustomPageRoute {
  static Route verticalTransition(Widget targetPage,
      {Duration? animationDuration}) {
    return PageRouteBuilder(
      reverseTransitionDuration:
          animationDuration ?? const Duration(milliseconds: 400),
      transitionDuration:
          animationDuration ?? const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => targetPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;

        var animatedOpactiy = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeOut));

        return Opacity(
            opacity: 1 - animation.drive(animatedOpactiy).value.dy,
            child: child);
      },
    );
  }
}
