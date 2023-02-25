import 'package:flutter/material.dart';
import '../style/fonts.dart';
import '../style/palette.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      this.color,
      this.height = 56.0,
      this.expands = true,
      this.fontSize = 15,
      this.borderRadius = 8.0,
      this.padding})
      : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;
  final Color? color;
  final double height;
  final bool expands;
  final double fontSize;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expands ? double.maxFinite : null,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Palette.primary,
            padding: padding,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)))),
        onPressed: onPressed,
        child: Text(buttonText,
            style: Fonts.buttonText.copyWith(fontSize: fontSize)),
      ),
    );
  }
}

class BottomTextButton extends StatelessWidget {
  /// Bottom Text is a [Row] for a text & button
  ///
  /// Input [text] for text at [bottom-center]
  ///
  /// Input [buttonText] & [onTap] for button at [bottom-center]
  const BottomTextButton({Key? key, this.text, this.buttonText, this.onTap})
      : super(key: key);

  final String? text;
  final String? buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        text == null
            ? Container()
            : Text(text!,
                style: Fonts.hintText
                    .copyWith(fontSize: 14.0, color: Palette.iconsCol)),
        const SizedBox(width: 5.0),
        buttonText == null
            ? Container()
            : GestureDetector(
                onTap: onTap,
                child: Text(buttonText!,
                    style: Fonts.buttonText.copyWith(color: Palette.primary))),
      ],
    );
  }
}

class ChevBackButton extends StatelessWidget {
  const ChevBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
      child: Container(
        // 8.0 is default padding for an icon
        padding: const EdgeInsets.symmetric(
            vertical: 13.08 - 8.0, horizontal: 14.17 - 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Palette.stroke),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(Icons.chevron_left, size: 32.0, color: Palette.primary),
      ),
    );
  }
}
