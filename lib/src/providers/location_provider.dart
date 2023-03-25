import 'package:break_in/src/services/location/location_service.dart';
import 'package:flutter/foundation.dart';
import 'constants.dart';
import '../locator.dart';
import '../models/models.dart';
import '../services/api/api.dart';
import '../services/db/db.dart';
import '../style/snack_bar.dart';

// Location Provider Constants
// ignore: constant_identifier_names
enum LocationState { Uninitialized, Detected, Detecting, Manual }

extension LocationExtension on LocationState {
  bool detected() => this == LocationState.Detected ? true : false;
  bool manual() => this == LocationState.Manual ? true : false;
}

class LocationProvider extends ChangeNotifier {
  LocationState _state = LocationState.Uninitialized;
  LocationState get state => _state;

  String location = '';

  LocationProvider.init() {
    // location =
  }

  void _changeLocationState(LocationState locationState) {
    _state = locationState;
    notifyListeners();
  }

  Future<void> getLatLng() async {
    print('called');
    _changeLocationState(LocationState.Detecting);
    Map<String, double> response =
        await locator.get<LocationService>().getLocationAsCoordinates();
    if (response.isNotEmpty) _changeLocationState(LocationState.Detected);
    print(response);
  }

  Future<void> toManual() async => _changeLocationState(LocationState.Manual);
}
