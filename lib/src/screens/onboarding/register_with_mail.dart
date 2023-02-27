import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/auth_options.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';

class RegisterWithMail extends StatelessWidget {
  const RegisterWithMail({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController passwd = TextEditingController();
    TextEditingController confirmPasswd = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22.0, 56.0, 22.0, 27.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Row(children: const [ChevBackButton(), Spacer()]),
            const SizedBox(height: 24.0),
            Text(
              "Hello! Register to get started",
              style: Fonts.heading,
            ),
            const SizedBox(height: 16.0),
            InputField(
                inputText: "Full Name*",
                hintText: "Enter your full name",
                controller: name),
            InputField(
                inputText: "Email*",
                hintText: "Enter your email",
                controller: email),
            PasswordField(
                inputText: "New Password*",
                hintText: "Enter your password",
                controller: passwd),
            PasswordField(
                inputText: "Confirm New Password*",
                hintText: "Enter your password",
                controller: confirmPasswd),
            const SizedBox(height: 24.0),
            Button(
                onPressed: () => context.go(listPlace), buttonText: "Register"),
            AuthOptions(
              emailAuth: false,
              text: "Or Register with",
              onTapWithPhone: () => context.pushReplacement(registerWithPhone),
            ),
            const SizedBox(height: 30),
            BottomTextButton(
              text: 'Already have an account?',
              buttonText: 'Login',
              onTap: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
