import 'dart:io' show Directory;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/models.dart';
import 'db.dart';

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
    if (list.isEmpty) {
      list.add(menuCategory);
      foodPlaceStorage.updateMenu(list);
      return;
    }

    for (MenuCategory category in list) {
      if (category.name == menuCategory.name) {
        return;
      } else {
        list.add(menuCategory);
        foodPlaceStorage.updateMenu(list);
        return;
      }
    }
  }

  // Add addMenuItems
  Future<void> addMenuItem(String categoryName, MenuItem item) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    for (var menuCategory in menu) {
      if (menuCategory.name == categoryName) {
        menuCategory.items?.add(item);
        foodPlaceStorage.updateMenu(menu);
        return;
      }
    }
  }

  // Get all category name
  List<String> getAllMenuCategoryName() {
    List<String> result = [];
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    for (var menuCategory in menu) {
      result.add(menuCategory.name);
    }
    return result;
  }

  // Get all menu items of a single category
  List<MenuItem>? getMenuItemsFromCategory(String categoryName) {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    Iterable<MenuCategory>? category =
        menu.where((menuCategory) => categoryName == menuCategory.name);
    List<MenuCategory>? categoryList = category.toList();
    if (categoryList.length == 1) return categoryList.first.items;
    return null;
  }

  // Get a menu item from id
  MenuItem? getMenuItem(String id) {
    MenuItem? result;
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    for (var menuCategory in menu) {
      menuCategory.items?.forEach((menuItem) {
        menuItem.id == id ? result = menuItem : null;
      });
    }
    return result;
  }

  // Check if MenuCategory Exists Locally
  bool hasMenuCategory(String menuCategory) {
    List<MenuCategory>? list = foodPlaceStorage.getMenu();
    for (MenuCategory category in list) {
      if (category.name == menuCategory) return true;
    }
    return false;
  }

  // Check if MenuItem Exists Locally
  bool hasMenuItem(String category, String itemName) {
    List<MenuCategory>? list = foodPlaceStorage.getMenu();
    for (MenuCategory menuCateogry in list) {
      if (menuCateogry.name == category && menuCateogry.items != null) {
        for (MenuItem menuItem in menuCateogry.items!) {
          if (menuItem.name == itemName) return true;
        }
      }
    }
    return false;
  }

  // Update Expansion State
  Future<void> updateExpansionState(String category, bool state) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    for (MenuCategory menuCategory in menu) {
      if (menuCategory.name == category) {
        menuCategory.isExpanded = state;
        await foodPlaceStorage.updateMenu(menu);
        return;
      }
    }
  }

  // Update menu item from id in same category
  Future<void> updateMenuItem(String id, MenuItem item) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    for (MenuCategory menuCategory in menu) {
      if (menuCategory.items != null) {
        for (MenuItem menuItem in menuCategory.items!) {
          if (menuItem.id == id) {
            menuCategory.items?.remove(menuItem);
            menuCategory.items?.add(item);
            foodPlaceStorage.updateMenu(menu);
            return;
          }
        }
      }
    }
  }

  // Update menu item from id in different category
  Future<void> updateMenuItemViaCategory(
      String oldId, String category, MenuItem item) async {
    // Operations to perform
    bool deleted = false;
    bool added = false;
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    for (MenuCategory menuCategory in menu) {
      if (!added || !deleted) {
        if (menuCategory.items != null && !deleted) {
          menuCategory.items?.removeWhere((item) {
            if (item.id == oldId) deleted = true;
            return item.id == oldId;
          });
        }

        // No menuitem with similar name exists (checked via backend)
        if (menuCategory.name == category) {
          menuCategory.items?.add(item);
          added = true;
        }
      }
    }
    // Update Menu
    foodPlaceStorage.updateMenu(menu);
  }

  // Update item status (availability) from id
  Future<void> updateItemStatus(String id, bool status) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    for (MenuCategory menuCategory in menu) {
      if (menuCategory.items != null) {
        for (MenuItem menuItem in menuCategory.items!) {
          if (menuItem.id == id) {
            menuItem.isAvailable = status;
            foodPlaceStorage.updateMenu(menu);
            return;
          }
        }
      }
    }
  }

  // Delete Menu Category from MenuCategory Object
  Future<void> deleteMenuCategory(MenuCategory category) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    menu.remove(category);
    foodPlaceStorage.updateMenu(menu);
  }

  // Delete Menu Category from String
  Future<void> deleteMenuCategoryFromString(String category) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    for (MenuCategory menuCategory in menu) {
      if (menuCategory.name == category) {
        menu.remove(menuCategory);
        foodPlaceStorage.updateMenu(menu);
        return;
      }
    }
  }

  // Delete Menu Item from Id
  Future<void> deleteMenuItem(String id) async {
    List<MenuCategory>? menu = foodPlaceStorage.getMenu();
    for (MenuCategory menuCategory in menu) {
      menuCategory.items?.forEach((menuItem) {
        if (menuItem.id == id) {
          menuCategory.items?.remove(menuItem);
          foodPlaceStorage.updateMenu(menu);
          return;
        }
      });
    }
  }
}
