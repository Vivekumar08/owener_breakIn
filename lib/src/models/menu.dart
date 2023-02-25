class MenuCategory {
  MenuCategory({
    required this.menuCategory,
    required this.menuItems,
    this.isExpanded = false,
  });

  final String menuCategory;
  final List<MenuItem> menuItems;
  bool isExpanded;

  static MenuCategory fromJson(Map<String, dynamic> map) => MenuCategory(
        menuCategory: map['menuCategory'],
        menuItems: MenuItem.fromJsonToList(map['menuItems']),
      );
}

class MenuItem {
  MenuItem({
    required this.item,
    required this.itemDetails,
    required this.price,
    required this.isVeg,
  });
  final String item;
  final String itemDetails;
  final int price;
  final bool isVeg;

  static MenuItem fromJson(Map<String, dynamic> map) => MenuItem(
      item: map['item'],
      itemDetails: map['itemDetails'],
      price: map['price'],
      isVeg: map['isVeg']);

  static List<MenuItem> fromJsonToList(List<Map<String, dynamic>> list) {
    List<MenuItem> menuItems = [];
    for (Map<String, dynamic> item in list)
      // ignore: curly_braces_in_flow_control_structures
      menuItems.add(MenuItem.fromJson(item));
    return menuItems;
  }
}
