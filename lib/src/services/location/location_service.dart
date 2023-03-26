import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Determine the current position of the device.
  Future<Position> getLocationAsCoordinates() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        Position? position = await Geolocator.getLastKnownPosition();
        if (position != null) return position;

        return Future.error('DENIED');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('DENIED_FOREVER');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<void> openLocationSettings() async =>
      await Geolocator.openLocationSettings();
}
