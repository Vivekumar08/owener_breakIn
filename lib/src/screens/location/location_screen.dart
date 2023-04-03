import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../providers/providers.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';
import '../../style/snack_bar.dart';
import '../../utils/images.dart';
import '../../utils/symbols.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with WidgetsBindingObserver {
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().getLocation();
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        context.read<LocationProvider>().state.denied()) {
      context.read<LocationProvider>().getLocation();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var state = context.read<LocationProvider>().state;
        if (state.detected() || state.manual()) return true;
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 56.0),
              decoration: BoxDecoration(
                image:
                    DecorationImage(image: Images.bg.image, fit: BoxFit.cover),
              ),
              child: Center(
                child:
                    Consumer<LocationProvider>(builder: (context, location, _) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Palette.secondary.withOpacity(0.32)),
                        borderRadius: BorderRadius.circular(16.0),
                        color: Palette.stroke),
                    width: double.maxFinite,
                    height: location.state.detected()
                        ? 218
                        : location.state.manual()
                            ? 374
                            : location.state.denied()
                                ? 277
                                : 184,
                    child: Column(
                      children: [
                        const SizedBox(height: 24.0),
                        location.state.denied() ||
                                location.state.uninitialized()
                            ? const Icon(Icons.location_off_rounded, size: 40.0)
                            : Symbols.locationMark,
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text('${location.state.name} Location',
                                style: Fonts.subHeading)),
                        location.state.detected()
                            ? _buildDetected(location)
                            : location.state.manual()
                                ? _buildManual(location)
                                : location.state.denied()
                                    ? _buildDenied(location)
                                    : location.state.uninitialized()
                                        ? _buildUninitialized(location)
                                        : _buildDetecting(location),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Positioned(
              top: 56.0,
              left: 22.0,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () {
                  final state = context.read<LocationProvider>().state;
                  if (state.detected() || state.manual()) return context.pop();
                  showSnackBar('No Location Detected');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 13.08 - 8.0, horizontal: 14.17 - 8.0),
                  decoration: BoxDecoration(
                    color: Palette.white,
                    border: Border.all(color: Palette.stroke),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(Icons.chevron_left,
                      size: 32.0, color: Palette.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader(double width) {
    return Padding(
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
  }

  Shimmer _buildDetecting(LocationProvider provider) {
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

  Column _buildDetected(LocationProvider provider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(provider.location!.address,
              style: Fonts.simText, textAlign: TextAlign.center),
        ),
        const SizedBox(height: 16.0),
        GestureDetector(
          onTap: () => provider.toManual(),
          child: Text("Edit Location Manually",
              style: Fonts.simText.copyWith(color: Palette.link)),
        ),
      ],
    );
  }

  Column _buildManual(LocationProvider provider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(provider.location!.address,
              style: Fonts.simText, textAlign: TextAlign.center),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              InputField(
                inputText: "Location*",
                hintText: "Enter your location (Please be Precise as possible)",
                controller: locationController,
                keyboardType: TextInputType.multiline,
                expands: true,
                height: 80.0,
              ),
              Button(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (locationController.text.isNotEmpty) {
                      provider.getLocationFromAddress(locationController.text);
                    }
                  },
                  buttonText: "Save Location"),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildUninitialized(LocationProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
                text: 'No Location Found,',
                style: Fonts.simText.copyWith(letterSpacing: -0.2),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Try Again',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => provider.toManual(),
                    style: Fonts.simText.copyWith(color: Palette.link),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  Padding _buildDenied(LocationProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        children: [
          Text(
              'Location permissions are permanently denied, we cannot request permissions. '
              'Please enable location for smoother functioning of the application.',
              style: Fonts.simText.copyWith(letterSpacing: -0.2),
              textAlign: TextAlign.center),
          const SizedBox(height: 20.0),
          Button(
            buttonText: 'Settings',
            onPressed: () => provider
                .openLocationSettings()
                .whenComplete(() => provider.getLocation()),
          )
        ],
      ),
    );
  }
}
