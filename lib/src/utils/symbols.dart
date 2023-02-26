import 'package:flutter/material.dart';

String _initialPath = 'assets/icons';

class Symbols {
  static Image get rate => Image.asset("$_initialPath/rate.png", scale: 4);
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
  static Image get edit => Image.asset("$_initialPath/edit.png", width: 18);
  static Image get star => Image.asset("$_initialPath/star.png", scale: 2);
  static Image get upload => Image.asset("$_initialPath/upload.png", scale: 2);
}
