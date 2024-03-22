import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';

@immutable
class AppThemeData {
  const AppThemeData._();

  static List<BoxShadow> getShadow() {
    return [
      BoxShadow(
        color: darkTheme
            ? Colors.black.withOpacity(0.9)
            : Colors.grey.withOpacity(0.2),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ];
  }

  static ThemeData get() {
    const fontFamily = "Inter";
    return ThemeData(
      iconTheme: IconThemeData(color: darkTheme ? Colors.white : Colors.black),
      fontFamily: fontFamily,
      scaffoldBackgroundColor:
          darkTheme ? const Color(0xff1c1c1c) : Colors.white,
      textTheme: TextTheme(
        headlineLarge: Typography.blackMountainView.headlineLarge!.copyWith(
          fontFamily: fontFamily,
        ),
        headlineMedium: Typography.blackMountainView.headlineMedium!.copyWith(
          fontFamily: fontFamily,
        ),
        headlineSmall: Typography.blackMountainView.headlineSmall!.copyWith(
          fontFamily: fontFamily,
        ),
        displayLarge: Typography.blackMountainView.displayLarge!
            .copyWith(fontFamily: fontFamily, fontSize: 24),
        displayMedium: Typography.blackMountainView.displayMedium!
            .copyWith(fontFamily: fontFamily, fontSize: 20),
        displaySmall: Typography.blackMountainView.displaySmall!
            .copyWith(fontFamily: fontFamily, fontSize: 18),
        titleLarge: Typography.blackMountainView.titleLarge!.copyWith(
            color: !darkTheme ? Colors.black : Colors.white,
            fontFamily: fontFamily,
            letterSpacing: -2,
            fontSize: 36,
            fontWeight: FontWeight.bold),
        titleMedium: Typography.blackMountainView.titleMedium!.copyWith(
            color: !darkTheme ? Colors.black : Colors.white,
            fontFamily: fontFamily,
            letterSpacing: -1,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        titleSmall: Typography.blackMountainView.titleSmall!.copyWith(
            color: !darkTheme ? Colors.black : Colors.white,
            fontFamily: fontFamily,
            letterSpacing: -1,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        bodyLarge: Typography.blackMountainView.bodyLarge!.copyWith(
            color: !darkTheme ? Colors.black : Colors.white,
            fontFamily: fontFamily,
            fontSize: 18,
            height: 1),
        bodyMedium: Typography.blackMountainView.bodyMedium!.copyWith(
          fontSize: 18,
          letterSpacing: -1,
          fontFamily: fontFamily,
        ),
        bodySmall: Typography.blackMountainView.bodySmall!.copyWith(
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}

List<Color> tagPalette = [
  const Color(0xff235789),
  const Color(0xff72405c),
  const Color(0xffc1292e),
  const Color(0xfff1d302),
  const Color(0xff020100),
  const Color(0xffd97e18),
  const Color(0xff50664F),
];

List<Color> backgroundPalette = [
  const Color(0xfff94144),
  const Color(0xfff3722c),
  const Color(0xfff8961e),
  const Color(0xfff9844a),
  const Color(0xfff94144),
  const Color(0xfff9c74f),
  const Color(0xff90be6d),
  const Color(0xff43aa8b),
  const Color(0xff4d908e),
  const Color(0xff577590),
  const Color(0xff277da1)
];
