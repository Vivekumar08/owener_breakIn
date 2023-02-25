import 'package:flutter/material.dart';
import '../style/fonts.dart';
import '../utils/symbols.dart';

class LocationDetection extends StatelessWidget {
  final String head;
  final String location;
  const LocationDetection(
      {super.key, required this.head, required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              Symbols.locationMark,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(head, style: Fonts.subHeading),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Text(
            location,
            style: Fonts.simText,
            textAlign: TextAlign.center,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 22.0),
        //   child: Button(buttonText: "Back to Login", onPressed: () {}),
        // )
      ],
    );
  }
}
