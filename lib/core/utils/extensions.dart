import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class EnglishNumbersFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    
    const arabicToEnglish = {
      '٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4',
      '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9',
      '۰': '0', '۱': '1', '۲': '2', '۳': '3', '۴': '4',
      '۵': '5', '۶': '6', '۷': '7', '۸': '8', '۹': '9',
    };
    
    String updatedText = text;
    arabicToEnglish.forEach((arabic, english) {
      updatedText = updatedText.replaceAll(arabic, english);
    });
    
    if (updatedText == text) {
      return newValue;
    }
    
    return newValue.copyWith(
      text: updatedText,
      selection: newValue.selection,
    );
  }
}

extension EnglishDigitsExtension on String {
  String toEnglishDigits() {
    const arabicToEnglish = {
      '٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4',
      '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9',
      '۰': '0', '۱': '1', '۲': '2', '۳': '3', '۴': '4',
      '۵': '5', '۶': '6', '۷': '7', '۸': '8', '۹': '9',
    };
    
    String updatedText = this;
    arabicToEnglish.forEach((arabic, english) {
      updatedText = updatedText.replaceAll(arabic, english);
    });
    return updatedText;
  }
}
