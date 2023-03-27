import 'dart:io' show File, Platform;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/accordion.dart';
import '../../components/button.dart';
import '../../models/food_place.dart';
import '../../models/menu.dart';
import '../../providers/providers.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';
import '../../utils/symbols.dart';
import '../../utils/validators.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    context.read<FoodPlaceProvider>().getFoodPlace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.iconsCol,
        child: const Icon(Icons.add, size: 32.0),
        onPressed: () => context.go(addNewItem),
      ),
      body: SafeArea(
        top: Platform.isAndroid, // No top safe area for IOS
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Consumer<FoodPlaceProvider>(builder: (context, provider, _) {
            return provider.foodPlaceModel == null
                ? Container()
                : Builder(builder: (context) {
                    FoodPlaceModel foodPlace = provider.foodPlaceModel!;
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(foodPlace.image),
                            AppBar(
                              automaticallyImplyLeading: true,
                              backgroundColor: Colors.transparent,
                              iconTheme: IconThemeData(
                                  color: Palette.white, size: 19.0),
                              leadingWidth: 72.0,
                              title: Text(foodPlace.name,
                                  style: Fonts.appBarTitle
                                      .copyWith(color: Palette.white)),
                              actions: [
                                PopupMenuButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.more_vert_outlined,
                                      color: Palette.white),
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry>[
                                    PopupMenuItem(
                                      height: 40.0,
                                      onTap: () => context.go(coverImage),
                                      child: const Text('Change Cover Image'),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
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
                                  Text(foodPlace.rating.toString(),
                                      style: Fonts.simTextBlack
                                          .copyWith(fontSize: 16.0)),
                                  const Spacer(),
                                  const Icon(Icons.share_outlined),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Text(foodPlace.name,
                                  style:
                                      Fonts.otpText.copyWith(fontSize: 16.0)),
                              const SizedBox(height: 4.0),
                              Text(foodPlace.location.address,
                                  style: Fonts.simTextBlack),
                              const SizedBox(height: 16.0),
                              foodPlace.menu == null
                                  ? Container()
                                  : _buildMenu(foodPlace),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
          }),
        ),
      ),
    );
  }

  Column _buildMenu(FoodPlaceModel foodPlace) {
    return Column(
      children: [
        Row(
          children: [
            Text('Menu', style: Fonts.otpText.copyWith(fontSize: 16.0)),
            const Spacer(),
            Text('Veg Only', style: Fonts.appBarTitle.copyWith(fontSize: 12.0)),
            const SizedBox(width: 8.0),
            ToggleButton(notifier: ValueNotifier(true)),
          ],
        ),
        const SizedBox(height: 6.0),
        for (MenuCategory category in foodPlace.menu!) Accordion(menu: category)
      ],
    );
  }
}

class CoverImage extends StatefulWidget {
  const CoverImage({super.key});

  @override
  State<CoverImage> createState() => _CoverImageState();
}

class _CoverImageState extends State<CoverImage> {
  ValueNotifier<File?> coverImage = ValueNotifier(null);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    coverImage.value?.delete();
    coverImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Change Cover Image", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cover Image', style: Fonts.inputText),
            const SizedBox(height: 4.0),
            Form(
                key: _formKey,
                child: UploadFormButton(
                  notifier: coverImage,
                  type: UploadButtonType.Image,
                  validator: fileValidationWithSize(),
                )),
            const Spacer(),
            ValueListenableBuilder<File?>(
              valueListenable: coverImage,
              builder: (_, file, widget) => Button(
                buttonText: 'Save Changes',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('validated');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
