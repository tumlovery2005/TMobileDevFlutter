import 'package:flutter/cupertino.dart';

class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  EnterExitRoute({this.enterPage})
      : super(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return enterPage;
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0, 0.1),
            end: Offset(0.0, 0.0),
          ).animate(animation),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 100)
  );
}