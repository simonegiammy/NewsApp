import 'package:flutter/material.dart';

@immutable
class AppThemeData {
  const AppThemeData._();

  static ThemeData get() {
    const fontFamily = "Inter";
    return ThemeData(
      fontFamily: fontFamily,
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
            fontFamily: fontFamily,
            letterSpacing: -2,
            fontSize: 36,
            fontWeight: FontWeight.bold),
        titleMedium: Typography.blackMountainView.titleMedium!.copyWith(
            fontFamily: fontFamily,
            letterSpacing: -1,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        titleSmall: Typography.blackMountainView.titleSmall!.copyWith(
            fontFamily: fontFamily,
            letterSpacing: -1,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        bodyLarge: Typography.blackMountainView.bodyLarge!
            .copyWith(fontFamily: fontFamily, fontSize: 18, height: 1),
        bodyMedium: Typography.blackMountainView.bodyMedium!.copyWith(
          fontSize: 15,
          fontFamily: fontFamily,
        ),
        bodySmall: Typography.blackMountainView.bodySmall!.copyWith(
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}

List<Color> palette = [
  const Color(0xff235789),
  const Color(0xff72405c),
  const Color(0xffc1292e),
  const Color(0xfff1d302),
  const Color(0xff020100),
  const Color(0xffd97e18),
  const Color(0xff50664F),
];
