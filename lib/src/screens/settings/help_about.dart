import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../providers/providers.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';
import '../../utils/images.dart';
import '../../utils/validators.dart';

class HelpAbout extends StatefulWidget {
  const HelpAbout({super.key});

  @override
  State<HelpAbout> createState() => _HelpAboutState();
}

class _HelpAboutState extends State<HelpAbout> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Help", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                  inputText: "Your Name*",
                  hintText: "Enter your Name",
                  controller: name,
                  validator: nullValidation,
                  autofillHints: AutofillHints.name),
              InputField(
                  inputText: "Email*",
                  hintText: "Enter your Email",
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidation,
                  autofillHints: AutofillHints.email),
              InputField(
                  inputText: "Message*",
                  hintText: "I want help in ...",
                  controller: message,
                  expands: true,
                  height: 90.0,
                  validator: nullValidation),
              const SizedBox(height: 16.0),
              const Spacer(),
              Button(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<ProfileProvider>()
                          .help(
                              name: name.text,
                              email: email.text,
                              message: message.text)
                          .then(
                            (_) => showMessageDialog(
                              context: context,
                              children: [
                                Images.happy,
                                const SizedBox(height: 12.0),
                                Text('Thank You!',
                                    style: Fonts.subHeading,
                                    textAlign: TextAlign.center),
                              ],
                            ).whenComplete(() => context.pop()),
                          );
                    }
                  },
                  buttonText: "Send Message"),
            ],
          ),
        ),
      ),
    );
  }
}
