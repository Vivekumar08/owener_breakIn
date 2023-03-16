import 'package:flutter/material.dart';
import 'palette.dart';

/// Creates a dialog loader
void showLoader(BuildContext context) {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Palette.primary,
        ),
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}
