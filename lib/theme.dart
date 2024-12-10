import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(surface: Colors.white),
    primarySwatch: Colors.blue,
    secondaryHeaderColor: Colors.white);
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme:
        ColorScheme.dark(surface: const Color.fromARGB(255, 255, 255, 255)),
    primarySwatch: Colors.blue,
    secondaryHeaderColor: const Color.fromARGB(255, 255, 255, 255));
