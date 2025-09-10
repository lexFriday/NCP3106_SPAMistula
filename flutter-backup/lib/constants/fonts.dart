import 'package:flutter/material.dart';

class AppFonts {
  // Samsung Sharp Font Family
  static const String samsungSharp = 'SamsungSharp';
  static const String samsungOne = 'SamsungOne';

  // Samsung Sharp Font Weights (based on available files)
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // Samsung Sharp Text Styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: samsungOne,
    fontWeight: black,
    fontSize: 48,
    color: Colors.black,
    letterSpacing: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: samsungOne,
    fontWeight: extraBold,
    fontSize: 36,
    color: Colors.black,
    letterSpacing: 1.0,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: samsungOne,
    fontWeight: extraBold,
    fontSize: 28,
    color: Colors.black,
    letterSpacing: 0.8,
  );

  static const TextStyle title = TextStyle(
    fontFamily: samsungOne,
    fontWeight: extraBold,
    fontSize: 24,
    color: Colors.black,
    letterSpacing: 0.6,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: samsungOne,
    fontWeight: bold,
    fontSize: 20,
    color: Colors.black87,
    letterSpacing: 0.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: samsungSharp,
    fontWeight: regular,
    fontSize: 18,
    color: Colors.black87,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: samsungSharp,
    fontWeight: regular,
    fontSize: 16,
    color: Colors.black87,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: samsungSharp,
    fontWeight: regular,
    fontSize: 14,
    color: Colors.black54,
  );

  static const TextStyle button = TextStyle(
    fontFamily: samsungSharp,
    fontWeight: medium,
    fontSize: 14,
    color: Colors.white,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: samsungSharp,
    fontWeight: regular,
    fontSize: 12,
    color: Colors.black54,
  );
}
