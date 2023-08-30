import 'package:flutter/material.dart';

const Color backgroundColor = Color.fromRGBO(215, 208, 200, 1);
const Color white = Color.fromARGB(201, 201, 201, 1);
const Color blue = Color.fromRGBO(12, 98, 145, 1);
const Color blueLight = Color.fromRGBO(42, 139, 191, 1);
const Color blueDark = Color.fromRGBO(6, 59, 87, 1);

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
