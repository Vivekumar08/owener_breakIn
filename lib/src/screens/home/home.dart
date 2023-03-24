import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../models/list_place.dart';
import '../../providers/providers.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../style/message_dialog.dart';
import '../../utils/images.dart';
import '../../utils/symbols.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<bool> notifier = ValueNotifier(true);

  @override
  void initState() {
    final provider = Provider.of<ListPlaceProvider>(context, listen: false);
    provider.getListPlace().whenComplete(
        () => _buildMessage(provider.listPlaceModel?.status, context));
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  void _buildMessage(ListPlaceStatus? status, BuildContext context) {
    if (status == null) {
      context.go(listPlace);
    } else {
      setState(() {});
      if (status == ListPlaceStatus.verifying) {
        showMessageDialog(dismissible: false, context: context, children: [
          Text(
            'Your Document have been submitted successfully . As soon '
            'as our team verifies your credentials, we will contact you.',
            style: Fonts.simText,
          )
        ]);
      } else if (status == ListPlaceStatus.unverified) {
        showMessageDialog(dismissible: false, context: context, children: [
          Text(
            'For certain issues, you haven\'t been verified. '
            'For further concerns, you can contact us.',
            style: Fonts.simText,
          )
        ]);
      }
    }
  }

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
    return Consumer<ListPlaceProvider>(builder: (context, provider, _) {
      final model = provider.listPlaceModel;
      return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(Icons.location_on_outlined),
          ),
          title: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: model != null
                          ? Text(model.address,
                              maxLines: 2,
                              textScaleFactor: MediaQuery.of(context)
                                  .textScaleFactor
                                  .clamp(1, 1.2))
                          : Container(),
                    ),
                    const SizedBox(width: 12.0),
                  ],
                ),
              ],
            ),
          ),
          leadingWidth: 40.0,
          actions: [
            GestureDetector(
                onTap: () => context.go(profile), child: Symbols.profile),
            const SizedBox(width: 8.0),
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
                  model != null
                      ? Text(
                          model.placeName,
                          style: Fonts.otpText.copyWith(fontSize: 14.0),
                        )
                      : Container(),
                  SizedBox(
                    height: 20.0,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: ToggleButton(notifier: notifier),
                    ),
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
    });
  }
}
