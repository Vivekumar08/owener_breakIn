import 'package:break_in/src/utils/functions.dart';
import 'package:flutter/material.dart';

/// Shows [message] in a snack bar as long as a [ScaffoldMessengerState]
/// with global key [scaffoldMessengerKey] is anywhere in the widget tree.
void showSnackBar(String message) {
  final messenger = scaffoldMessengerKey.currentState;
  messenger
    ?..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        width: getTextSize(message) + 32,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        duration: const Duration(seconds: 1),
      ),
    );
}

/// Global Key to access [showSnackBar] method in app
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey(debugLabel: 'scaffoldMessengerKey');
