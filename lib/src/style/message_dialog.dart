import 'package:flutter/material.dart';

Future<void> showMessageDialog(
        {required BuildContext context,
        required List<Widget> children,
        EdgeInsetsGeometry? contentPadding}) =>
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
        children: children,
      ),
    );
