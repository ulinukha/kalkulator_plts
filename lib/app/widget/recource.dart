import 'package:flutter/material.dart';

class Assets {
  static const String urlImage = "assets/";

  static const String imgLogo = urlImage + "kalkulator_logo.jpg";
  static const String imgLogoSplash = urlImage + "logo_splash.png";
  static const String imgOnboard1 = urlImage + "onboard_1.png";
  static const String imgOnboard2 = urlImage + "onboard_2.png";
}

class AppColor {
  static var defaultBlue = hexToColor("#eb8334");
  static var primaryColor = hexToColor("#fefefe");
  static var whiteFefefe = hexToColor("#ffffff");
  static var secondText = hexToColor("#87898A");
  static var gray5E5D5D = hexToColor("#5E5D5D");
  static var grayC4C4C4 = hexToColor("#C4C4C4");

  static Color hexToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return new Color(int.parse(hexColor, radix: 16) + 0xFF000000);
  }
}


