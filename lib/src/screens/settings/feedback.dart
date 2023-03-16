import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../providers/profile_provider.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';
import '../../utils/validators.dart';

class Feedback extends StatefulWidget {
  const Feedback({super.key});

  @override
  State<Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  TextEditingController feedback = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    feedback.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Feedback", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: InputField(
                  inputText: "Feedback*",
                  hintText: "I really love this application due to ...",
                  controller: feedback,
                  expands: true,
                  height: 90.0,
                  validator: nullValidation),
            ),
            const SizedBox(height: 16.0),
            const Spacer(),
            Button(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<ProfileProvider>()
                        .feedback(feedback: feedback.text)
                        .then(
                          (_) => showMessageDialog(
                            context: context,
                            children: [
                              Text('Thanks for your feedback',
                                  style: Fonts.subHeading,
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 16.0),
                              Text(
                                  'Thank you so much for your feedback. We are trying our best to make '
                                  'this application more better for you. We appreciate your feedback a lot.',
                                  style: Fonts.simText,
                                  textAlign: TextAlign.center)
                            ],
                          ).whenComplete(() => context.pop()),
                        );
                  }
                },
                buttonText: "Send Feedback"),
          ],
        ),
      ),
    );
  }
}
