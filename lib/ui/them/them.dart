import 'package:flutter/material.dart';

const primaryColor = Color(0xFFF82B10);
final themeData = ThemeData();

final darkTheme = ThemeData(
  primaryColor: primaryColor,
  useMaterial3: true,
  textTheme: _textTheme,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor, brightness: Brightness.dark),
);

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  useMaterial3: true,
  textTheme: _textTheme,
  scaffoldBackgroundColor: const Color(0xffeff1f3),
  dividerTheme: DividerThemeData(color: Colors.grey.withOpacity(0.1)),
  colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor, brightness: Brightness.light),
);

const _textTheme = TextTheme(
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600));
