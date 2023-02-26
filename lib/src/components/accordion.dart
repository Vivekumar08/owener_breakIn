import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/menu.dart';
import '../router/constants.dart';
import '../style/fonts.dart';
import '../style/palette.dart';

class Accordion extends StatefulWidget {
  const Accordion({Key? key, required this.menu}) : super(key: key);

  final MenuCategory menu;

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  void expansionCallback(int index, bool isExpanded) => setState(() {
        widget.menu.isExpanded = !widget.menu.isExpanded;
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AccordionHeader(
            title: widget.menu.menuCategory,
            isExpanded: widget.menu.isExpanded,
            onPressed: () => expansionCallback(0, widget.menu.isExpanded)),
        widget.menu.isExpanded
            ? Column(
                children: [
                  for (MenuItem item in widget.menu.menuItems)
                    _AccordionBody(
                        menuItem: item, menuCategory: widget.menu.menuCategory)
                ],
              )
            : Container()
      ],
    );
  }
}

class _AccordionHeader extends StatelessWidget {
  const _AccordionHeader(
      {Key? key,
      required this.title,
      required this.isExpanded,
      required this.onPressed})
      : super(key: key);

  final String title;
  final bool isExpanded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Fonts.buttonText.copyWith(color: Palette.text)),
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      dense: true,
      trailing: Icon(
          isExpanded
              ? Icons.keyboard_arrow_up_outlined
              : Icons.keyboard_arrow_down_outlined,
          color: Palette.iconsCol),
      shape: isExpanded
          ? null
          : UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.24)),
            ),
      onTap: onPressed,
    );
  }
}

class _AccordionBody extends StatelessWidget {
  const _AccordionBody(
      {Key? key, required this.menuItem, required this.menuCategory})
      : super(key: key);

  final MenuItem menuItem;
  final String menuCategory;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(menuItem.item,
          style: Fonts.textButton.copyWith(color: Palette.text, height: 1.11)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(menuItem.itemDetails,
              style: Fonts.simTextBlack.copyWith(letterSpacing: 0)),
          const SizedBox(height: 8.0),
          Row(
            children: [
              GestureDetector(
                onTap: () => context.go(
                    '$modifyItem/${menuCategory.split(' ').first}',
                    extra: menuItem),
                child: Text('Edit Item',
                    style: Fonts.simTextBlack.copyWith(color: Palette.link)),
              ),
              const SizedBox(width: 16.0),
              Text('Delete Item',
                  style: Fonts.simTextBlack.copyWith(color: Palette.primary))
            ],
          )
        ],
      ),
      isThreeLine: true,
      leading: menuItem.isVeg
          ? Stack(
              alignment: Alignment.center,
              children: const [
                Icon(Icons.crop_square_sharp, color: Colors.green, size: 30),
                Icon(Icons.circle, color: Colors.green, size: 12),
              ],
            )
          : Stack(
              alignment: Alignment.center,
              children: const [
                Icon(Icons.crop_square_sharp, color: Colors.red, size: 36),
                Icon(Icons.circle, color: Colors.red, size: 14),
              ],
            ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Rs. ${menuItem.price}',
              style: Fonts.otpText.copyWith(fontSize: 16.0)),
          SizedBox(
            height: 20.0,
            child: FittedBox(
                fit: BoxFit.cover,
                child: CupertinoSwitch(value: true, onChanged: (value) {})),
          ),
        ],
      ),
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      shape: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.24)),
      ),
      visualDensity: const VisualDensity(horizontal: 0, vertical: 2),
      dense: true,
    );
  }
}
