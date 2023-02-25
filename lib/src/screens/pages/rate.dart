import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/input_field.dart';
import '../../components/button.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';
import '../../style/palette.dart';
import '../../utils/images.dart';

class Rate extends StatelessWidget {
  const Rate({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Palette.white, size: 19.0),
        leadingWidth: 72.0,
        title: Text(
          "The Burger Club",
          style: Fonts.appBarTitle.copyWith(color: Palette.white),
        ),
      ),
      body: Column(
        children: [
          Images.menu,
          const SizedBox(height: 18.0),
          Text('Rate Place', style: Fonts.appBarTitle),
          const SizedBox(height: 8.0),
          const _Ratings(text: 'Hygiene'),
          const _Ratings(text: 'Taste'),
          const _Ratings(text: 'Quality'),
          const _Ratings(text: 'Ambience'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: InputField(
              inputText: 'Any Comments ?',
              hintText: 'Write comment',
              expands: true,
              height: 100,
              controller: controller,
            ),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
            child: Button(
                onPressed: () {
                  showMessageDialog(
                    context: context,
                    children: [
                      Images.happy,
                      const SizedBox(height: 12.0),
                      Text('Thank You for rating !',
                          style: Fonts.subHeading, textAlign: TextAlign.center),
                    ],
                  ).whenComplete(() => context.pop());
                },
                buttonText: "Submit Ratings"),
          ),
        ],
      ),
    );
  }
}

class _Ratings extends StatefulWidget {
  const _Ratings({required this.text});

  final String text;

  @override
  State<_Ratings> createState() => __RatingsState();
}

class __RatingsState extends State<_Ratings> {
  int i = 0;

  Widget _buildStars() => Row(
        children: List.generate(
            5,
            (index) => GestureDetector(
                onTap: () => setState(() {
                      i = index + 1;
                    }),
                child: Icon(
                  index < i ? Icons.star : Icons.star_border_outlined,
                  color: index < i ? const Color(0xFFECF01E) : null,
                ))),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.text, style: Fonts.appBarTitle.copyWith(fontSize: 14.0)),
          _buildStars(),
        ],
      ),
    );
  }
}
