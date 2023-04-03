import 'package:flutter/foundation.dart';
import '../services/location/location.dart';
import '../locator.dart';
import '../models/models.dart';
import 'constants.dart';

// Location Provider Constants
// ignore: constant_identifier_names
enum LocationState { Uninitialized, Detected, Detecting, Manual, Denied }

extension LocationExtension on LocationState {
  bool detected() => this == LocationState.Detected ? true : false;
  bool manual() => this == LocationState.Manual ? true : false;
  bool denied() => this == LocationState.Denied ? true : false;
  bool uninitialized() => this == LocationState.Uninitialized ? true : false;
}

class LocationProvider extends ChangeNotifier {
  Location? _location;
  Location? get location => _location;

  LocationState _state = LocationState.Uninitialized;
  LocationState get state => _state;

  LocationProvider.init();

  void _changeLocationState(LocationState locationState) {
    _state = locationState;
    notifyListeners();
  }

  // Uses Geocode Package
  Future<void> getLocation() async {
    _changeLocationState(LocationState.Detecting);
    try {
      _location = await locator.get<LocationService>().getLocation();
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

  // Uses open street Map
  Future<void> getLocationFromAddress(String address) async {
    _changeLocationState(LocationState.Detecting);
    try {
      Map<String, dynamic> response = await locator
          .get<LocationService>()
          .getCoordinatesFromServer(address);

      if (response[code] == 200) {
        _location = Location(
            lat: double.parse(response["lat"]),
            lng: double.parse(response["lon"]),
            address: response["display_name"]);
        _changeLocationState(LocationState.Detected);
      } else {
        _changeLocationState(LocationState.Uninitialized);
      }
    } catch (e) {
      switch (e) {
        case 'ADDRESS_NOT_FOUND':
          _changeLocationState(LocationState.Uninitialized);
          break;
        default:
      }
    }
  }

  Future<void> toManual() async => _changeLocationState(LocationState.Manual);

  Future<void> openLocationSettings() async =>
      await locator.get<LocationService>().openLocationSettings();
}
