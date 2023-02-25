import 'package:flutter/material.dart';
import '../style/fonts.dart';
import '../style/palette.dart';

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

Future<void> showMenuDialog({
  required BuildContext context,
  required List<String> children,
}) =>
    showDialog(
      context: context,
      barrierColor: null,
      builder: (context) => SimpleDialog(
        alignment: Alignment.bottomRight,
        backgroundColor: Palette.stroke,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Palette.greyNormal),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        contentPadding: const EdgeInsets.all(16.0),
        insetPadding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 1.6,
          right: MediaQuery.of(context).size.width / 20,
          bottom: MediaQuery.of(context).size.height / 10,
        ),
        children: <Widget>[
          Center(
              child: Text('Menu',
                  style: Fonts.heading
                      .copyWith(fontSize: 12.0, letterSpacing: 0))),
          Divider(color: Palette.greyNormal, thickness: 1.0),
          for (String item in children)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(item,
                  style: Fonts.simTextBlack
                      .copyWith(fontSize: 10.0, letterSpacing: 0)),
            )
        ],
      ),
    );
