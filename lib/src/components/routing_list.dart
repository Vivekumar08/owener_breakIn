import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../style/fonts.dart';
import '../style/palette.dart';

// Creates a List for page routing
class RoutingList extends StatelessWidget {
  const RoutingList({Key? key, required this.title, required this.route})
      : super(key: key);

  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Fonts.buttonText.copyWith(color: Palette.text)),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      dense: true,
      trailing: const Icon(Icons.chevron_right, size: 32),
      shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.greyNormal)),
      onTap: () => context.go(route),
    );
  }
}
