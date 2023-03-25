import 'package:geolocator/geolocator.dart';
import '../../models/models.dart';

class LocationService {
  /// Determine the current position of the device.
  Future<Location> getLocationAsCoordinates() async {
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

        Position? p = await Geolocator.getLastKnownPosition();
        if (p != null) {
          return Location(lat: p.latitude, lng: p.longitude, address: '');
        }

        return Future.error('DENIED');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('DENIED_FOREVER');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position p = await Geolocator.getCurrentPosition();
    return Location(lat: p.latitude, lng: p.longitude, address: '');
  }

  Future<void> openLocationSettings() async =>
      await Geolocator.openLocationSettings();
}
