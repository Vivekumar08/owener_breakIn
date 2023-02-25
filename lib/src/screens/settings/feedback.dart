import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';

class Feedback extends StatelessWidget {
  const Feedback({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController feedback = TextEditingController();

    return Scaffold(
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
            InputField(
              inputText: "Feedback*",
              hintText: "I really love this application due to ...",
              controller: feedback,
              expands: true,
              height: 90.0,
            ),
            const SizedBox(height: 16.0),
            const Spacer(),
            Button(
                onPressed: () => showMessageDialog(
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
                    ),
                buttonText: "Send Feedback"),
          ],
        ),
      ),
    );
  }
}
