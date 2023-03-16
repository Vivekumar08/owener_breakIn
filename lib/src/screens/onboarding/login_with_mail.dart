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

class LoginWithMail extends StatefulWidget {
  const LoginWithMail({super.key});

  @override
  State<LoginWithMail> createState() => _LoginWithMailState();
}

class _LoginWithMailState extends State<LoginWithMail> {
  final TextEditingController email = TextEditingController();
  final TextEditingController passwd = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    passwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
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
                "Welcome back! Glad to see you, Again!",
                style: Fonts.heading,
              ),
              const SizedBox(height: 16.0),
              InputField(
                  inputText: "Email*",
                  hintText: "Enter your email",
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidation,
                  autofillHints: AutofillHints.email),
              PasswordField(
                  inputText: "Password*",
                  hintText: "Enter your password",
                  controller: passwd,
                  // TODO: remove validator
                  validator: nullValidation),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                    onTap: () => context.go(forgotPassword),
                    child: Text("Forgot Password?", style: Fonts.textButton)),
              ),
              const SizedBox(height: 24.0),
              Button(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showLoader(context);
                      auth
                          .loginWithMail(
                              email: email.text, password: passwd.text)
                          .whenComplete(
                            () => auth.state.isAuthenticated()
                                ? context.go(home)
                                : context.pop(),
                          );
                    }
                  },
                  buttonText: "Login"),
              const SizedBox(height: 10),
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
      ),
    );
  }
}
