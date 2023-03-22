import 'dart:io' show Directory;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/models.dart';

class OwnerStorage {
  String key = 'ownerKey';
  Box storage = Hive.box('owner');

  static Future<OwnerStorage> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String hivePath = directory.path;
    Hive.init(hivePath);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(OwnerAdapter());
    }
    await Hive.openBox('owner');
    return OwnerStorage();
  }

  // Add owner
  Future<void> addOwner(Owner owner) async {
    storage.put(key, owner);
  }

  // Add owner
  dynamic getOwner() => storage.get(key);

  // Update owner
  Future<void> updateOwner(Owner owner) async {
    storage.put(key, owner);
  }

  Future<void> updateProfilePic(String profilePic) async {
    try {
      Owner owner = storage.get(key);
      owner.profilePic = profilePic;
      await updateOwner(owner);
    } catch (_) {}
  }

  Future<void> updateOwnerDetails(Map<String, dynamic> map) async {
    try {
      Owner owner = storage.get(key);
      Map<String, dynamic> ownerMap = owner.toJson();
      map.forEach((key, value) => ownerMap[key] = value);
      await updateOwner(Owner.fromJson(ownerMap));
    } catch (_) {}
  }

  // Delete owner
  Future<void> deleteOwner() async {
    storage.delete(key);
  }
}
