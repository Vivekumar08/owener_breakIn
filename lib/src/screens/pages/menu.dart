import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/accordion.dart';
import '../../components/button.dart';
import '../../models/example.dart';
import '../../models/menu.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
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
      ),
      body: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.iconsCol,
          child: const Icon(Icons.add, size: 32.0),
          onPressed: () => context.go(addNewItem),
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
                        ToggleButton(notifier: ValueNotifier(true)),
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
      ),
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
            UploadButton(notifier: coverImage, type: UploadButtonType.Image),
            const Spacer(),
            ValueListenableBuilder<File?>(
                valueListenable: coverImage,
                builder: (_, file, widget) => Button(
                    buttonText: 'Save Changes',
                    onPressed: file != null ? () {} : null))
          ],
        ),
      ),
    );
  }
}
