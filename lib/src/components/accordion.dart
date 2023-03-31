import 'dart:async';
import 'package:flutter/material.dart';
import '../models/menu.dart';
import '../style/fonts.dart';
import '../style/palette.dart';
import 'button.dart';

typedef ExpansionCallback = Future<void> Function(
    String category, int items, bool state);
typedef MenuOperationCallback = FutureOr<void> Function(
    String category, MenuItem item);
typedef ItemFilterCallback = bool Function(String category, MenuItem item);

class Accordion extends StatefulWidget {
  const Accordion({
    Key? key,
    required this.menu,
    this.expansionCallback,
    this.onEditItem,
    this.onDeleteItem,
    this.onUpdateStatus,
    this.itemFilter,
  }) : super(key: key);

  final MenuCategory menu;
  final ExpansionCallback? expansionCallback;
  final MenuOperationCallback? onEditItem;
  final MenuOperationCallback? onDeleteItem;
  final MenuOperationCallback? onUpdateStatus;
  final ItemFilterCallback? itemFilter;

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  Future<void> expansionCallback(String category, int items) async {
    setState(() {
      widget.menu.isExpanded = !widget.menu.isExpanded;
    });
    await widget.expansionCallback
        ?.call(category, items, widget.menu.isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AccordionHeader(
            title: '${widget.menu.name} (${widget.menu.items?.length})',
            isExpanded: widget.menu.isExpanded,
            onPressed: () async => await expansionCallback(
                widget.menu.name, widget.menu.items?.length ?? 0)),
        widget.menu.isExpanded
            ? Column(
                children: [
                  for (MenuItem item in widget.menu.items!)
                    _AccordionBody(
                      item: item,
                      category: widget.menu.name,
                      onEditItem: widget.onEditItem,
                      onDeleteItem: widget.onDeleteItem,
                      onUpdateStatus: widget.onUpdateStatus,
                      itemFilter: widget.itemFilter,
                    )
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
      {Key? key,
      required this.item,
      required this.category,
      this.onEditItem,
      this.onDeleteItem,
      this.onUpdateStatus,
      this.itemFilter})
      : super(key: key);

  final MenuItem item;
  final String category;
  final MenuOperationCallback? onEditItem;
  final MenuOperationCallback? onDeleteItem;
  final MenuOperationCallback? onUpdateStatus;
  final ItemFilterCallback? itemFilter;

  @override
  Widget build(BuildContext context) {
    return itemFilter == null || itemFilter!.call(category, item)
        ? ListTile(
            title: Text(item.name,
                style: Fonts.textButton
                    .copyWith(color: Palette.text, height: 1.11)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.details,
                    style: Fonts.simTextBlack.copyWith(letterSpacing: 0)),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onEditItem?.call(category, item),
                      child: Text('Edit Item',
                          style:
                              Fonts.simTextBlack.copyWith(color: Palette.link)),
                    ),
                    const SizedBox(width: 16.0),
                    GestureDetector(
                      onTap: () => onDeleteItem?.call(category, item),
                      child: Text('Delete Item',
                          style: Fonts.simTextBlack
                              .copyWith(color: Palette.primary)),
                    )
                  ],
                )
              ],
            ),
            isThreeLine: true,
            leading: item.isVeg
                ? Stack(
                    alignment: Alignment.center,
                    children: const [
                      Icon(Icons.crop_square_sharp,
                          color: Colors.green, size: 30),
                      Icon(Icons.circle, color: Colors.green, size: 12),
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: const [
                      Icon(Icons.crop_square_sharp,
                          color: Colors.red, size: 36),
                      Icon(Icons.circle, color: Colors.red, size: 14),
                    ],
                  ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rs. ${item.price}',
                    style: Fonts.otpText.copyWith(fontSize: 16.0)),
                ToggleButton(
                  notifier: ValueNotifier(item.isAvailable),
                  onTap: () => onUpdateStatus?.call(category, item),
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
          )
        : Container();
  }
}
