import 'dart:io' show Directory;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/models.dart';

class FoodPlaceStorage {
  String key = 'foodPlaceKey';
  Box storage = Hive.box('foodPlace');

  static Future<FoodPlaceStorage> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String hivePath = directory.path;
    Hive.init(hivePath);
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(FoodPlaceModelAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(FoodPlaceCategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(LocationAdapter());
    }

    // For get foodplace, these are required
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(MenuCategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(MenuItemAdapter());
    }
    await Hive.openBox('foodPlace');
    return FoodPlaceStorage();
  }

  // Add foodPlaceModel
  Future<void> addFoodPlace(FoodPlaceModel foodPlaceModel) async {
    storage.put(key, foodPlaceModel);
  }

  // Get foodPlaceModel
  FoodPlaceModel? getFoodPlace() {
    dynamic data = storage.get(key);
    if (data is FoodPlaceModel) {
      return data;
    }
    return null;
  }

  // Get menu
  List<MenuCategory> getMenu() {
    dynamic data = storage.get(key);
    if (data is FoodPlaceModel) {
      return data.menu;
    }
    return [];
  }

  // Update foodPlaceModel
  Future<void> updateFoodPlace(FoodPlaceModel foodPlaceModel) async {
    storage.put(key, foodPlaceModel);
  }

  // Update foodPlaceModel
  Future<void> updateMenu(List<MenuCategory> list) async {
    try {
      FoodPlaceModel foodPlaceModel = storage.get(key);
      foodPlaceModel.menu = list;
      await updateFoodPlace(foodPlaceModel);
    } catch (_) {}
  }

  Future<void> updateStatus(bool status) async {
    try {
      FoodPlaceModel foodPlaceModel = storage.get(key);
      foodPlaceModel.status = status;
      await updateFoodPlace(foodPlaceModel);
    } catch (_) {}
  }

  Future<void> updateFoodPlaceDetails(Map<String, dynamic> map) async {
    try {
      FoodPlaceModel foodPlaceModel = storage.get(key);
      Map<String, dynamic> foodPlaceModelMap = foodPlaceModel.toJson();
      map.forEach((key, value) => foodPlaceModelMap[key] = value);
      await updateFoodPlace(FoodPlaceModel.fromJson(foodPlaceModelMap));
    } catch (_) {}
  }

  // Delete foodPlaceModel
  Future<void> deleteFoodPlace() async {
    storage.delete(key);
  }
}
