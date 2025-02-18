import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  // Media Query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  double get width => size.width;

  double get height => size.height;

  // Navigation
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
          {required RoutePredicate predicate, Object? arguments}) =>
      Navigator.of(this)
          .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  void pop() => Navigator.of(this).pop();
}
