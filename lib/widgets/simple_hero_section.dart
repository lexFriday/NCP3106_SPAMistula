import 'package:flutter/material.dart';
import '../constants/samsung_one_ui_theme.dart';

class SimpleHeroSection extends StatelessWidget {
  const SimpleHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building SimpleHeroSection');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      height: screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SamsungOneUITheme.primaryBlue.withOpacity(0.8),
            SamsungOneUITheme.primaryGreen.withOpacity(0.6),
            Colors.black.withOpacity(0.9),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SHAUN MISTULA',
              style: TextStyle(
                fontSize: isMobile ? 36 : 72,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: isMobile ? 2.0 : 4.0,
              ),
            ),
            SizedBox(height: SamsungOneUITheme.spacingL),
            Text(
              'Computer Engineering Student',
              style: TextStyle(
                fontSize: isMobile ? 18 : 24,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            SizedBox(height: SamsungOneUITheme.spacingS),
            Text(
              'Samsung Galaxy Campus Ambassador',
              style: TextStyle(
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w500,
                color: SamsungOneUITheme.primaryBlue.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

