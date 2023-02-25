import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/location_detection.dart';
import '../../style/palette.dart';
import '../../utils/images.dart';

class DetectingNewLocation extends StatelessWidget {
  const DetectingNewLocation({super.key});

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
              height: 200,
              child: Column(
                children: [
                  const LocationDetection(
                      head: "Detecting Location", location: ""),
                  SizedBox(
                    width: 268,
                    height: 40,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            height: 10.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 100,
                            height: 10.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 170.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //  ] ),
                ],
              )),
        ),
      ),
    );
  }
}
