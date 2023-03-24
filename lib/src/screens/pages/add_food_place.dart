import 'dart:io' show File;
import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/dropdown.dart';
import '../../components/input_field.dart';
import '../../style/fonts.dart';
import '../../style/loader.dart';
import '../../style/snack_bar.dart';
import '../../utils/validators.dart';

class AddFoodPlace extends StatefulWidget {
  const AddFoodPlace({super.key});

  @override
  State<AddFoodPlace> createState() => _AddFoodPlaceState();
}

class _AddFoodPlaceState extends State<AddFoodPlace> {
  TextEditingController place = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController type = TextEditingController();
  ValueNotifier<File?> image = ValueNotifier(null);

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    place.dispose();
    address.dispose();
    landmark.dispose();
    category.dispose();
    type.dispose();
    image.value?.delete();
    image.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Add Food Place", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22.0, 8.0, 22.0, 22.0),
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
                  keyboardType: TextInputType.streetAddress,
                  validator: nullValidation),
              InputField(
                  inputText: "Landmark",
                  hintText: "Enter nearest Landmark (if applicable)",
                  keyboardType: TextInputType.streetAddress,
                  controller: landmark),
              Dropdown(
                  inputText: 'Category',
                  items: const [
                    'Canteen',
                    'Mess',
                    'Micro Cafe',
                    'Juice Corner',
                    'Diary Booth',
                  ],
                  controller: category),
              InputField(
                  inputText: "Food Type*",
                  hintText: "Ex. North Indian, Snacks",
                  controller: type,
                  validator: nullValidation),
              const SizedBox(height: 16.0),
              Text('Image', style: Fonts.inputText),
              const SizedBox(height: 4.0),
              UploadButton(notifier: image, type: UploadButtonType.Image),
              const SizedBox(height: 16.0),
              const Spacer(),
              Button(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (image.value == null) {
                        return showSnackBar('No Image added');
                      }
                      showLoader(context);
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
