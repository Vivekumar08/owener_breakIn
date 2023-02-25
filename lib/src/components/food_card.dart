import 'package:flutter/material.dart';
import '../screens/pages/menu.dart';
import '../style/palette.dart';
import '../style/fonts.dart';
import '../utils/images.dart';
import '../utils/symbols.dart';

class FoodCard extends StatelessWidget {
  /// Creates the [FoodCard] with prerequisite UI
  ///
  /// If [isVisited] is set to `True` (default `False`), then [date] should be non-null
  ///
  const FoodCard(
      {super.key, this.isFavourite = false, this.isVisited = false, this.date})
      : assert((isVisited && date != null) || !isVisited);

  final bool isFavourite;
  final bool isVisited;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 1.0, color: Palette.stroke),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Images.food,
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Symbols.star,
                        const SizedBox(width: 7.0),
                        Text('4.1',
                            style: Fonts.simTextBlack.copyWith(fontSize: 16.0)),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Cluster Innovation Centre Canteen',
                      style: Fonts.otpText.copyWith(fontSize: 16.0),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isVisited
                            ? RichText(
                                text: TextSpan(
                                  text: 'Visited on ',
                                  style: Fonts.simTextBlack,
                                  children: [
                                    TextSpan(
                                      text: date!,
                                      style: Fonts.simTextBlack.copyWith(
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              )
                            : Text('North Indian, Snacks',
                                style: Fonts.simTextBlack),
                        isVisited
                            ? GestureDetector(
                                child: Text(
                                  'Rate Place',
                                  style: Fonts.subHeading.copyWith(
                                      color: Palette.link, fontSize: 14.0),
                                ),
                              )
                            : Row(
                                children: [
                                  const Icon(Icons.watch_later_outlined,
                                      size: 16.0),
                                  const SizedBox(width: 6.33),
                                  Text('15 mins',
                                      style: Fonts.simTextBlack
                                          .copyWith(fontSize: 14.0)),
                                  const SizedBox(width: 10.0),
                                  Text('|',
                                      style: Fonts.simTextBlack
                                          .copyWith(fontSize: 18.0)),
                                  const SizedBox(width: 8),
                                  Text('1 km',
                                      style: Fonts.simTextBlack
                                          .copyWith(fontSize: 14.0)),
                                ],
                              )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: CircleAvatar(
            radius: 16.0,
            backgroundColor: Palette.white,
            child: Icon(isFavourite ? Icons.favorite : Icons.favorite_border,
                size: 18.5, color: isFavourite ? Palette.red : Palette.text),
          ),
        ),
        Positioned(
          top: 192.0,
          right: 8.0,
          child: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Menu())),
            child: CircleAvatar(
              radius: 16.0,
              backgroundColor: Palette.iconsCol,
              child: Symbols.menu,
            ),
          ),
        ),
      ],
    );
  }
}
