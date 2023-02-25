import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/accordion.dart';
import '../../models/example.dart';
import '../../models/menu.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';
import '../../style/palette.dart';
import '../../utils/images.dart';
import '../../utils/symbols.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Palette.white, size: 19.0),
        leadingWidth: 72.0,
        title: Text("The Burger Club",
            style: Fonts.appBarTitle.copyWith(color: Palette.white)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.iconsCol,
        child: const Icon(Icons.add, size: 32.0),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Images.menu,
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Symbols.star,
                      const SizedBox(width: 7.0),
                      Text('4.1',
                          style: Fonts.simTextBlack.copyWith(fontSize: 16.0)),
                      const Spacer(),
                      const Icon(Icons.share_outlined),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text('The Burger Club',
                      style: Fonts.otpText.copyWith(fontSize: 16.0)),
                  const SizedBox(height: 4.0),
                  Text('Sector 7, Rohini (15 KM)', style: Fonts.simTextBlack),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('Menu',
                          style: Fonts.otpText.copyWith(fontSize: 16.0)),
                      const Spacer(),
                      Text('Veg Only',
                          style: Fonts.appBarTitle.copyWith(fontSize: 12.0)),
                      const SizedBox(width: 8.0),
                      SizedBox(
                        height: 20.0,
                        child: FittedBox(
                            fit: BoxFit.cover,
                            child: CupertinoSwitch(
                                value: true, onChanged: (value) {})),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  for (Map<String, dynamic> item
                      in menuComplete['menuCategories'])
                    Accordion(menu: MenuCategory.fromJson(item))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
