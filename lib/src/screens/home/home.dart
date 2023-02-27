import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide MenuBar;
import 'package:go_router/go_router.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../utils/images.dart';
import '../../utils/symbols.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _buildOptions(
          Image image, String text, String route, BuildContext context) =>
      GestureDetector(
        onTap: () => context.go(route),
        child: Column(children: [
          image,
          const SizedBox(height: 8.0),
          Text(text, style: Fonts.otpText.copyWith(fontSize: 14.0))
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(Icons.location_on_outlined),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('376 Ground Floor, Mukherjee Nagar,',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor.clamp(1, 1.2)),
                const SizedBox(width: 12.0),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
            Text('Delhi, India, 110009',
                textScaleFactor:
                    MediaQuery.of(context).textScaleFactor.clamp(1, 1.2)),
          ],
        ),
        leadingWidth: 40.0,
        actions: [
          GestureDetector(
              onTap: () => context.go(profile), child: Symbols.profile),
          const SizedBox(width: 24.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cluster Innovation Centre',
                  style: Fonts.otpText.copyWith(fontSize: 14.0),
                ),
                SizedBox(
                  height: 20.0,
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child:
                          CupertinoSwitch(value: true, onChanged: (value) {})),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOptions(Images.mMenu, 'Manage Menu', menu, context),
                _buildOptions(
                    Images.insights, 'Customer Insights', insights, context)
              ],
            )
          ],
        ),
      ),
    );
  }
}
