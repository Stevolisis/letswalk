import 'package:flutter/material.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF1E9A90),
  inputDecorationTheme: InputDecorationTheme(
    constraints: const BoxConstraints(maxHeight: 36, minHeight: 36),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFFFFFFFF),
      backgroundColor: const Color(0xFF12366D),
      // disabledForegroundColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
