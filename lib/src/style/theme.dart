import 'package:flutter/material.dart';
import 'palette.dart';
import 'fonts.dart';

final ThemeData theme = ThemeData(
  // Scaffold Background Color
  scaffoldBackgroundColor: Palette.white,

  // App Bar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: Palette.white,
    foregroundColor: Palette.text,
    elevation: 0,
    iconTheme: IconThemeData(color: Palette.iconsCol, size: 19.0),
    titleTextStyle: Fonts.textButton.copyWith(color: Palette.text),
    titleSpacing: 4.0,
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: Palette.text, size: 24.0),
  ),

  // Pop-Up Menu Theme
  popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Palette.stroke,
      textStyle: Fonts.simText.copyWith(fontSize: 10.0, color: Colors.black),
      position: PopupMenuPosition.under),

  // Bottom Navbar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Palette.text,
    selectedLabelStyle:
        Fonts.medText.copyWith(color: Palette.white, fontSize: 10.0),
    unselectedLabelStyle:
        Fonts.medText.copyWith(color: Palette.white, fontSize: 10.0),
  ),
);
