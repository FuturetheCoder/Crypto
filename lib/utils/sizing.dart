// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
//using  XMargin to replace sizedBox  for width size
class XMargin extends StatelessWidget {
  final double x;
  const XMargin(this.x);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x);
  }
}
//using  YMargin to replace sizedBox  for height size
class YMargin extends StatelessWidget {
  final double y;
  const YMargin(this.y);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y);
  }
}

//A custom class for handling text size, margin size and other responsiveness related issues
class Sizing {
  // static keyword included so you can call this method without instantiating an object of it like so :
  // Config.yMargin(context, 2)
  static double yMargin(BuildContext context, double height) {
    double screenHeight = MediaQuery.of(context).size.height / 100;
    return height * screenHeight;
  }

  static double xMargin(BuildContext context, double width) {
    double screenWidth = MediaQuery.of(context).size.width / 100;
    return width * screenWidth;
  }

  static double textSize(BuildContext context, double textSize) {
    double screenWidth = MediaQuery.of(context).size.width / 100;
    return textSize * screenWidth;
  }
}


class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double ScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate width as per screen size
double ScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
