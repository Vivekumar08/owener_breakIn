// ignore_for_file: constant_identifier_names
import 'dart:io' show File;
import 'package:flutter/foundation.dart';
import '../locator.dart';
import '../models/models.dart';
import '../services/api/api.dart';
import '../services/db/db.dart';
import '../services/preferences.dart';
import '../style/snack_bar.dart';
import 'constants.dart';

// FoodPlaceProvider Constants
enum FoodPlaceState { Idle, Uploading, Uploaded, Fetching, Updating, Updated }

extension FoodPlaceExtension on FoodPlaceState {
  bool isUploaded() => this == FoodPlaceState.Uploaded ? true : false;
  bool isLoading() =>
      this == FoodPlaceState.Fetching || this == FoodPlaceState.Updating
          ? true
          : false;
  bool isUpdated() => this == FoodPlaceState.Updated ? true : false;
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
    _changeState(FoodPlaceState.Fetching);
    await locator.isReady<FoodPlaceStorage>().whenComplete(() async {
      _foodPlaceModel = locator.get<FoodPlaceStorage>().getFoodPlace();
      if (_foodPlaceModel == null) {
        await getFoodPlaceFromServer();
      }
    });
    _changeState(FoodPlaceState.Idle);
  }

  Future<void> getFoodPlaceFromServer() async {
    _changeState(FoodPlaceState.Fetching);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<FoodPlaceService>().getFoodPlace(token!);

    if (response[code] == 200) {
      _foodPlaceModel = FoodPlaceModel.fromJson(response);
      (await locator.getAsync<FoodPlaceStorage>())
          .addFoodPlace(_foodPlaceModel!);
      _changeState(FoodPlaceState.Idle);
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
      if (response[err] != null) {
        showSnackBar(response[err].toString());
      }
      _changeState(FoodPlaceState.Idle);
    }
  }

  Future<void> addNewCategory({required String cat}) async {
    _changeState(FoodPlaceState.Updating);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<FoodPlaceService>().addMenuCategory(token!, cat);

    if (response[code] == 200) {
      (await locator.getAsync<MenuStorage>())
          .addMenuCategory(MenuCategory(name: cat, items: []));
      showSnackBar(response[msg]);
      _changeState(FoodPlaceState.Updated);
    } else {
      if (response[err] != null) {
        showSnackBar(response[err].toString());
        // If category exists on db but not locally
        if (response[err].toString() == '$cat already exists' &&
            !(await locator.getAsync<MenuStorage>()).hasMenuCategory(cat)) {
          (await locator.getAsync<MenuStorage>())
              .addMenuCategory(MenuCategory(name: cat, items: []));
        }
      }
      _changeState(FoodPlaceState.Idle);
    }
  }

  Future<void> addNewItem(
      {required String category, required MenuItem item}) async {
    _changeState(FoodPlaceState.Updating);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response = await locator
        .get<FoodPlaceService>()
        .addMenuItem(token!, category, item);

    if (response[code] == 200) {
      if (response[id] != null) item.id = response[id];
      (await locator.getAsync<MenuStorage>()).addMenuItem(category, item);
      showSnackBar(response[msg]);
      _changeState(FoodPlaceState.Updated);
    } else {
      if (response[err] != null) {
        showSnackBar(response[err].toString());
        // If category exists on db but not locally
        if (response[err].toString() == '${item.name} already exists' &&
            !(await locator.getAsync<MenuStorage>())
                .hasMenuItem(category, item.name)) {
          (await locator.getAsync<MenuStorage>()).addMenuItem(category, item);
        }
      }
      _changeState(FoodPlaceState.Idle);
    }
  }

  Future<void> updateExpansionState(
      {required String category, required bool state}) async {
    (await locator.getAsync<MenuStorage>())
        .updateExpansionState(category, state);
  }

  Future<void> changeCoverImage({required File image}) async {
    _changeState(FoodPlaceState.Updating);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<FoodPlaceService>().changeCoverImage(token!, image);

    if (response[code] == 200) {
      if (response[imageUrl] != null) {
        _foodPlaceModel?.image = response[imageUrl];
        (await locator.getAsync<FoodPlaceStorage>())
            .updateFoodPlaceDetails({"image": response[image]});
        showSnackBar(response[msg]);
        return _changeState(FoodPlaceState.Updated);
      }
    } else {
      if (response[err] != null) {
        showSnackBar(response[err].toString());
      }
    }
    _changeState(FoodPlaceState.Idle);
  }

  Future<void> updateItemStatus(
      {required bool status, required MenuItem item}) async {
    if (item.id == null) return showSnackBar('Error: Please Refresh');
    _changeState(FoodPlaceState.Updating);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response = await locator
        .get<FoodPlaceService>()
        .updateItemStatus(token!, status, item);

    if (response[code] == 200) {
      (await locator.getAsync<MenuStorage>())
          .updateItemStatus(item.id!, status);
      showSnackBar(response[msg]);
      _changeState(FoodPlaceState.Updated);
    } else {
      if (response[err] != null) {
        showSnackBar(response[err].toString());
      }
      _changeState(FoodPlaceState.Idle);
    }
  }

  Future<void> updateFoodPlaceStatus({required bool status}) async {
    _changeState(FoodPlaceState.Updating);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response = await locator
        .get<FoodPlaceService>()
        .updateFoodPlaceStatus(token!, status);

    if (response[code] == 200) {
      (await locator.getAsync<FoodPlaceStorage>()).updateStatus(status);
      showSnackBar(response[msg]);
      _changeState(FoodPlaceState.Updated);
    } else {
      if (response[err] != null) {
        showSnackBar(response[err].toString());
      }
      _changeState(FoodPlaceState.Idle);
    }
  }

  Future<void> editItem(
      {required String category,
      required MenuItem item,
      bool sameCategory = false}) async {
    if (item.id == null) return showSnackBar('Error: Please Refresh');
    String oldId = item.id!;
    _changeState(FoodPlaceState.Updating);
    String? token = await locator.get<TokenStorage>().getToken();

    Map<String, dynamic> response = await locator
        .get<FoodPlaceService>()
        .editMenuItem(token!, oldId, category, item);

    if (response[code] == 200) {
      if (response[id] != null) item.id = response[id];
      if (sameCategory) {
        (await locator.getAsync<MenuStorage>()).updateMenuItem(oldId, item);
      } else {
        (await locator.getAsync<MenuStorage>())
            .updateMenuItemViaCategory(oldId, category, item);
      }
      showSnackBar(response[msg]);
      _changeState(FoodPlaceState.Updated);
    } else {
      if (response[err] != null) {
        showSnackBar(response[err].toString());
      }
      _changeState(FoodPlaceState.Idle);
    }
  }

  Future<void> deleteItem(MenuItem item) async {
    if (item.id == null) return showSnackBar('Error: Please Refresh');
    _changeState(FoodPlaceState.Updating);
    String? token = await locator.get<TokenStorage>().getToken();

    Map<String, dynamic> response =
        await locator.get<FoodPlaceService>().deleteMenuItem(token!, item.id!);

    if (response[code] == 200) {
      if (response[id] != null) item.id = response[id];
      (await locator.getAsync<MenuStorage>()).deleteMenuItem(item.id!);
      showSnackBar(response[msg]);
      _changeState(FoodPlaceState.Updated);
    } else {
      if (response[err] != null) {
        showSnackBar(response[err].toString());
      }
      _changeState(FoodPlaceState.Idle);
    }
  }

  Future<void> setPreference(bool value) async =>
      (await locator.getAsync<Preferences>()).setPreference(value);

  Future<bool?> getPreference() async =>
      (await locator.getAsync<Preferences>()).getPreference();
}
