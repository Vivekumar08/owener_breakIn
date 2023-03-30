import 'package:flutter/material.dart';
import '../style/fonts.dart';
import '../style/palette.dart';

class Dropdown extends StatefulWidget {
  const Dropdown(
      {super.key,
      required this.inputText,
      required this.items,
      required this.controller,
      this.validator});

  final String inputText;
  final List<String> items;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.items.isNotEmpty ? widget.items.first : '';
    widget.controller.text = dropdownValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(widget.inputText, style: Fonts.inputText),
        ),
        const SizedBox(height: 4.0),
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<String>(
            value: dropdownValue,
            menuMaxHeight: 280,
            style: Fonts.inputText.copyWith(color: Palette.text),
            validator: widget.validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: Palette.inputField,
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width: 1, color: Palette.stroke)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width: 1, color: Palette.stroke)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width: 1, color: Palette.stroke)),
              contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
            ),
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            borderRadius: BorderRadius.circular(8.0),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
                widget.controller.text = dropdownValue;
              });
            },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
