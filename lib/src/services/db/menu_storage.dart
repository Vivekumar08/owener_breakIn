import 'dart:io' show Directory;
import 'package:break_in/src/services/db/db.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/models.dart';

class MenuStorage {
  FoodPlaceStorage foodPlaceStorage;

  MenuStorage(this.foodPlaceStorage);

  static Future<MenuStorage> init(FoodPlaceStorage foodPlaceStorage) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String hivePath = directory.path;
    Hive.init(hivePath);
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(MenuCategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(MenuItemAdapter());
    }
    await Hive.openBox(foodPlaceStorage.storage.name);
    return MenuStorage(foodPlaceStorage);
  }

  // Add addMenuCategory
  Future<void> addMenuCategory(MenuCategory menuCategory) async {
    List<MenuCategory>? list = foodPlaceStorage.getMenu();
    list?.add(menuCategory);
    foodPlaceStorage.updateMenu(list);
  }

  // Add addMenuCategory
  Future<void> addMenuItem(String categoryName, MenuItem item) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    Iterable<MenuCategory>? category =
        menu?.where((menuCategory) => categoryName == menuCategory.name);
    List<MenuCategory>? categoryList = category?.toList();
    if (categoryList?.length == 1) {
      categoryList?.first.items?.add(item);
      addMenuCategory(categoryList!.first);
    }
  }

  // Get all category name
  List<String> getAllMenuCategoryName() {
    List<String> result = [];
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    menu?.forEach((menuCategory) {
      result.add(menuCategory.name);
    });
    return result;
  }

  // Get all menu items of a single category
  List<MenuItem>? getMenuItemsFromCategory(String categoryName) {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    Iterable<MenuCategory>? category =
        menu?.where((menuCategory) => categoryName == menuCategory.name);
    List<MenuCategory>? categoryList = category?.toList();
    if (categoryList?.length == 1) return categoryList?.first.items;
    return null;
  }

  // Get a menu item from id
  MenuItem? getMenuItem(String id) {
    MenuItem? result;
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    menu?.forEach((menuCategory) {
      menuCategory.items?.forEach((menuItem) {
        menuItem.id == id ? result = menuItem : null;
      });
    });
    return result;
  }

  // Update menu item from id
  Future<void> updateMenuItem(String id, MenuItem item) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    menu?.forEach((menuCategory) {
      menuCategory.items?.forEach((menuItem) {
        if (menuItem.id == id) {
          menuCategory.items?.remove(menuItem);
          menuCategory.items?.add(item);
        }
      });
    });
    foodPlaceStorage.updateMenu(menu);
  }

  // Update item status (availability) from id
  Future<void> updateItemStatus(String id, bool status) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    menu?.forEach((menuCategory) {
      menuCategory.items?.forEach((menuItem) {
        if (menuItem.id == id) {
          menuItem.isAvailable = status;
        }
      });
    });
    foodPlaceStorage.updateMenu(menu);
  }

  // Delete Menu Item from Id
  Future<void> deleteMenuItem(String id) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    menu?.forEach((menuCategory) {
      menuCategory.items?.forEach((menuItem) {
        if (menuItem.id == id) {
          menuCategory.items?.remove(menuItem);
        }
      });
    });
    foodPlaceStorage.updateMenu(menu);
  }
}
