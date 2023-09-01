import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  static void pushRoute(BuildContext context, String targetRoute , [Object? arguments]) {
    Navigator.of(context).pushNamed(targetRoute , arguments: arguments);
  }
  static void pushReplacementRoute(BuildContext context, String targetRoute) {
    Navigator.of(context).pushReplacementNamed(targetRoute);
  }

  static removeAllRoutes(BuildContext context, String targetClass) {
   Navigator.of(context)
    .pushNamedAndRemoveUntil(targetClass, (Route<dynamic> route) => false);
  }
}
