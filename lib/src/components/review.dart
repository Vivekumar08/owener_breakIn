import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/rate.dart';
import '../router/constants.dart';
import '../style/fonts.dart';
import '../style/palette.dart';

class Review extends StatelessWidget {
  const Review({super.key, required this.rate});

  final Rate rate;

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
              Text(rate.name, style: Fonts.heading.copyWith(fontSize: 14.0)),
              RatingsFactor(stars: rate.overallRating, iconSize: 16.0),
            ],
          ),
          Text(rate.date, style: Fonts.simText.copyWith(fontSize: 10.0)),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rate.comment.isEmpty
              ? Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                )
              : Text(rate.comment,
                  style: Fonts.hintText, textAlign: TextAlign.justify),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: GestureDetector(
              onTap: () => context.push(details, extra: rate),
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

class RatingsFactor extends StatelessWidget {
  const RatingsFactor(
      {super.key, this.text, required this.stars, this.iconSize = 20.0})
      : assert(stars is int || stars is double);

  final String? text;
  final dynamic stars;
  final double iconSize;

  Widget _buildStars() => stars is int
      ? Row(
          children: List.generate(
            5,
            (index) => Icon(
              index < stars ? Icons.star : Icons.star_border_outlined,
              color: index < stars ? const Color(0xFFECF01E) : null,
              size: iconSize,
            ),
          ),
        )
      : stars is double
          ? Row(
              children: [
                for (int i = 1; i < stars; i++)
                  Icon(Icons.star,
                      color: const Color(0xFFECF01E), size: iconSize),
                ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (Rect rect) => LinearGradient(
                    stops: [0, stars - stars.floor(), stars - stars.floor()],
                    colors: [
                      const Color(0xFFECF01E),
                      const Color(0xFFECF01E),
                      const Color(0xFFECF01E).withOpacity(0),
                    ],
                  ).createShader(rect),
                  child: Icon(Icons.star, size: iconSize, color: Colors.white),
                ),
              ],
            )
          : Container();

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
