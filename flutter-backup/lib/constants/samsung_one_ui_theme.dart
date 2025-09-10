import 'package:flutter/material.dart';

class SamsungOneUITheme {
  // Samsung One UI Color Palette
  static const Color primaryBlue = Color(0xFF0066CC);
  static const Color primaryGreen = Color(0xFF00C853);
  static const Color accentBlue = Color(0xFF1976D2);
  static const Color accentGreen = Color(0xFF4CAF50);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C2C);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF1A1A1A);
  static const Color textSecondaryLight = Color(0xFF6C6C6C);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB3B3B3);

  // Border and Divider Colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF404040);
  static const Color dividerLight = Color(0xFFF0F0F0);
  static const Color dividerDark = Color(0xFF333333);

  // Status Colors
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Spacing System (8px grid)
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;

  // Elevation/Shadow
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;

  // Typography
  static const String fontFamily = 'SamsungOne';
  static const String fontFamilySharp = 'SamsungSharp';

  // Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: primaryGreen,
        surface: surfaceLight,
        background: backgroundLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryLight,
        onBackground: textPrimaryLight,
      ),
      scaffoldBackgroundColor: backgroundLight,
      cardColor: cardLight,
      dividerColor: dividerLight,
      textTheme: _textTheme(textPrimaryLight, textSecondaryLight),
      elevatedButtonTheme: _elevatedButtonTheme(),
      cardTheme: _cardTheme(),
      appBarTheme: _appBarTheme(),
    );
  }

  // Dark Theme
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryBlue,
        secondary: primaryGreen,
        surface: surfaceDark,
        background: backgroundDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryDark,
        onBackground: textPrimaryDark,
      ),
      scaffoldBackgroundColor: backgroundDark,
      cardColor: cardDark,
      dividerColor: dividerDark,
      textTheme: _textTheme(textPrimaryDark, textSecondaryDark),
      elevatedButtonTheme: _elevatedButtonTheme(),
      cardTheme: _cardTheme(),
      appBarTheme: _appBarTheme(),
    );
  }

  static TextTheme _textTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primary,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.3,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.3,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.4,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.4,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamilySharp,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamilySharp,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamilySharp,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.5,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamilySharp,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamilySharp,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.6,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamilySharp,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.6,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamilySharp,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamilySharp,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondary,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamilySharp,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: secondary,
        height: 1.4,
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: elevationS,
        padding: const EdgeInsets.symmetric(
          horizontal: spacingL,
          vertical: spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusM),
        ),
        textStyle: const TextStyle(
          fontFamily: fontFamilySharp,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      elevation: elevationS,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusM),
      ),
      margin: const EdgeInsets.all(spacingS),
    );
  }

  static AppBarTheme _appBarTheme() {
    return const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // Helper methods for consistent styling
  static BoxDecoration cardDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? cardDark : cardLight,
      borderRadius: BorderRadius.circular(radiusM),
      border: Border.all(
        color: isDark ? borderDark : borderLight,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
          blurRadius: elevationM,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  static BoxDecoration sectionDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? surfaceDark : surfaceLight,
      borderRadius: BorderRadius.circular(radiusL),
      border: Border.all(
        color: isDark ? borderDark : borderLight,
        width: 1,
      ),
    );
  }
}

