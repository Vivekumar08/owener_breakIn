import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwd = TextEditingController();
    TextEditingController confirmPasswd = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22.0, 56.0, 22.0, 27.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ChevBackButton(),
            const SizedBox(height: 24.0),
            Text(
              "Create new password",
              style: Fonts.heading,
            ),
            const SizedBox(height: 24.0),
            Text(
              "Your new password must be unique from those previously used.",
              style: Fonts.medText,
            ),
            const SizedBox(height: 16.0),
            PasswordField(
                inputText: "Password*",
                hintText: "Enter your password",
                controller: passwd),
            const SizedBox(height: 16.0),
            PasswordField(
              inputText: "Confirm New Password*",
              hintText: "Enter new password",
              controller: confirmPasswd,
            ),
            const SizedBox(height: 24.0),
            Button(
                onPressed: () => context.go(passwdChanged),
                buttonText: "Reset Password"),
          ],
        ),
      ),
    );
  }
}
