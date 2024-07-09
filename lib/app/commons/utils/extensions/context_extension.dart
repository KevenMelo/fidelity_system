import 'package:flutter/material.dart';

extension ContextBuild on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  void pop() => Navigator.of(this).pop();
  void snackBar(String message) => ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  void alert(String message) => showDialog(
        context: this,
        builder: (context) => AlertDialog(
          content: Text(message),
        ),
      );

  Color? get backgroundColor => Theme.of(this).colorScheme.background;
  Color? get primaryColor => Theme.of(this).colorScheme.primary;
  Color? get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color? get errorColor => Theme.of(this).colorScheme.error;
  Color? get disabledColor => Theme.of(this).disabledColor;
  Color? get dividerColor => Theme.of(this).dividerColor;
  Color? get hintColor => Theme.of(this).hintColor;
  Color? get highlightColor => Theme.of(this).highlightColor;
  Color? get splashColor => Theme.of(this).splashColor;
  Color? get unselectedWidgetColor => Theme.of(this).unselectedWidgetColor;
}
