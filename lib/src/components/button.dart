import 'dart:io' show File;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:url_launcher/url_launcher.dart';
import '../style/bottom_sheet.dart';
import '../style/fonts.dart';
import '../style/palette.dart';
import '../utils/symbols.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.color,
      this.height = 56.0,
      this.expands = true,
      this.fontSize = 15,
      this.borderRadius = 8.0,
      this.padding})
      : super(key: key);

  final String buttonText;
  final VoidCallback? onPressed;
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
        child: Text(
          buttonText,
          style: Fonts.buttonText.copyWith(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
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
        const SizedBox(width: 2.0),
        buttonText == null
            ? Container()
            : InkWell(
                borderRadius: BorderRadius.circular(4.0),
                radius: 4.0,
                onTap: onTap,
                customBorder: Border.all(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 5.0),
                  child: Text(buttonText!,
                      style: Fonts.buttonText.copyWith(color: Palette.primary)),
                ),
              ),
      ],
    );
  }
}

class ChevBackButton extends StatelessWidget {
  const ChevBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
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

class UploadFormButton extends FormField<File?> {
  UploadFormButton(
      {super.key,
      required ValueNotifier<File?> notifier,
      UploadButtonType? type,
      AutovalidateMode? autovalidateMode,
      void Function(File?)? onChanged,
      super.validator})
      : super(
          initialValue: notifier.value,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (state) {
            final BoxBorder? border = state.hasError
                ? Border.all(color: Theme.of(state.context).colorScheme.error)
                : null;

            void onChangedHandler(File? value) {
              state.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            return UploadButton(
              notifier: notifier,
              type: type,
              border: border,
              onChanged: onChangedHandler,
              errorText: state.errorText,
            );
          },
        );

  @override
  FormFieldState<File?> createState() => _UploadFormButtonState();
}

class _UploadFormButtonState extends FormFieldState<File?> {}

// ignore: constant_identifier_names
enum UploadButtonType { Custom, Doc, Image }

class UploadButton extends StatefulWidget {
  /// Size limit is in kiloBytes (default 1000 kb)
  const UploadButton({
    super.key,
    required this.notifier,
    this.type = UploadButtonType.Custom,
    this.border,
    this.onChanged,
    this.errorText,
  });

  final ValueNotifier<File?> notifier;
  final UploadButtonType? type;
  final BoxBorder? border;
  final void Function(File?)? onChanged;
  final String? errorText;

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  Future<void> uploadFile({bool gallery = false}) async {
    try {
      widget.type == UploadButtonType.Custom
          ? Navigator.of(context).pop()
          : null;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: gallery ? FileType.media : FileType.custom,
        allowedExtensions: gallery ? null : ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        widget.notifier.value = file;
        widget.onChanged?.call(file);
      } else {}
    } catch (_) {}
  }

  Widget render(File file) {
    String? mimeType = lookupMimeType(file.path);
    if (mimeType != null && mimeType.split("/").first == 'image') {
      return SizedBox(height: 80, width: 80, child: Image.file(file));
    }

    return Stack(
      children: [
        Icon(Icons.insert_drive_file, color: Palette.greyNormal, size: 80),
        Positioned(
            top: 40, left: 28, child: Text('PDF', style: Fonts.buttonText))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<File?>(
      valueListenable: widget.notifier,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            value != null
                ? Stack(children: [
                    GestureDetector(
                        onTap: () =>
                            launchUrl(Uri.file(widget.notifier.value!.path)),
                        child: render(widget.notifier.value!)),
                    const Positioned(
                        top: 7.0,
                        right: 11.0,
                        child: Icon(Icons.close_rounded, size: 10)),
                    Positioned(
                      top: 4.0,
                      right: 8.0,
                      child: GestureDetector(
                        onTap: () {
                          try {
                            widget.notifier.value?.deleteSync();
                            widget.notifier.value = null;
                          } catch (_) {}
                        },
                        child: const Icon(Icons.circle_outlined, size: 16.0),
                      ),
                    )
                  ])
                : GestureDetector(
                    onTap: () => widget.type == UploadButtonType.Doc
                        ? uploadFile()
                        : widget.type == UploadButtonType.Image
                            ? uploadFile(gallery: true)
                            : showCustomBottomSheet(
                                context: context,
                                children: <CustomBottomSheetChild>[
                                    CustomBottomSheetChild(
                                      title: 'File',
                                      icon: Icons.upload_file_rounded,
                                      onTap: () async => uploadFile(),
                                    ),
                                    CustomBottomSheetChild(
                                      title: 'Gallery',
                                      icon: Icons.image,
                                      onTap: () async =>
                                          uploadFile(gallery: true),
                                    ),
                                  ]),
                    child: Container(
                      height: 80.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Palette.stroke,
                        borderRadius: BorderRadius.circular(8.0),
                        border: widget.border,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(flex: 2, child: Symbols.upload),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Drag & Drop files or Upload ',
                                style: Fonts.hintText
                                    .copyWith(color: Palette.text),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'here',
                                    style: Fonts.hintText
                                        .copyWith(color: Palette.link),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            widget.errorText == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 7.0, 0, 0),
                    child: Text(
                      widget.errorText!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  )
          ],
        );
      },
    );
  }
}

class ToggleButton extends StatelessWidget {
  const ToggleButton({super.key, required this.notifier, this.onTap});

  final ValueNotifier<bool> notifier;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0,
      child: FittedBox(
        fit: BoxFit.cover,
        child: ValueListenableBuilder<bool>(
          valueListenable: notifier,
          builder: (context, state, _) {
            return CupertinoSwitch(
              value: state,
              onChanged: (value) {
                onTap?.call();
                notifier.value = value;
              },
            );
          },
        ),
      ),
    );
  }
}
