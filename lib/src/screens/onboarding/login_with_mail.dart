import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/auth_options.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';

class LoginWithMail extends StatelessWidget {
  const LoginWithMail({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController passwd = TextEditingController();

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
                inputText: "Email*",
                hintText: "Enter your email",
                controller: email),
            PasswordField(
                inputText: "Password*",
                hintText: "Enter your password",
                controller: passwd),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                  onTap: () => context.go(forgotPassword),
                  child: Text("Forgot Password?", style: Fonts.textButton)),
            ),
            const SizedBox(height: 24.0),
            Button(onPressed: () => context.go(home), buttonText: "Login"),
            AuthOptions(
              emailAuth: false,
              text: "Or Login with",
              onTapWithPhone: () => context.pushReplacement(loginWithPhone),
            ),
            const Spacer(),
            BottomTextButton(
              text: 'Don’t have an account?',
              buttonText: 'Register Now',
              onTap: () => context.go(registerWithMail),
            ),
          ],
        ),
      ),
    );
  }
}
