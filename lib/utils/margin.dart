import 'package:flutter/material.dart';

class XMargin extends StatelessWidget {
  final double x;
  const XMargin(this.x);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x);
  }
}

class YMargin extends StatelessWidget {
  final double y;
  const YMargin(this.y);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y);
  }
}

double screenHeight(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.height * percent;

double screenWidth(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.width * percent;

class CustomPageRoute<T> extends PageRoute<T> {
      CustomPageRoute(this.child);
      @override
      Color get barrierColor => Colors.white;

      @override
      String get barrierLabel => null;

      final Widget child;

      @override
      Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      }

      @override
      bool get maintainState => true;

      @override
      Duration get transitionDuration => Duration(milliseconds: 300);
    }