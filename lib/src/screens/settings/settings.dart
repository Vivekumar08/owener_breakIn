import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../style/message_dialog.dart';
import '../../components/button.dart';
import '../../style/fonts.dart';
import '../../router/constants.dart';
import '../../style/palette.dart';
import '../../utils/images.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  Widget _settingsCategories(String text, VoidCallback onPressed) => ListTile(
        title:
            Text(text, style: Fonts.buttonText.copyWith(color: Palette.text)),
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.zero,
        dense: true,
        trailing: const Icon(
          Icons.chevron_right,
          size: 32,
        ),
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.greyNormal),
        ),
        onTap: onPressed,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Settings", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            _settingsCategories(
              "Logout",
              () => showMessageDialog(
                context: context,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 16.0),
                children: [
                  Images.sad,
                  const SizedBox(height: 16.0),
                  Text(
                    'It’s sad to see you leave. We are extremely sorry for any sort of '
                    'inconvenience. Hopefully we will meet in future. As we are still in nascent '
                    'stage, your feedback will matter a lot . ',
                    style: Fonts.simText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  Button(
                    onPressed: () => context.go(feedback),
                    buttonText: 'Send Feedback',
                    color: Palette.iconsCol,
                  ),
                  const SizedBox(height: 16.0),
                  Button(
                    onPressed: () => context.go(root),
                    buttonText: 'Logout Anyway',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
