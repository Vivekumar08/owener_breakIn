import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../providers/providers.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../style/loader.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController passwd = TextEditingController();
  TextEditingController confirmPasswd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwd.dispose();
    confirmPasswd.dispose();
    super.dispose();
  }

  String? confirmPasswordValidation(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Field is required';
    } else if (input.length < 8) {
      return 'Password must have 8 characters';
    } else if (RegExp(
            r'^(?=.*?[A-Z]|.*?[!@#\$&*~])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(input)) {
      if (passwd.text == confirmPasswd.text) {
        return null;
      } else {
        return 'Password & Confirm Password doesn\'t match';
      }
    }
    return 'Weak Password';
  }

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpProviderViaMail>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22.0, 56.0, 22.0, 27.0),
        child: Form(
          key: _formKey,
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
                  controller: passwd,
                  validator: confirmPasswordValidation),
              const SizedBox(height: 16.0),
              PasswordField(
                  inputText: "Confirm New Password*",
                  hintText: "Enter new password",
                  controller: confirmPasswd,
                  validator: confirmPasswordValidation),
              const SizedBox(height: 24.0),
              Button(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showLoader(context);
                      otpProvider
                          .updatePassword(password: passwd.text)
                          .whenComplete(
                            () => otpProvider.state.verified()
                                ? context.go(passwdChanged)
                                : context.pop(),
                          );
                    }
                  },
                  buttonText: "Reset Password"),
            ],
          ),
        ),
      ),
    );
  }
}
