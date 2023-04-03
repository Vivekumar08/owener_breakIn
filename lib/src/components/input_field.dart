import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../style/palette.dart';
import '../style/fonts.dart';
import '../utils/symbols.dart';
import '../utils/validators.dart';

// Basic Input Field
class InputField extends StatelessWidget {
  /// Creates the [TextField] with prerequisite UI
  ///
  /// If [expands] is set to `True` (default `False`), then [height] should be
  /// non-null to prevent overflow
  ///
  const InputField({
    super.key,
    required this.inputText,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.readOnly,
    this.isPhone = false,
    this.expands = false,
    this.height,
    this.validator,
    this.autofillHints,
  }) : assert(
          (!expands && height == null) || (expands && height != null),
          'height must be non-null, when expands is true.',
        );

  final String inputText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool isPhone;
  final bool expands;
  final double? height;
  final String? Function(String?)? validator;
  final String? autofillHints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(inputText, style: Fonts.inputText),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: SizedBox(
            height: height == null ? null : height! + 12,
            child: TextFormField(
              controller: controller,
              readOnly: readOnly ?? false,
              style: Fonts.inputText.copyWith(color: Palette.text),
              textAlignVertical: TextAlignVertical.top,
              expands: expands,
              maxLines: expands ? null : 1,
              keyboardType: isPhone ? TextInputType.number : keyboardType,
              validator: validator,
              autofillHints: autofillHints == null ? null : [autofillHints!],
              decoration: InputDecoration(
                filled: true,
                helperText: expands ? ' ' : null,
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
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
                hintText: hintText,
                hintStyle: Fonts.hintText,
              ),
              onTap: () {
                if (FocusScope.of(context).isFirstFocus &&
                    !controller.text.contains('+91') &&
                    isPhone) {
                  controller.text = '+91 ${controller.text}';
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

// Search Field
class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hintText,
    this.controller,
    this.onTap,
    this.readOnly = false,
  });
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22.0, 16.0, 22.0, 4.0),
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
            color: Palette.stroke,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 1, color: Palette.stroke)),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          style: Fonts.inputText.copyWith(color: Palette.text),
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Palette.inputField,
            prefixIcon: Icon(
              Icons.search,
              color: Palette.iconsCol,
            ),
            hintText: hintText,
            hintStyle: Fonts.simText.copyWith(color: Palette.greyNormal),
            border: InputBorder.none,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

// Otp Field
class OtpField extends StatefulWidget {
  const OtpField({
    Key? key,
    required this.length,
    this.height = 60.0,
    this.space = 17.0,
    required this.controller,
  }) : super(key: key);

  final int length;
  final double? height;
  final double? space;
  final TextEditingController controller;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late List<TextEditingController> controllerList;

  @override
  void initState() {
    controllerList =
        List.generate(widget.length, (index) => TextEditingController());
    super.initState();
  }

  String getOtp() {
    String otp = '';
    for (var controller in controllerList) {
      otp += controller.text;
    }
    return otp;
  }

  @override
  void dispose() {
    for (var c in controllerList) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    final width = mQ.size.width - widget.space! * (widget.length - 1) - 44;
    return Row(
      children: List.generate(
        widget.length,
        (index) => Row(
          children: [
            SizedBox(
              height: widget.height,
              width: width / widget.length,
              child: TextField(
                controller: controllerList[index],
                keyboardType: TextInputType.number,
                autofocus: index == 0 ? true : false,
                maxLength: 1,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: Fonts.otpText,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: controllerList[index].text.isEmpty
                      ? Palette.inputField
                      : Palette.white,
                  border: controllerList[index].text.isEmpty
                      ? OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 1.2, color: Palette.stroke))
                      : OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 1.2, color: Palette.otp)),
                  enabledBorder: controllerList[index].text.isEmpty
                      ? OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 1.2, color: Palette.stroke))
                      : OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 1.2, color: Palette.otp)),
                  focusedBorder: controllerList[index].text.isEmpty
                      ? OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 1.2, color: Palette.stroke))
                      : OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 1.2, color: Palette.otp)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                ),
                onChanged: (value) {
                  if (value.length == 1 && index != widget.length - 1) {
                    FocusScope.of(context).nextFocus();
                  }
                  controllerList[index].text = value;
                  widget.controller.text = getOtp();
                  if (controllerList.last.text.isNotEmpty) {
                    FocusScope.of(context).unfocus();
                  }
                  setState(() {});
                },
              ),
            ),
            index != widget.length - 1
                ? const SizedBox(width: 17.0)
                : Container(),
          ],
        ),
      ),
    );
  }
}

// Password Field
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.inputText,
    required this.hintText,
    required this.controller,
    this.validator = passwordValidation,
  });

  final String inputText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(widget.inputText, style: Fonts.inputText),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: TextFormField(
            controller: widget.controller,
            style: Fonts.inputText.copyWith(color: Palette.text),
            obscureText: isObscure,
            obscuringCharacter: '●',
            textAlignVertical: TextAlignVertical.top,
            validator: widget.validator,
            decoration: InputDecoration(
              filled: true,
              suffixIcon: GestureDetector(
                onTap: () => setState(() {
                  isObscure = !isObscure;
                }),
                child: isObscure
                    ? CustomPaint(
                        foregroundPainter: _LinePainter(),
                        child: Symbols.passwordIcon)
                    : Symbols.passwordIcon,
              ),
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
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              hintText: widget.hintText,
              hintStyle: Fonts.hintText,
            ),
          ),
        ),
      ],
    );
  }
}

class _LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var greyLine = Paint()
      ..color = Palette.iconsCol
      ..strokeWidth = 1.2;

    canvas.drawLine(
        Offset(
          3 * size.width / 8,
          3 * size.height / 8,
        ),
        Offset(
          5 * size.width / 8,
          5 * size.height / 8,
        ),
        greyLine);

    var whiteLine = Paint()
      ..color = Palette.white
      ..strokeWidth = 1.0;

    canvas.drawLine(
        Offset(
          3 * size.width / 8 + 1,
          3 * size.height / 8,
        ),
        Offset(
          5 * size.width / 8 + 1,
          5 * size.height / 8,
        ),
        whiteLine);
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => false;
}
