import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../providers/providers.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';
import '../../utils/validators.dart';

class SuggestPlace extends StatefulWidget {
  const SuggestPlace({super.key});

  @override
  State<SuggestPlace> createState() => _SuggestPlaceState();
}

class _SuggestPlaceState extends State<SuggestPlace> {
  TextEditingController placeName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    placeName.dispose();
    address.dispose();
    contact.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Suggest a Place", style: Fonts.appBarTitle),
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
                  controller: placeName,
                  validator: nullValidation),
              InputField(
                  inputText: "Address*",
                  hintText: "Enter Address",
                  controller: address,
                  keyboardType: TextInputType.streetAddress,
                  validator: nullValidation),
              InputField(
                  inputText: "Contact Number*",
                  hintText: "Enter Contact Number",
                  controller: contact,
                  keyboardType: TextInputType.number,
                  isPhone: true,
                  validator: contactValidation),
              const SizedBox(height: 16.0),
              const Spacer(),
              Button(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<ProfileProvider>()
                        .suggestPlace(
                            placeName: placeName.text,
                            address: address.text,
                            contact: contact.text)
                        .then(
                          (_) => showMessageDialog(
                            context: context,
                            children: [
                              Text('Thank You',
                                  style: Fonts.subHeading,
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 16.0),
                              Text(
                                  'We really love people volunteer about their favorite place. '
                                  'We will try our best to onboard the place which you can asked for.',
                                  style: Fonts.simText,
                                  textAlign: TextAlign.center)
                            ],
                          ).whenComplete(() => context.pop()),
                        );
                  }
                },
                buttonText: "Suggest Place",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
