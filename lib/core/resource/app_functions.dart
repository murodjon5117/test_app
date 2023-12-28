import 'package:flutter/material.dart';

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
  return Colors.white;
}

Color blendColors(Color primaryColor, Color secondaryColor, double percentage) {
  final double factor =
      percentage.clamp(0.0, 1.0); // Ensure percentage is within [0, 1]
  final double inverseFactor = 1.0 - factor;

  int red =
      (primaryColor.red * factor + secondaryColor.red * inverseFactor).round();
  int green =
      (primaryColor.green * factor + secondaryColor.green * inverseFactor)
          .round();
  int blue = (primaryColor.blue * factor + secondaryColor.blue * inverseFactor)
      .round();

  return Color.fromARGB(255, red, green, blue);
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
