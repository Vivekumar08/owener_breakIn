import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/button.dart';
import '../../router/constants.dart';
import '../../utils/images.dart';
import '../../style/fonts.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Images.onboarding,
                Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: Text("Discover food at work", style: Fonts.heading),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  child: Text(
                    "We make it simple to find the food at your work. Enter your address and let us do the rest.",
                    style: Fonts.medText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 27.0),
            child: Button(
                buttonText: "Next", onPressed: () => context.go(loginWithMail)),
          ),
        ],
      ),
    );
  }
}
