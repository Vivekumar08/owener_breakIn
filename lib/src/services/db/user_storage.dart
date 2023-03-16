import 'dart:io' show Directory;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/owner.dart';

class UserStorage {
  String key = 'ownerKey';
  Box storage = Hive.box('owner');

  static Future<UserStorage> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String hivePath = directory.path;
    Hive.init(hivePath);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(OwnerAdapter());
    }
    await Hive.openBox('owner');
    return UserStorage();
  }

  // Add User
  Future<void> addUser(Owner user) async {
    storage.put(key, user);
  }

  // Add User
  dynamic getUser() => storage.get(key);

  // Update User
  Future<void> updateUser(Owner user) async {
    storage.put(key, user);
  }

  // Delete User
  Future<void> deleteUser() async {
    storage.delete(key);
  }
}
