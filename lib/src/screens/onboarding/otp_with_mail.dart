import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';

class OTPWithMail extends StatelessWidget {
  const OTPWithMail({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController otp = TextEditingController();
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
              "OTP Verification",
              style: Fonts.heading,
            ),
            const SizedBox(height: 10.0),
            Text.rich(
              TextSpan(
                text:
                    "Enter the verification code we just sent on your email address ",
                style: Fonts.medText,
                children: <TextSpan>[
                  TextSpan(text: "jhondoe@gmail.com", style: Fonts.medTextBlack)
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            OtpField(length: 4, controller: otp),
            const SizedBox(height: 24.0),
            Button(
                onPressed: () => context.go(newPassword), buttonText: "Verify"),
            const Spacer(),
            const BottomTextButton(
              text: 'Didn\'t receive code?',
              buttonText: 'Resend',
            ),
          ],
        ),
      ),
    );
  }
}
