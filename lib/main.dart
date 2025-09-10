import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'constants/apple_ui_theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shaun Mistula - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppleUITheme.lightTheme(),
      darkTheme: AppleUITheme.darkTheme(),
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
