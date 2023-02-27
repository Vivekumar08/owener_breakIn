import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../style/fonts.dart';
import '../../utils/images.dart';

class CoverImageChanger extends ValueNotifier<bool> {
  ValueNotifier<bool> image = ValueNotifier(true);

  CoverImageChanger() : super(false);

  void removeImage() {
    debugPrint('image removed');
    image.value = false;
    notifyListeners();
  }

  void addImage() {
    debugPrint('image added');
    image.value = true;
    notifyListeners();
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({super.key});

  @override
  Widget build(BuildContext context) {
    final CoverImageChanger coverImageChanger = CoverImageChanger();
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
            ValueListenableBuilder(
              valueListenable: coverImageChanger,
              builder: (context, value, child) => coverImageChanger.image.value
                  ? Stack(
                      children: [
                        Images.dummy,
                        const Positioned(
                            top: 11.0,
                            right: 11.0,
                            child: Icon(Icons.close, size: 10)),
                        Positioned(
                          top: 8.0,
                          right: 8.0,
                          child: GestureDetector(
                            onTap: () => coverImageChanger.removeImage(),
                            child:
                                const Icon(Icons.circle_outlined, size: 16.0),
                          ),
                        )
                      ],
                    )
                  : GestureDetector(
                      onTap: () => coverImageChanger.addImage(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UploadButton(),
                          const SizedBox(height: 8.0),
                          Text('Only .png/.jpg format ',
                              style: Fonts.inputText.copyWith(fontSize: 10.0))
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
