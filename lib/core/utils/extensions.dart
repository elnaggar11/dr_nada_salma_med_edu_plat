import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  // Colors
  Color get primaryColor => theme.primaryColor;
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;
  Color get hintColor => theme.hintColor;
  Color get primaryContainer => theme.colorScheme.primaryContainer;

  // Text Styles (Assuming project specific naming)
  TextStyle get boldText =>
      textTheme.displayLarge ?? const TextStyle(fontWeight: FontWeight.bold);
  TextStyle get mediumText =>
      textTheme.displayMedium ?? const TextStyle(fontWeight: FontWeight.w500);
  TextStyle get regularText =>
      textTheme.bodyLarge ?? const TextStyle(fontWeight: FontWeight.normal);

  // Arguments extension (as mentioned in rule 9)
  dynamic get arg => ModalRoute.of(this)?.settings.arguments;
}
