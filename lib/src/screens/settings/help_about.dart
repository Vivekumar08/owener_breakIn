import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';
import '../../utils/images.dart';

class HelpAbout extends StatelessWidget {
  const HelpAbout({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController message = TextEditingController();
    TextEditingController email = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Help", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
                inputText: "Place Name*",
                hintText: "Enter Place Name",
                controller: name),
            InputField(
                inputText: "Email*",
                hintText: "Enter your Email",
                controller: email),
            InputField(
              inputText: "Message*",
              hintText: "I want help in ...",
              controller: message,
              expands: true,
              height: 90.0,
            ),
            const SizedBox(height: 16.0),
            const Spacer(),
            Button(
                onPressed: () => showMessageDialog(
                      context: context,
                      children: [
                        Images.happy,
                        const SizedBox(height: 12.0),
                        Text('Thank You!',
                            style: Fonts.subHeading,
                            textAlign: TextAlign.center),
                      ],
                    ),
                buttonText: "Send Message"),
          ],
        ),
      ),
    );
  }
}
