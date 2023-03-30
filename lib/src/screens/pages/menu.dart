import 'dart:io' show File, Platform;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/accordion.dart';
import '../../components/button.dart';
import '../../models/example.dart';
import '../../models/food_place.dart';
import '../../models/menu.dart';
import '../../providers/providers.dart';
import '../../router/constants.dart';
import '../../services/constants.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<FoodPlaceProvider>().foodPlaceModel == null) {
        context.read<FoodPlaceProvider>().getFoodPlace();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodPlaceProvider>(
      builder: (context, provider, _) => Scaffold(
        floatingActionButton: provider.foodPlaceModel == null
            ? _buildLoading(
                FloatingActionButton(
                  backgroundColor: Palette.iconsCol,
                  elevation: 0,
                  onPressed: () => context.go(addNewItem),
                  child: const Icon(Icons.add, size: 32.0),
                ),
              )
            : FloatingActionButton(
                backgroundColor: Palette.iconsCol,
                onPressed: () => context.go(addNewItem),
                child: const Icon(Icons.add, size: 32.0),
              ),
        body: SafeArea(
          top: Platform.isAndroid, // No top safe area for IOS
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics()
                .applyTo(const ClampingScrollPhysics()),
            child: provider.foodPlaceModel == null
                ? _buildLoading(_buildPage(FoodPlaceModel.fromJson(menuExample),
                    loading: true))
                : _buildPage(provider.foodPlaceModel!),
          ),
        ),
      ),
    );
  }

  Shimmer _buildLoading(Widget child) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: AbsorbPointer(
        child: child,
      ),
    );
  }

  Column _buildPage(FoodPlaceModel foodPlace, {bool? loading}) {
    return Column(
      children: [
        Stack(
          children: [
            foodPlace.image.isEmpty
                ? Container(height: 300, color: Palette.white)
                : CachedNetworkImage(
                    imageUrl: '$fileInfo/${foodPlace.image}',
                    fadeInDuration: const Duration(milliseconds: 0),
                  ),
            AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Palette.white, size: 19.0),
              leadingWidth: 72.0,
              title: Text(foodPlace.name,
                  style: Fonts.appBarTitle.copyWith(color: Palette.white)),
              actions: [
                PopupMenuButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.more_vert_outlined, color: Palette.white),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
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
                  loading == true
                      // Builds Loader for Ratings
                      ? Container(
                          height: 20.0,
                          width: 32.0,
                          decoration: BoxDecoration(
                            color: Palette.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        )
                      : foodPlace.rating == null
                          ? Text('No Ratings',
                              style:
                                  Fonts.simTextBlack.copyWith(fontSize: 16.0))
                          : Text(foodPlace.rating.toString(),
                              style:
                                  Fonts.simTextBlack.copyWith(fontSize: 16.0)),
                  const Spacer(),
                  const Icon(Icons.share_outlined),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(foodPlace.name,
                  style: Fonts.otpText.copyWith(fontSize: 16.0)),
              const SizedBox(height: 4.0),
              Text(foodPlace.location.address, style: Fonts.simTextBlack),
              const SizedBox(height: 16.0),
              foodPlace.menu.isEmpty
                  ? Text('No Items Yet',
                      style: Fonts.otpText.copyWith(fontSize: 16.0))
                  : _buildMenu(foodPlace.menu),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildMenu(List<MenuCategory> menu) {
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
        for (MenuCategory category in menu) Accordion(menu: category)
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
