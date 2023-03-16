import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/auth_options.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../providers/providers.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../style/loader.dart';
import '../../utils/validators.dart';

class RegisterWithMail extends StatefulWidget {
  const RegisterWithMail({super.key});

  @override
  State<RegisterWithMail> createState() => _RegisterWithMailState();
}

class _RegisterWithMailState extends State<RegisterWithMail> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();
  TextEditingController confirmPasswd = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
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
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22.0, 56.0, 22.0, 27.0),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const ClampingScrollPhysics(),
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
                  controller: name,
                  validator: nullValidation,
                  autofillHints: AutofillHints.name),
              InputField(
                  inputText: "Email*",
                  hintText: "Enter your email",
                  controller: email,
                  validator: emailValidation,
                  autofillHints: AutofillHints.email),
              PasswordField(
                  inputText: "New Password*",
                  hintText: "Enter your password",
                  controller: passwd,
                  validator: confirmPasswordValidation),
              PasswordField(
                  inputText: "Confirm New Password*",
                  hintText: "Enter your password",
                  controller: confirmPasswd,
                  validator: confirmPasswordValidation),
              const SizedBox(height: 24.0),
              Button(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoader(context);
                      auth
                          .registerWithMail(
                              name: name.text,
                              email: email.text,
                              password: passwd.text)
                          .whenComplete(
                            () => auth.state.isAuthenticated()
                                ? context.go(listPlace)
                                : context.pop(),
                          );
                    }
                  },
                  buttonText: "Register"),
              AuthOptions(
                emailAuth: false,
                text: "Or Register with",
                onTapWithPhone: () =>
                    context.pushReplacement(registerWithPhone),
              ),
              const SizedBox(height: 24),
              BottomTextButton(
                text: 'Already have an account?',
                buttonText: 'Login',
                onTap: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
