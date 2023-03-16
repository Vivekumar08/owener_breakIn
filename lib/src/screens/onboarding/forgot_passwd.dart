import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../providers/providers.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../style/loader.dart';
import '../../utils/validators.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
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
              "Forgot Password?",
              style: Fonts.heading,
            ),
            const SizedBox(height: 10.0),
            Text(
              "Don't worry! It occurs. Please enter the email address linked with your account.",
              style: Fonts.medText,
            ),
            const SizedBox(height: 32.0),
            Form(
              key: _formKey,
              child: InputField(
                  inputText: "Email*",
                  hintText: "Enter your email",
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidation,
                  autofillHints: AutofillHints.email),
            ),
            const SizedBox(height: 24.0),
            Button(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showLoader(context);
                    otpProvider.forgotPassword(email: email.text).whenComplete(
                          () => otpProvider.state.sent()
                              ? context.pushReplacement(otpWithMail)
                              : context.pop(),
                        );
                  }
                },
                buttonText: "Send Code"),
            const Spacer(),
            BottomTextButton(
              text: 'Remember Password?',
              buttonText: 'Login',
              onTap: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
