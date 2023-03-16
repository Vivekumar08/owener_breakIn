import 'package:flutter/material.dart';

String _initialPath = 'assets/images';

class Images {
  static Image get onboarding =>
      Image.asset("$_initialPath/onboarding.png", scale: 4);
  static Image get success =>
      Image.asset("$_initialPath/Successmark.png", scale: 4);
  static Image get bg => Image.asset("$_initialPath/map.png", scale: 4);
  static Image get insights =>
      Image.asset("$_initialPath/customer_insights.png", scale: 2);
  static Image get mMenu =>
      Image.asset("$_initialPath/manager_menu.png", scale: 2);
  static Image get menu => Image.asset("$_initialPath/menu.png", scale: 0.5);
  static Image get happy => Image.asset("$_initialPath/happy.png", height: 40);
  static Image get sad => Image.asset("$_initialPath/sad.png", height: 40);
  static Image get dummy => Image.asset("$_initialPath/dummy.png", scale: 2);
}
