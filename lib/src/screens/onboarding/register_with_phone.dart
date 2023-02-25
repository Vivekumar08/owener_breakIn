import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/auth_options.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';

class RegisterWithPhone extends StatelessWidget {
  const RegisterWithPhone({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();

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
              "Hello! Register to get started",
              style: Fonts.heading,
            ),
            const SizedBox(height: 16.0),
            InputField(
                inputText: "Full Name*",
                hintText: "Enter your full name",
                controller: name),
            InputField(
                inputText: "Phone Number*",
                hintText: "Enter your phone number",
                controller: phone,
                isPhone: true),
            const SizedBox(height: 24.0),
            Button(
                onPressed: () => context.go(registerWithOtp),
                buttonText: "Send OTP"),
            AuthOptions(
              emailAuth: true,
              text: "Or Register with",
              onTapWithMail: () => context.pushReplacement(registerWithMail),
            ),
            const Spacer(),
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
