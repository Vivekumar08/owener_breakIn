import 'dart:async' show TimeoutException;
import 'dart:convert' show json;
import 'dart:io' show SocketException;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocode;
import 'package:http/http.dart' as http;
import '../../models/models.dart';
import '../constants.dart';

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

  Future<Map<String, dynamic>> getCoordinatesFromServer(String address) async {
    Map<String, dynamic> body = {};
    String query = address.split(RegExp(' ')).join('+');
    query = query.split(',').join('+');

    try {
      http.Response response = await http.get(
        Uri.parse(
            'https://nominatim.openstreetmap.org/search?q=$query&format=json&polygon=1&addressdetails=1&limit=1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 5));

      body = json.decode(response.body).cast<Map<String, dynamic>>()[0];
      body.addAll({'code': response.statusCode});
    } on TimeoutException catch (_) {
      timeOut();
    } on SocketException catch (_) {
      noInternet();
    } catch (e) {
      return Future.error('ADDRESS_NOT_FOUND');
    }
    return body;
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
