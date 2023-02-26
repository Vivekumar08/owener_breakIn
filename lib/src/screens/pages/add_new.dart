import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/button.dart';
import '../../components/input_field.dart';
import '../../router/constants.dart';
import '../../style/snack_bar.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';

class AddNewItem extends StatelessWidget {
  const AddNewItem({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController itemName = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController category = TextEditingController();
    TextEditingController ingredients = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Add New Item", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
                inputText: "Item Name*",
                hintText: "Enter Item Name",
                controller: itemName),
            InputField(
                inputText: "Price*",
                hintText: "Enter Price",
                controller: price),
            Dropdown(
                inputText: "Category*",
                items: const <String>['One', 'Two', 'Three', 'Four'],
                controller: category),
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
                controller: ingredients),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text('Non-Veg',
                    style: Fonts.appBarTitle.copyWith(fontSize: 12.0)),
                const SizedBox(width: 8.0),
                SizedBox(
                  height: 20.0,
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child:
                          CupertinoSwitch(value: true, onChanged: (value) {})),
                ),
              ],
            ),
            const Spacer(),
            Button(
              onPressed: () {
                showSnackBar('New Item Added');
                context.pop();
              },
              buttonText: "Add Item",
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Add new Category", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
                inputText: "Category Name *",
                hintText: "Enter Category Name",
                controller: name),
            const Spacer(),
            Button(
              onPressed: () {
                showSnackBar('New Category Added');
                context.pop();
              },
              buttonText: "Add Category",
            ),
          ],
        ),
      ),
    );
  }
}
