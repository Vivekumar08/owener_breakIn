import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';

class ListPlace extends StatelessWidget {
  const ListPlace({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController place = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController owner = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("List Place", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              inputText: "Place Name*",
              hintText: "Enter Place Name",
              controller: place,
            ),
            InputField(
              inputText: "Address*",
              hintText: "Enter Address",
              controller: place,
            ),
            InputField(
              inputText: "Owner Name*",
              hintText: "Enter Owner Name",
              controller: place,
            ),
            const SizedBox(height: 16.0),
            Text('Add Documents', style: Fonts.inputText),
            const SizedBox(height: 4.0),
            const UploadButton(),
            const SizedBox(height: 16.0),
            Text(
                'Submit Document Approved by Regulatory Authority/Institution/Government/fssai in .pdf/.jpg format.',
                style: Fonts.inputText.copyWith(fontSize: 10.0)),
            const Spacer(),
            Button(
                onPressed: () {
                  showMessageDialog(
                    context: context,
                    children: [
                      Text('Thank You',
                          style: Fonts.subHeading, textAlign: TextAlign.center),
                      const SizedBox(height: 16.0),
                      Text(
                          'Your Document have been submit successfully . As soon '
                          'as our team verifies your credentials, we will contact your.',
                          style: Fonts.simText,
                          textAlign: TextAlign.center)
                    ],
                  ).whenComplete(() => context.go(home));
                },
                buttonText: "Submit Details"),
          ],
        ),
      ),
    );
  }
}
