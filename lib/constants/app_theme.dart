import 'package:flutter/material.dart';
import 'fonts.dart';

class AppTheme {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.light);

  static void toggle() {
    mode.value = mode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: const Color(0xFFDFF5EA),
      fontFamily: AppFonts.samsungSharp,
      textTheme: const TextTheme(
        displayLarge: AppFonts.heading1,
        displayMedium: AppFonts.heading2,
        displaySmall: AppFonts.heading3,
        bodyLarge: AppFonts.bodyLarge,
        bodyMedium: AppFonts.bodyMedium,
        bodySmall: AppFonts.bodySmall,
        labelLarge: AppFonts.button,
        labelSmall: AppFonts.caption,
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7FEFAC)),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F1412),
      fontFamily: AppFonts.samsungSharp,
      textTheme: const TextTheme(
        displayLarge: AppFonts.heading1,
        displayMedium: AppFonts.heading2,
        displaySmall: AppFonts.heading3,
        bodyLarge: AppFonts.bodyLarge,
        bodyMedium: AppFonts.bodyMedium,
        bodySmall: AppFonts.bodySmall,
        labelLarge: AppFonts.button,
        labelSmall: AppFonts.caption,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF7FEFAC),
        brightness: Brightness.dark,
      ),
    );
  }
}


