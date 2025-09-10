import 'package:flutter/material.dart';

class AppleUITheme {
  // Apple Color Palette
  static const Color primaryGreen = Color(0xFF34C759);
  static const Color secondaryGreen = Color(0xFF30D158);
  static const Color accentBlue = Color(0xFF007AFF);
  static const Color accentOrange = Color(0xFFFF9500);
  static const Color accentRed = Color(0xFFFF3B30);
  static const Color accentPurple = Color(0xFFAF52DE);
  static const Color accentPink = Color(0xFFFF2D92);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF2F2F7);
  static const Color backgroundDark = Color(0xFF000000);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color surfaceSecondaryLight = Color(0xFFF2F2F7);
  static const Color surfaceSecondaryDark = Color(0xFF2C2C2E);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF3C3C43);
  static const Color textSecondaryDark = Color(0xFFEBEBF5);
  static const Color textTertiaryLight = Color(0xFF3C3C43);
  static const Color textTertiaryDark = Color(0xFFEBEBF5);

  // Border Colors
  static const Color borderLight = Color(0xFFC6C6C8);
  static const Color borderDark = Color(0xFF38383A);

  // Spacing (Apple's 8pt grid)
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacingXXXL = 64.0;

  // Border Radius (Apple's rounded corners)
  static const double radiusXS = 6.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;

  // Shadows (Apple's subtle shadows)
  static List<BoxShadow> get lightShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get mediumShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get heavyShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 30,
          offset: const Offset(0, 8),
        ),
      ];

  // Typography
  static const String fontFamily = 'SF Pro Display';
  static const String fontFamilyText = 'SF Pro Text';

  // Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: secondaryGreen,
        surface: surfaceLight,
        background: backgroundLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryLight,
        onBackground: textPrimaryLight,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: textPrimaryLight,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryLight,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryLight,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryLight,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryLight,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryLight,
        ),
        titleLarge: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 22,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryLight,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: textPrimaryLight,
        ),
        titleSmall: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: textPrimaryLight,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: textPrimaryLight,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: textPrimaryLight,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: textSecondaryLight,
        ),
        labelLarge: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: textPrimaryLight,
        ),
        labelMedium: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: textPrimaryLight,
        ),
        labelSmall: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: textSecondaryLight,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
        ),
        color: surfaceLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusM),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingL,
            vertical: spacingM,
          ),
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryGreen,
        secondary: secondaryGreen,
        surface: surfaceDark,
        background: backgroundDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryDark,
        onBackground: textPrimaryDark,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: textPrimaryDark,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryDark,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryDark,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryDark,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryDark,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryDark,
        ),
        titleLarge: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 22,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: textPrimaryDark,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: textPrimaryDark,
        ),
        titleSmall: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: textPrimaryDark,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: textPrimaryDark,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: textPrimaryDark,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: textSecondaryDark,
        ),
        labelLarge: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: textPrimaryDark,
        ),
        labelMedium: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: textPrimaryDark,
        ),
        labelSmall: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: textSecondaryDark,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
        ),
        color: surfaceDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusM),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingL,
            vertical: spacingM,
          ),
        ),
      ),
    );
  }
}
