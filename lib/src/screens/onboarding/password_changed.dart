import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/button.dart';
import '../../style/fonts.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Text("Password Changed", style: Fonts.heading),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Your password has been changed\nsuccessfully.",
              style: Fonts.medText,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Button(
                buttonText: "Back to Login", onPressed: () => context.pop()),
          )
        ],
      ),
    );
  }
}
