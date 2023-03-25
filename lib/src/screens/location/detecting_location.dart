import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../providers/providers.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';
import '../../utils/images.dart';
import '../../utils/symbols.dart';

class DetectingLocation extends StatefulWidget {
  const DetectingLocation({super.key});

  @override
  State<DetectingLocation> createState() => _DetectingLocationState();
}

class _DetectingLocationState extends State<DetectingLocation> {
  TextEditingController locationController = TextEditingController();

  Widget _buildLoader(double width) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          height: 6.0,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().getLatLng();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(22.0),
        decoration: BoxDecoration(
          image: DecorationImage(image: Images.bg.image, fit: BoxFit.cover),
        ),
        child: Center(
          child: Consumer<LocationProvider>(builder: (context, location, _) {
            return Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Palette.secondary.withOpacity(0.32)),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Palette.stroke),
              width: double.maxFinite,
              height: location.state.detected()
                  ? 218
                  : location.state.manual()
                      ? 374
                      : 184,
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  Symbols.locationMark,
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text('${location.state.name} Location',
                          style: Fonts.subHeading)),
                  location.state.detected()
                      ? _buildDetected(location)
                      : location.state.manual()
                          ? _buildManual(location)
                          : _buildDetecting(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Shimmer _buildDetecting() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLoader(250),
          _buildLoader(100),
          _buildLoader(170),
        ],
      ),
    );
  }

  Column _buildManual(LocationProvider location) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
              'L4, Jagdish Nagar, Varachha Surat, Gujarat, India, 395006 ',
              style: Fonts.simText,
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 16.0),
        location.state.manual()
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  children: [
                    InputField(
                      inputText: "Location*",
                      hintText: "Enter your location",
                      controller: locationController,
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      height: 80.0,
                    ),
                    Button(onPressed: () {}, buttonText: "Save Location"),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () => location.toManual(),
                child: Text("Edit Location Manually",
                    style: Fonts.simText.copyWith(color: Palette.link)),
              ),
      ],
    );
  }

  Column _buildDetected(LocationProvider location) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
              'L4, Jagdish Nagar, Varachha Surat, Gujarat, India, 395006 ',
              style: Fonts.simText,
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 16.0),
        GestureDetector(
          onTap: () => location.toManual(),
          child: Text("Edit Location Manually",
              style: Fonts.simText.copyWith(color: Palette.link)),
        ),
      ],
    );
  }
}
