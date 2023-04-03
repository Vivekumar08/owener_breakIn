import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocode;
import '../../models/models.dart';

class LocationService {
  /// Determine the current position of the device.
  Future<Location> getLocation() async {
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
          List<geocode.Placemark> placemark =
              await geocode.placemarkFromCoordinates(p.latitude, p.longitude);
          return Location(
            lat: p.latitude,
            lng: p.longitude,
            address: placemark.first.toString(),
          );
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
    geocode.Placemark placemark =
        (await geocode.placemarkFromCoordinates(p.latitude, p.longitude)).first;
    return Location(
      lat: p.latitude,
      lng: p.longitude,
      address: placemarkToAddress(placemark),
    );
  }

  Future<Location> getLocationFromAddress(String address) async {
    List<geocode.Location> locationList =
        await geocode.locationFromAddress(address);
    if (locationList.isEmpty) {
      return Future.error('ADDRESS_NOT_FOUND');
    }
    geocode.Location l = locationList.first;
    return Location(lat: l.latitude, lng: l.longitude, address: address);
  }

  Future<void> openLocationSettings() async =>
      await Geolocator.openLocationSettings();

  String placemarkToAddress(geocode.Placemark placemark) {
    bool check(String? s) {
      if (s != null && s.isNotEmpty) {
        return true;
      }
      return false;
    }

    String address = '';
    if (check(placemark.name)) address += '${placemark.name}, ';
    if (check(placemark.subLocality)) address += '${placemark.subLocality}, ';
    if (check(placemark.locality)) address += '${placemark.locality}, ';
    if (check(placemark.country)) address += '${placemark.country}, ';
    if (check(placemark.postalCode)) address += '${placemark.postalCode}';
    return address;
  }
}
