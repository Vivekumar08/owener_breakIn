import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../style/fonts.dart';
import '../../style/loader.dart';
import '../../style/message_dialog.dart';
import '../../style/snack_bar.dart';
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
  ValueNotifier<File?> document = ValueNotifier(null);

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    place.dispose();
    address.dispose();
    owner.dispose();
    document.value?.delete();
    document.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListPlaceProvider>(context);
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
              UploadButton(notifier: document),
              const SizedBox(height: 16.0),
              Text(
                  'Submit Document Approved by Regulatory Authority/Institution/Government/fssai in .pdf/.jpg format.',
                  style: Fonts.inputText.copyWith(fontSize: 10.0)),
              const Spacer(),
              Button(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (document.value == null) {
                        return showSnackBar('No Documents added');
                      }
                      showLoader(context);
                      provider
                          .listPlace(ListPlaceModel(
                              placeName: place.text,
                              address: address.text,
                              ownerName: owner.text,
                              document: document.value!))
                          .whenComplete(
                            () => provider.state.isUploaded()
                                ? showMessageDialog(
                                    dismissible: false,
                                    context: context,
                                    children: [
                                        Text('Thank You',
                                            style: Fonts.subHeading,
                                            textAlign: TextAlign.center),
                                        const SizedBox(height: 16.0),
                                        Text(
                                            'Your Document have been submitted successfully . As soon '
                                            'as our team verifies your credentials, we will contact you.',
                                            style: Fonts.simText,
                                            textAlign: TextAlign.center)
                                      ])
                                : context.pop(),
                          );
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
