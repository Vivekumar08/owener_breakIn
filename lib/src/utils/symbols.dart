import 'package:flutter/material.dart';

String _initialPath = 'assets/icons';

class Symbols {
  static Image get rate => Image.asset("$_initialPath/rate.png", scale: 4);
  static Image get home => Image.asset("$_initialPath/home.png", scale: 2);
  static Image get grid => Image.asset("$_initialPath/grid.png", scale: 2);
  static Image get passwordIcon =>
      Image.asset("$_initialPath/fluent_eye-20-filled.png", scale: 2);
  static Image get googleIcon =>
      Image.asset("$_initialPath/google_ic.png", scale: 2);
  static Image get facebookIcon =>
      Image.asset("$_initialPath/facebook_ic.png", scale: 2);
  static Image get phoneIcon =>
      Image.asset("$_initialPath/phone_ic.png", scale: 2);
  static Image get mailIcon =>
      Image.asset("$_initialPath/mail_ic.png", scale: 2);
  static Image get gmailIcon =>
      Image.asset("$_initialPath/gmail_ic.png", scale: 2);
  static Image get linkedinIcon =>
      Image.asset("$_initialPath/linkedin_ic.png", scale: 2);
  static Image get locationMark =>
      Image.asset("$_initialPath/Vector.png", scale: 2);
  static Image get profile =>
      Image.asset("$_initialPath/settings.png", scale: 1.6);
  static Image get searchIcon =>
      Image.asset("$_initialPath/search.png", scale: 2);
  static Image get canteen =>
      Image.asset("$_initialPath/samosa.png", width: 18);
  static Image get mess => Image.asset("$_initialPath/canteen.png", width: 18);
  static Image get microCafe =>
      Image.asset("$_initialPath/microCafe.png", width: 18);
  static Image get juiceCorner =>
      Image.asset("$_initialPath/juice.png", width: 18);
  static Image get teaStall =>
      Image.asset("$_initialPath/teaStall.png", width: 18);
  static Image get fruit => Image.asset("$_initialPath/fruit.png", width: 18);
  static Image get diary =>
      Image.asset("$_initialPath/diary_product.png", width: 18);
  static Image get ice => Image.asset("$_initialPath/iceCream.png", width: 18);
  static Image get others =>
      Image.asset("$_initialPath/foodStall.png", width: 18);
  static Image get edit => Image.asset("$_initialPath/edit.png", width: 18);
  static Image get star => Image.asset("$_initialPath/star.png", scale: 2);
  static Image get menu => Image.asset("$_initialPath/menu.png", scale: 2);
  static Image get menuBig => Image.asset("$_initialPath/menu.png");
}
