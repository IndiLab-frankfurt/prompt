import 'package:flutter/material.dart';

class UIHelper {
  static const double _verticalSpaceSmall = 10.0;
  static const double _verticalSpaceMedium = 20.0;
  static const double _verticalSpaceLarge = 50.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _horizontalSpaceSmall = 10.0;
  static const double _horizontalSpaceMedium = 20.0;
  static const double _horizontalSpaceLarge = 50.0;

  ThemeData darkTheme = ThemeData.dark().copyWith(
      primaryColor: Color(0xff1f655d),
      textTheme: TextTheme(
          headline6: TextStyle(color: Color(0xff40bf7a)),
          subtitle2: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Color(0xff40bf7a))),
      appBarTheme: AppBarTheme(color: Color(0xff1f655d)),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Color(0xff40bf7a)));

  static InputDecoration defaultTextfieldDecoration = InputDecoration(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))));

  static Color bgGradientStart = Color(0xfff2994a);
  static Color bgGradientEnd = Color(0xfff2c94c);

  static List<Color> baseGradient = [
    UIHelper.bgGradientStart,
    UIHelper.bgGradientStart
  ];

  static BoxDecoration defaultBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [bgGradientStart, bgGradientEnd]),
  );

  static Widget verticalSpaceSmall() {
    return verticalSpace(_verticalSpaceSmall);
  }

  static Widget verticalSpaceMedium() {
    return verticalSpace(_verticalSpaceMedium);
  }

  static Widget verticalSpaceLarge() {
    return verticalSpace(_verticalSpaceLarge);
  }

  static Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }

  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_horizontalSpaceSmall);
  }

  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_horizontalSpaceMedium);
  }

  static Widget horizontalSpaceLarge() {
    return horizontalSpace(_horizontalSpaceLarge);
  }

  static Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }

  static EdgeInsets getContainerMargin() {
    return EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5);
  }

  static const EdgeInsets containerMargin = EdgeInsets.all(10);

  static buildSubHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child:
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[800])),
    );
  }
}
