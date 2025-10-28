import 'package:flutter/material.dart';

const primaryColor = Color(0xff032541);
const backgroundColor = Color(0xffFCFCFD);

ThemeData theme = ThemeData(
  useMaterial3: false,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: primaryColor,
    brightness: Brightness.light,
    onSurface: Colors.black,
  ),
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
  ),
);
