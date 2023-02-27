import 'package:flutter/material.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';

String data =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
    'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, '
    'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

class Insights extends StatelessWidget {
  const Insights({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Customer Insights", style: Fonts.appBarTitle),
      ),
      body: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          itemBuilder: (context, length) => Review(
              name: 'John Doe', stars: 4, date: '05 Jan \'23', data: data)),
    );
  }
}

class Review extends StatelessWidget {
  const Review(
      {super.key,
      required this.name,
      required this.stars,
      required this.date,
      required this.data});

  final String name;
  final int stars;
  final String date;
  final String data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Text(name, style: Fonts.heading.copyWith(fontSize: 14.0)),
              const _Ratings(stars: 4, iconSize: 16.0),
            ],
          ),
          Text(date, style: Fonts.simText.copyWith(fontSize: 10.0)),
        ],
      ),
      subtitle: Column(
        children: [
          Text(data, style: Fonts.hintText, textAlign: TextAlign.justify),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ReviewDetails())),
              child: Row(
                children: [
                  Text('View More ',
                      style: Fonts.simTextBlack
                          .copyWith(fontSize: 12.0, color: Palette.link)),
                  const Icon(Icons.arrow_forward, size: 12.0),
                ],
              ),
            ),
          )
        ],
      ),
      isThreeLine: true,
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      shape: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.24)),
      ),
    );
  }
}

class ReviewDetails extends StatelessWidget {
  const ReviewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Customer Insights", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(children: [
          Text('Overall Rating', style: Fonts.appBarTitle),
          const _Ratings(stars: 4),
          const SizedBox(height: 8.0),
          const _Ratings(text: 'Hygiene', stars: 1, iconSize: 20.0),
          const _Ratings(text: 'Taste', stars: 2, iconSize: 20.0),
          const _Ratings(text: 'Quality', stars: 3, iconSize: 20.0),
          const _Ratings(text: 'Ambience', stars: 4, iconSize: 20.0),
          const SizedBox(height: 24.0),
          Text(data, style: Fonts.hintText, textAlign: TextAlign.justify),
        ]),
      ),
    );
  }
}

class _Ratings extends StatelessWidget {
  const _Ratings({this.text, required this.stars, this.iconSize});

  final String? text;
  final int stars;
  final double? iconSize;

  Widget _buildStars() => Row(
        children: List.generate(
            5,
            (index) => Icon(
                  index < stars ? Icons.star : Icons.star_border_outlined,
                  color: index < stars ? const Color(0xFFECF01E) : null,
                  size: iconSize,
                )),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: text == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          text == null
              ? const SizedBox(width: 0)
              : Text(text!, style: Fonts.appBarTitle.copyWith(fontSize: 14.0)),
          _buildStars(),
        ],
      ),
    );
  }
}
