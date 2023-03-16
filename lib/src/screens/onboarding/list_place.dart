import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';
import '../../utils/validators.dart';

class ListPlace extends StatefulWidget {
  const ListPlace({super.key});

  @override
  State<ListPlace> createState() => _ListPlaceState();
}

class _ListPlaceState extends State<ListPlace> {
  TextEditingController place = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController owner = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    place.dispose();
    address.dispose();
    owner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("List Place", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                  inputText: "Place Name*",
                  hintText: "Enter Place Name",
                  controller: place,
                  validator: nullValidation),
              InputField(
                  inputText: "Address*",
                  hintText: "Enter Address",
                  controller: address,
                  validator: nullValidation),
              InputField(
                  inputText: "Owner Name*",
                  hintText: "Enter Owner Name",
                  controller: owner,
                  validator: nullValidation),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showMessageDialog(
                        context: context,
                        children: [
                          Text('Thank You',
                              style: Fonts.subHeading,
                              textAlign: TextAlign.center),
                          const SizedBox(height: 16.0),
                          Text(
                              'Your Document have been submit successfully . As soon '
                              'as our team verifies your credentials, we will contact your.',
                              style: Fonts.simText,
                              textAlign: TextAlign.center)
                        ],
                      ).whenComplete(() => context.go(home));
                    }
                  },
                  buttonText: "Submit Details"),
            ],
          ),
        ),
      ),
    );
  }
}
