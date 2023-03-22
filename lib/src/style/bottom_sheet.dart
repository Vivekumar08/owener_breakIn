import 'package:flutter/material.dart';

class CustomBottomSheetChild extends StatelessWidget {
  const CustomBottomSheetChild(
      {super.key, required this.title, this.icon, this.onTap});

  final String title;
  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(leading: Icon(icon), title: Text(title)),
    );
  }
}

Future<void> showCustomBottomSheet({
  required BuildContext context,
  required List<CustomBottomSheetChild> children,
}) async =>
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: children),
        ),
      ),
    );
