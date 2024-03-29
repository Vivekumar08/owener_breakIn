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
import '../../style/loader.dart';
import '../../style/palette.dart';
import '../../utils/validators.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  ValueNotifier<bool> notifier = ValueNotifier(false);

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<FoodPlaceProvider>().foodPlaceModel == null) {
        context.read<FoodPlaceProvider>().getFoodPlace();
      }
    });
    context
        .read<FoodPlaceProvider>()
        .getPreference()
        .then((value) => notifier.value = value ?? false);
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
          child: RefreshIndicator(
            color: Palette.primary,
            displacement: 60.0,
            onRefresh: () => provider.getFoodPlaceFromServer(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics()
                  .applyTo(const ClampingScrollPhysics()),
              child:
                  provider.foodPlaceModel == null || provider.state.isLoading()
                      ? _buildLoading(_buildPage(
                          FoodPlaceModel.fromJson(menuExample),
                          loading: true))
                      : _buildPage(provider.foodPlaceModel!),
            ),
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
                : Container(
                    constraints: const BoxConstraints(minHeight: 300),
                    child: CachedNetworkImage(
                      imageUrl: '$fileInfo/${foodPlace.image}',
                      fadeInDuration: const Duration(milliseconds: 0),
                    ),
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
              Text(foodPlace.name,
                  style: Fonts.otpText.copyWith(fontSize: 16.0)),
              const SizedBox(height: 4.0),
              Text(foodPlace.location.address, style: Fonts.simTextBlack),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Menu', style: Fonts.otpText.copyWith(fontSize: 16.0)),
                  const Spacer(),
                  Text('Veg Only',
                      style: Fonts.appBarTitle.copyWith(fontSize: 12.0)),
                  const SizedBox(width: 8.0),
                  ToggleButton(
                    notifier: notifier,
                    onTap: (value) =>
                        context.read<FoodPlaceProvider>().setPreference(value),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              foodPlace.menu.isEmpty
                  ? Text('No Items Yet',
                      style: Fonts.otpText.copyWith(fontSize: 16.0))
                  : _buildMenu(foodPlace.menu),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenu(List<MenuCategory> menu) {
    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (context, value, _) {
        return Column(
          children: List.generate(
            menu.length,
            (index) => MenuAccordion(
              menu: menu[index],
              expansionCallback: (category, len, isExpanded) => context
                  .read<FoodPlaceProvider>()
                  .updateExpansionState(category: category, state: isExpanded),
              onEditItem: (category, item) =>
                  context.go('$modifyItem?category=$category', extra: item),
              onDeleteItem: (category, item) =>
                  context.read<FoodPlaceProvider>().deleteItem(item),
              onUpdateStatus: (category, item) => context
                  .read<FoodPlaceProvider>()
                  .updateItemStatus(status: !item.isAvailable, item: item),
              itemFilter: value ? (category, item) => item.isVeg : null,
            ),
          ),
        );
      },
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
    final provider = Provider.of<FoodPlaceProvider>(context);
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
                onPressed: file == null
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          showLoader(context);
                          provider.changeCoverImage(image: file).whenComplete(
                            () {
                              context.pop();
                              provider.state.isUpdated() ? context.pop() : null;
                            },
                          );
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
