import 'package:break_in/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../style/loader.dart';

class OTPWithMail extends StatefulWidget {
  const OTPWithMail({super.key});

  @override
  State<OTPWithMail> createState() => _OTPWithMailState();
}

class _OTPWithMailState extends State<OTPWithMail> {
  TextEditingController otp = TextEditingController();

  @override
  void dispose() {
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpProviderViaMail>(context);
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
                  TextSpan(text: otpProvider.email, style: Fonts.medTextBlack)
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Form(child: OtpField(length: 4, controller: otp)),
            const SizedBox(height: 24.0),
            Button(
                onPressed: otpProvider.state.expired()
                    ? null
                    : () {
                        if (otp.text.length == 4) {
                          showLoader(context);
                          otpProvider.verifyOTP(otp: otp.text).whenComplete(
                                () => otpProvider.state.verified()
                                    ? context.go(newPassword)
                                    : context.pop(),
                              );
                        }
                      },
                buttonText: "Verify"),
            const Spacer(),
            BottomTextButton(
              text: 'Didn\'t receive code?',
              buttonText: 'Resend',
              onTap: () {
                showLoader(context);
                otpProvider
                    .resendOTP(email: otpProvider.email)
                    .whenComplete(() => context.pop());
              },
            ),
          ],
        ),
      ),
    );
  }
}
