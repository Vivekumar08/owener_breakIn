import 'package:flutter/material.dart';
import '../../components/food_card.dart';
import '../../components/input_field.dart';
import '../../style/fonts.dart';

class Canteen extends StatelessWidget {
  const Canteen({super.key, required this.appBarTitle});

  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text(appBarTitle, style: Fonts.appBarTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child:
              SearchField(hintText: "Search for category", controller: search),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22.0),
        child: ListView.separated(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) => const FoodCard(),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 16.0),
        ),
      ),
    );
  }
}
