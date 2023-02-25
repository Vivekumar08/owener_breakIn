import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/auth_options.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';

class LoginWithPhone extends StatelessWidget {
  const LoginWithPhone({super.key});

  @override
  Widget build(BuildContext context) {
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
              "Welcome back! Glad to see you, Again!",
              style: Fonts.heading,
            ),
            const SizedBox(height: 16.0),
            InputField(
                inputText: "Phone Number*",
                hintText: "Enter your phone number",
                controller: phone,
                isPhone: true),
            const SizedBox(height: 24.0),
            Button(
                onPressed: () => context.go(otpWithPhone),
                buttonText: "Send OTP"),
            AuthOptions(
              emailAuth: true,
              text: "Or Login with",
              onTapWithMail: () => context.pushReplacement(loginWithMail),
            ),
            const Spacer(),
            BottomTextButton(
              text: 'Don’t have an account?',
              buttonText: 'Register Now',
              onTap: () => context.go(registerWithPhone),
            ),
          ],
        ),
      ),
    );
  }
}
