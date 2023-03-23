import 'dart:io' show Directory;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/models.dart';

class ListPlaceStorage {
  String key = 'listPlaceKey';
  Box storage = Hive.box('listPlace');

  static Future<ListPlaceStorage> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String hivePath = directory.path;
    Hive.init(hivePath);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ListPlaceModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ListPlaceStatusAdapter());
    }
    await Hive.openBox('listPlace');
    return ListPlaceStorage();
  }

  // Add listPlaceModel
  Future<void> addListPlace(ListPlaceModel listPlaceModel) async {
    storage.put(key, listPlaceModel);
  }

  // Add listPlaceModel
  ListPlaceModel? getListPlace() {
    dynamic data = storage.get(key);
    if (data is ListPlaceModel) {
      return data;
    }
    return null;
  }

  // Update listPlaceModel
  Future<void> updateListPlace(ListPlaceModel listPlaceModel) async {
    storage.put(key, listPlaceModel);
  }

  Future<void> updateStatus(String status) async {
    try {
      ListPlaceModel listPlaceModel = storage.get(key);
      listPlaceModel.status = ListPlaceStatus.values.byName(status);
      await updateListPlace(listPlaceModel);
    } catch (_) {}
  }

  Future<void> updateListPlaceDetails(Map<String, dynamic> map) async {
    try {
      ListPlaceModel listPlaceModel = storage.get(key);
      Map<String, dynamic> listPlaceModelMap = listPlaceModel.toJson();
      map.forEach((key, value) => listPlaceModelMap[key] = value);
      await updateListPlace(ListPlaceModel.fromJson(listPlaceModelMap));
    } catch (_) {}
  }

  // Delete listPlaceModel
  Future<void> deletelistPlace() async {
    storage.delete(key);
  }
}
