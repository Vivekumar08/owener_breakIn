import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/dropdown.dart';
import '../../components/input_field.dart';
import '../../providers/providers.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../style/loader.dart';
import '../../utils/constants.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.push(location);
    });
    super.initState();
  }

  @override
  void dispose() {
    place.dispose();
    address.dispose();
    landmark.dispose();
    category.dispose();
    type.dispose();
    image.value?.delete();
    image.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FoodPlaceProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);
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
          child: MediaQuery.of(context).size.height > 800
              ? _buildWidget(context, provider, locationProvider)
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics()
                      .applyTo(const ClampingScrollPhysics()),
                  padding: EdgeInsets.zero,
                  child: _buildWidget(context, provider, locationProvider),
                ),
        ),
      ),
    );
  }

  Column _buildWidget(BuildContext context, FoodPlaceProvider provider,
      LocationProvider locationProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
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
            InputField(
                inputText: "Food Type*",
                hintText: "Ex. North Indian, Snacks",
                controller: type,
                validator: nullValidation),
            Dropdown(
                inputText: 'Category', items: categories, controller: category),
            const SizedBox(height: 16.0),
            Text('Image*', style: Fonts.inputText),
            const SizedBox(height: 4.0),
            UploadFormButton(
                notifier: image,
                type: UploadButtonType.Image,
                validator: fileValidationWithSize()),
          ],
        ),
        const SizedBox(height: 16.0),
        Button(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                showLoader(context);
                provider
                    .addFoodPlace(
                        name: place.text,
                        type: type.text,
                        category: category.text,
                        lat: locationProvider.location!.lat.toString(),
                        lng: locationProvider.location!.lng.toString(),
                        address: address.text,
                        landmark: landmark.text,
                        image: image.value!)
                    .whenComplete(
                  () {
                    context.read<ListPlaceProvider>().getListPlace();
                    provider.state.isUploaded()
                        ? context.go(home)
                        : context.pop();
                  },
                );
              } else {
                setState(() {});
              }
            },
            buttonText: "Submit Details"),
      ],
    );
  }
}
