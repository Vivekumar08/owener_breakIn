import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';

class SuggestPlace extends StatelessWidget {
  const SuggestPlace({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController location = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Suggest a Place", style: Fonts.appBarTitle),
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
                inputText: "Address*",
                hintText: "Enter Address",
                controller: location),
            InputField(
                inputText: "Contact Number*",
                hintText: "Enter Contact Number",
                controller: phone),
            const SizedBox(height: 16.0),
            const Spacer(),
            Button(
              onPressed: () => showMessageDialog(
                context: context,
                children: [
                  Text('Thank You',
                      style: Fonts.subHeading, textAlign: TextAlign.center),
                  const SizedBox(height: 16.0),
                  Text(
                      'We really love people volunteer about their favorite place. '
                      'We will try our best to onboard the place which you can asked for.',
                      style: Fonts.simText,
                      textAlign: TextAlign.center)
                ],
              ),
              buttonText: "Suggest Place",
            ),
          ],
        ),
      ),
    );
  }
}
