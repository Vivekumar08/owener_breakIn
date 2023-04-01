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

class ModifyItem extends StatefulWidget {
  const ModifyItem(
      {super.key, required this.menuItem, required this.menuCategory});

  final MenuItem menuItem;
  final String menuCategory;

  @override
  State<ModifyItem> createState() => _ModifyItemState();
}

class _ModifyItemState extends State<ModifyItem> {
  TextEditingController itemName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  ValueNotifier<bool> isNonVeg = ValueNotifier(false);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    itemName.text = widget.menuItem.name;
    price.text = widget.menuItem.price.toString();
    category.text = widget.menuCategory;
    ingredients.text = widget.menuItem.details;
    isNonVeg.value = !widget.menuItem.isVeg;
    super.initState();
  }

  @override
  void dispose() {
    itemName.dispose();
    price.dispose();
    category.dispose();
    ingredients.dispose();
    isNonVeg.dispose();
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
        title: Text("Modify Item", style: Fonts.appBarTitle),
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
                  initialValue: widget.menuCategory,
                  validator: nullValidation),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () => context.push(addNewCategory),
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
                  ToggleButton(notifier: isNonVeg),
                ],
              ),
              const Spacer(),
              Button(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showLoader(context);
                    provider
                        .editItem(
                      item: MenuItem(
                        id: widget.menuItem.id,
                        name: itemName.text,
                        price: int.parse(price.text),
                        details: ingredients.text,
                        isVeg: !isNonVeg.value,
                      ),
                      category: category.text,
                      sameCategory: category.text == widget.menuCategory,
                    )
                        .whenComplete(
                      () {
                        context.pop();
                        provider.state.isUpdated() ? context.pop() : null;
                      },
                    );
                  }
                },
                buttonText: "Modify Item",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
