import 'package:flutter/material.dart';

class Tokens {
  // Colors
  static const Color primaryGreen = Color(0xFF7FEFAC);
  static const Color secondaryGreen = Color(0xFF5CDB95);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color deepGreen = Color(0xFF2E7D32);

  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color textMuted = Colors.black54;

  // Spacing
  static const double spaceXs = 8.0;
  static const double spaceSm = 12.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 40.0;

  // Radius
  static const double radiusSm = 12.0;
  static const double radiusMd = 16.0;
  static const double radiusLg = 20.0;

  // Shadows
  static List<BoxShadow> softShadow(Color color,
      {double blur = 10,
      double spread = 0.5,
      Offset offset = const Offset(0, 2)}) {
    return [
      BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: blur,
          spreadRadius: spread,
          offset: offset),
    ];
  }
}
