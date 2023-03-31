import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/dropdown.dart';
import '../../components/input_field.dart';
import '../../models/menu.dart';
import '../../providers/food_place_provider.dart';
import '../../router/constants.dart';
import '../../style/loader.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';
import '../../utils/validators.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  TextEditingController itemName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  ValueNotifier<bool> isVeg = ValueNotifier(false);

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    itemName.dispose();
    price.dispose();
    category.dispose();
    ingredients.dispose();
    isVeg.dispose();
    super.dispose();
  }

  List<String> getCategories(FoodPlaceProvider provider) {
    List<String> categories = [];
    if (provider.foodPlaceModel != null) {
      for (MenuCategory category in provider.foodPlaceModel!.menu) {
        categories.add(category.name);
      }
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FoodPlaceProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Add New Item", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                  inputText: "Item Name*",
                  hintText: "Enter Item Name",
                  controller: itemName,
                  validator: nullValidation),
              InputField(
                  inputText: "Price*",
                  hintText: "Enter Price",
                  controller: price,
                  keyboardType: TextInputType.number,
                  validator: numberValidation),
              Dropdown(
                  inputText: "Category*",
                  items: getCategories(provider),
                  controller: category,
                  validator: nullValidation),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () => context.go(addNewCategory),
                child: Text('+ Add New Category',
                    style: Fonts.hintText
                        .copyWith(color: Palette.link, fontSize: 12.0)),
              ),
              InputField(
                  inputText: "Ingredients *",
                  hintText: "Enter Ingredients",
                  controller: ingredients,
                  validator: nullValidation),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Non-Veg',
                      style: Fonts.appBarTitle.copyWith(fontSize: 12.0)),
                  const SizedBox(width: 8.0),
                  ToggleButton(notifier: isVeg),
                ],
              ),
              const Spacer(),
              Button(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showLoader(context);
                    provider
                        .addNewItem(
                      item: MenuItem(
                        name: itemName.text,
                        price: int.parse(price.text),
                        details: ingredients.text,
                        isVeg: !isVeg.value,
                      ),
                      category: category.text,
                    )
                        .whenComplete(
                      () {
                        context.pop();
                        provider.state.isUpdated() ? context.pop() : null;
                      },
                    );
                  }
                },
                buttonText: "Add Item",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({super.key});

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  TextEditingController name = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FoodPlaceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Add new Category", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                  inputText: "Category Name *",
                  hintText: "Enter Category Name",
                  controller: name,
                  validator: nullValidation),
              const Spacer(),
              Button(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showLoader(context);
                    await provider.addNewCategory(cat: name.text).whenComplete(
                      () {
                        context.pop();
                        provider.state.isUpdated() ? context.pop() : null;
                      },
                    );
                  }
                },
                buttonText: "Add Category",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
