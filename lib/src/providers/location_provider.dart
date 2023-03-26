import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location/location.dart';
import '../locator.dart';
import '../models/models.dart';

// Location Provider Constants
// ignore: constant_identifier_names
enum LocationState { Uninitialized, Detected, Detecting, Manual, Denied }

extension LocationExtension on LocationState {
  bool detected() => this == LocationState.Detected ? true : false;
  bool manual() => this == LocationState.Manual ? true : false;
  bool denied() => this == LocationState.Denied ? true : false;
}

class LocationProvider extends ChangeNotifier {
  Location? location;

  LocationState _state = LocationState.Uninitialized;
  LocationState get state => _state;

  LocationProvider.init();

  void _changeLocationState(LocationState locationState) {
    _state = locationState;
    notifyListeners();
  }

  Future<void> getLatLng() async {
    _changeLocationState(LocationState.Detecting);
    try {
      Position position =
          await locator.get<LocationService>().getLocationAsCoordinates();

      location = Location(
          lat: position.latitude, lng: position.longitude, address: '');
      _changeLocationState(LocationState.Detected);
    } catch (e) {
      switch (e) {
        case 'DENIED':
          _changeLocationState(LocationState.Denied);
          break;
        case 'DENIED_FOREVER':
          _changeLocationState(LocationState.Denied);
          break;
        default:
      }
    }
  }

  Future<void> toManual() async => _changeLocationState(LocationState.Manual);

  Future<void> openLocationSettings() async =>
      await locator.get<LocationService>().openLocationSettings();
}
