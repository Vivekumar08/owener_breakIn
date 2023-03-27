// ignore_for_file: constant_identifier_names
import 'dart:io' show File;
import 'package:flutter/foundation.dart';
import 'constants.dart';
import '../locator.dart';
import '../models/models.dart';
import '../services/api/api.dart';
import '../services/db/db.dart';
import '../style/snack_bar.dart';

// FoodPlaceProvider Constants
enum FoodPlaceState { Idle, Uploading, Uploaded, Fetching, Updating }

extension FoodPlaceExtension on FoodPlaceState {
  bool isUploaded() => this == FoodPlaceState.Uploaded ? true : false;
}

class FoodPlaceProvider extends ChangeNotifier {
  FoodPlaceState _state = FoodPlaceState.Idle;
  FoodPlaceState get state => _state;

  FoodPlaceModel? _foodPlaceModel;
  FoodPlaceModel? get foodPlaceModel => _foodPlaceModel;

  void _changeState(FoodPlaceState state) {
    _state = state;
    notifyListeners();
  }

  FoodPlaceProvider();

  FoodPlaceProvider.init(bool token, ListPlaceModel? model) {
    if (token && model?.foodPlaceId != null && foodPlaceModel == null) {
      getFoodPlace();
    }
  }

  Future<void> getFoodPlace() async {
    // _changeState(FoodPlaceState.Fetching);
    await locator.isReady<FoodPlaceStorage>().whenComplete(() async {
      _foodPlaceModel = locator.get<FoodPlaceStorage>().getFoodPlace();
      if (_foodPlaceModel == null) {
        await getFoodPlaceFromServer();
      }
    });
    _changeState(FoodPlaceState.Idle);
  }

  Future<void> getFoodPlaceFromServer() async {
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<FoodPlaceService>().getFoodPlace(token!);

    print(response);

    if (response[code] == 200) {
      _foodPlaceModel = FoodPlaceModel.fromJson(response);
      (await locator.getAsync<FoodPlaceStorage>())
          .addFoodPlace(_foodPlaceModel!);
    } else {
      debugPrint(response.toString());
    }
  }

  Future<void> addFoodPlace({
    required String name,
    required String type,
    required String category,
    required String lat,
    required String lng,
    required String address,
    required String landmark,
    required File image,
  }) async {
    _changeState(FoodPlaceState.Uploading);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<FoodPlaceService>().addFoodPlace({
      "FoodPlaceName": name,
      "type": type,
      "category": category,
      "lat": lat,
      "lng": lng,
      "address": address,
      "landmark": landmark,
    }, token!, image);

    if (response[code] == 200) {
      await locator.isReady<ListPlaceStorage>();
      await locator.get<ListPlaceStorage>().updateListPlaceDetails({
        foodPlace: response[foodPlace][foodPlaceId]
      }).whenComplete(() => _changeState(FoodPlaceState.Uploaded));
    } else {
      if (response[msg] != null) {
        showSnackBar(response[err].toString());
      }
      _changeState(FoodPlaceState.Idle);
    }
  }
}
