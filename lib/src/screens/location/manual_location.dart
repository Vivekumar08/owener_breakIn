import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../components/location_detection.dart';
import '../../style/palette.dart';
import '../../utils/images.dart';

class ManualLocation extends StatelessWidget {
  const ManualLocation({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController location = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: Images.bg.image, fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Palette.secondary.withOpacity(0.32)),
                borderRadius: BorderRadius.circular(16.0),
                color: Palette.stroke),
            width: 330,
            height: 374,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LocationDetection(
                      head: "Detecting Location",
                      location:
                          "L4, Jagdish Nagar, Varachha Surat,\nGujarat, India, 395006"),
                  const SizedBox(height: 8.0),
                  InputField(
                    inputText: "Location*",
                    hintText: "Enter your location",
                    controller: location,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    height: 80.0,
                  ),
                  const SizedBox(height: 16.0),
                  Button(onPressed: () {}, buttonText: "Save Location"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
