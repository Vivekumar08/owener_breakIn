import 'package:flutter/material.dart';
import '../style/palette.dart';

const String _urbReg = "Urbanist";
const String _urbBold = "Urbanist_Bold";
const String _urbSemiBold = "Urbanist_SemiBold";
const String _urbMed = "Urbanist_Medium";
const String _urbLight = "Urbanist_Light";

class Fonts {
  static TextStyle get title => TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: _urbBold,
      height: 1.3,
      letterSpacing: -1,
      color: Palette.primary);

  static TextStyle get heading => TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontFamily: _urbBold,
      height: 1.3,
      letterSpacing: -1,
      color: Palette.text);

  static TextStyle get subHeading => TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: _urbBold,
      height: 1.3,
      letterSpacing: -0.5,
      color: Palette.primary);

  static TextStyle get simText => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.3,
      fontFamily: _urbReg,
      color: Palette.primary);

  static TextStyle get simTextBlack => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: _urbReg,
      letterSpacing: -0.2,
      color: Palette.text);

  static TextStyle get medText => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: _urbMed,
      height: 1.5,
      color: Palette.iconsCol);

  static TextStyle get medTextBlack => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: _urbMed,
      height: 1.5,
      color: Palette.text);

  static TextStyle get lightText => TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontFamily: _urbLight,
      color: Palette.text);

  static TextStyle get buttonText => TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      fontFamily: _urbSemiBold,
      color: Palette.white);

  static TextStyle get inputText => TextStyle(
      fontSize: 14,
      height: 1.25,
      fontWeight: FontWeight.w500,
      fontFamily: _urbMed,
      color: Palette.primary);

  static TextStyle get hintText => TextStyle(
      fontSize: 12,
      height: 1.25,
      fontWeight: FontWeight.w500,
      fontFamily: _urbMed,
      color: Palette.greyNormal);

  static TextStyle get textButton => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: _urbSemiBold,
      color: Palette.iconsCol);

  static TextStyle get appBarTitle => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: _urbSemiBold,
      color: Palette.text);

  static TextStyle get otpText => TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontFamily: _urbBold,
      color: Palette.text);

  static TextStyle get poppins => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins",
      color: Palette.text);
}
