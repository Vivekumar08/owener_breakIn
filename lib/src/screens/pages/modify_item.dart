import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/button.dart';
import '../../components/dropdown.dart';
import '../../components/input_field.dart';
import '../../models/menu.dart';
import 'add_new_item.dart';
import '../../style/snack_bar.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';

class ModifyItem extends StatelessWidget {
  const ModifyItem(
      {super.key, required this.menuItem, required this.menuCategory});

  final MenuItem menuItem;
  final String? menuCategory;

  @override
  Widget build(BuildContext context) {
    TextEditingController itemName = TextEditingController(text: menuItem.item);
    TextEditingController price =
        TextEditingController(text: menuItem.price.toString());
    TextEditingController category = TextEditingController();
    TextEditingController ingredients =
        TextEditingController(text: menuItem.itemDetails);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Modify Item", style: Fonts.appBarTitle),
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
                items: <String>[menuCategory ?? ''],
                controller: category),
            const SizedBox(height: 8.0),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNewCategory())),
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
                showSnackBar('Item Modified');
                context.pop();
              },
              buttonText: "Modify Item",
            ),
          ],
        ),
      ),
    );
  }
}
