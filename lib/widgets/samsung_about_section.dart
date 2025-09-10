import 'package:flutter/material.dart';
import '../constants/samsung_one_ui_theme.dart';

class SamsungAboutSection extends StatefulWidget {
  const SamsungAboutSection({super.key});

  @override
  State<SamsungAboutSection> createState() => _SamsungAboutSectionState();
}

class _SamsungAboutSectionState extends State<SamsungAboutSection> with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _floatingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? SamsungOneUITheme.spacingL : SamsungOneUITheme.spacingXXL,
        vertical: SamsungOneUITheme.spacingXXL,
      ),
      child: Stack(
        children: [
          // Creative floating elements
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: 50 + (_floatingAnimation.value * 30),
                    right: 30,
                    child: _buildFloatingElement(Icons.code_outlined, SamsungOneUITheme.primaryBlue, 0.2),
                  ),
                  Positioned(
                    top: 200 + (_floatingAnimation.value * -20),
                    left: 20,
                    child: _buildFloatingElement(Icons.school_outlined, SamsungOneUITheme.primaryGreen, 0.15),
                  ),
                  Positioned(
                    bottom: 100 + (_floatingAnimation.value * 25),
                    right: 60,
                    child: _buildFloatingElement(Icons.star_outline, const Color(0xFF9C27B0), 0.18),
                  ),
                ],
              );
            },
          ),
          
          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header with Dynamic Design
              Container(
                padding: EdgeInsets.all(SamsungOneUITheme.spacingXL),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                      SamsungOneUITheme.primaryBlue.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusXL),
                  border: Border.all(
                    color: SamsungOneUITheme.primaryBlue.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(SamsungOneUITheme.spacingM),
                          decoration: BoxDecoration(
                            color: SamsungOneUITheme.primaryBlue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            color: SamsungOneUITheme.primaryBlue,
                            size: 32,
                          ),
                        ),
                        SizedBox(width: SamsungOneUITheme.spacingL),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About Me',
                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: SamsungOneUITheme.primaryBlue,
                                ),
                              ),
                              SizedBox(height: SamsungOneUITheme.spacingS),
                              Text(
                                'Get to know my journey and passion',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: SamsungOneUITheme.spacingXXL),
              
              // Main Content with Dynamic Layout
              Container(
                padding: EdgeInsets.all(SamsungOneUITheme.spacingXXL),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      (isDark ? SamsungOneUITheme.surfaceDark : SamsungOneUITheme.surfaceLight)
                          .withOpacity(0.8),
                      (isDark ? SamsungOneUITheme.surfaceDark : SamsungOneUITheme.surfaceLight)
                          .withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusXL),
                  border: Border.all(
                    color: SamsungOneUITheme.primaryBlue.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    // Main Description
                    Text(
                      'I\'m Shaun Paul Alexis Mistula — a Filipino Computer Engineering student at the University of the East Manila. As President of SCPES and a Samsung Galaxy Campus Student Ambassador, I build, lead, and create. I\'m passionate about embedded systems, IoT, and integrating AI into real-world solutions.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: SamsungOneUITheme.spacingXXL),
                    
                    // Key Highlights Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: isMobile ? 1 : 3,
                      crossAxisSpacing: SamsungOneUITheme.spacingL,
                      mainAxisSpacing: SamsungOneUITheme.spacingL,
                      childAspectRatio: isMobile ? 2.5 : 1.2,
                      children: [
                        _buildHighlightCard(
                          context,
                          'Education',
                          'Computer Engineering Student',
                          'University of the East Manila',
                          SamsungOneUITheme.primaryGreen,
                          Icons.school_outlined,
                        ),
                        _buildHighlightCard(
                          context,
                          'Samsung Ambassador',
                          'Galaxy Campus Student Ambassador',
                          'Creating content with Galaxy S25 Ultra, Z Fold6, Tab S9 FE, and Watch7',
                          SamsungOneUITheme.primaryBlue,
                          Icons.star_outline,
                        ),
                        _buildHighlightCard(
                          context,
                          'Leadership',
                          'SCPES President',
                          'Society of Computer Engineering Students',
                          const Color(0xFF9C27B0),
                          Icons.leaderboard_outlined,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(
    BuildContext context,
    String title,
    String subtitle,
    String description,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.15),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(SamsungOneUITheme.spacingS),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              SizedBox(width: SamsungOneUITheme.spacingM),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SamsungOneUITheme.spacingM),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: SamsungOneUITheme.spacingS),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingElement(IconData icon, Color color, double opacity) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(opacity * 0.5),
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white.withOpacity(0.8),
        size: 25,
      ),
    );
  }
}