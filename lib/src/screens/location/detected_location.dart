import 'package:flutter/material.dart';
import '../../components/location_detection.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';
import '../../utils/images.dart';

class DetectedLocation extends StatelessWidget {
  const DetectedLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: Images.bg.image, fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Palette.secondary.withOpacity(0.32)),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Palette.stroke),
              width: 330,
              height: 218,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LocationDetection(
                      head: "Location Detected",
                      location:
                          "L4, Jagdish Nagar, Varachha Surat,\nGujarat, India, 395006"),
                  // Text(
                  //   "L4, Jagdish Nagar, Varachha Surat,\nGujarat, India, 395006",
                  //   style: Fonts.simText,
                  // ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Edit Location Manually",
                    style:
                        Fonts.simText.copyWith(color: const Color(0xff5d5fEF)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
