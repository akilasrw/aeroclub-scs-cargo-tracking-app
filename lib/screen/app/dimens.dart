import 'package:flutter/material.dart';

// Dimens class should be registered as a singleton with 'GetIt'.
class Dimens {
  late final double deviceAspectRatio;
  late final double deviceHeight;
  late final double deviceScaleFactor;
  late final double deviceWidth;

  late final double heightUnit;
  late final double widthUnit;

  late final double horizontalPadding;
  late final double verticalPadding;

  void initDimens(
      BuildContext context, {
        double defaultHorizontalPadding = 5.0,
        double defaultVerticalPadding = 2.0,
      }) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    deviceHeight = height;
    deviceWidth = width;
    deviceAspectRatio = MediaQuery.of(context).size.aspectRatio;
    deviceScaleFactor = MediaQuery.of(context).textScaleFactor;

    widthUnit = width / 100.0;
    horizontalPadding = widthUnit * defaultHorizontalPadding;

    heightUnit = height / 100.0;
    verticalPadding = heightUnit * defaultVerticalPadding;
  }
}
