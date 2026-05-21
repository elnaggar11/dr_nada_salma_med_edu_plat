import 'package:flutter/cupertino.dart';

extension MediaQueryHelper on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension NavigationHelper on BuildContext {
  void pushNamed({String? name, Object? args}) {
    Navigator.of(this).pushNamed(name!, arguments: args);
  }

  void pushReplacementNamed({String? name, Object? args}) {
    Navigator.of(this).pushReplacementNamed(name!, arguments: args);
  }

  void pushNamedAndRemoveUntil({String? name, Object? args}) {
    Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(name!, (route) => false, arguments: args);
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
