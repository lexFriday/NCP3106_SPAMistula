import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/samsung_one_ui_theme.dart';

class WorkingHeroSection extends StatefulWidget {
  const WorkingHeroSection({super.key});

  @override
  State<WorkingHeroSection> createState() => _WorkingHeroSectionState();
}

class _WorkingHeroSectionState extends State<WorkingHeroSection> with TickerProviderStateMixin {
  late AnimationController _parallaxController;
  late Animation<double> _parallaxAnimation;

  @override
  void initState() {
    super.initState();
    _parallaxController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _parallaxAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _parallaxController,
      curve: Curves.easeInOut,
    ));
    _parallaxController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _parallaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Building WorkingHeroSection');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      height: screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/photography/1000031090 (1).jpg'),
          fit: BoxFit.cover,
        ),
      ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Glass morphism overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.transparent,
                        Colors.white.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ),
              // Main content
              isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
            ],
          ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Left side - Name and Title
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(SamsungOneUITheme.spacingXXL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Large Name Text
                Text(
                  'SHAUN MISTULA',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 4.0,
                    height: 0.9,
                  ),
                ),
                
                SizedBox(height: SamsungOneUITheme.spacingL),
                
                // Subtitle
                Text(
                  'Computer Engineering Student',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 1.5,
                  ),
                ),
                
                SizedBox(height: SamsungOneUITheme.spacingS),
                
                Text(
                  'Samsung Galaxy Campus Ambassador',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: SamsungOneUITheme.primaryBlue.withOpacity(0.8),
                    letterSpacing: 1.0,
                  ),
                ),
                
                SizedBox(height: SamsungOneUITheme.spacingXXL),
                
                // Social Links
                Wrap(
                  spacing: SamsungOneUITheme.spacingM,
                  runSpacing: SamsungOneUITheme.spacingM,
                  children: [
                    _buildSocialButton(
                      context,
                      'Email',
                      Icons.email_outlined,
                      Colors.white,
                      () => _launchURL('mailto:shaunmistula@gmail.com'),
                    ),
                    _buildSocialButton(
                      context,
                      'Instagram',
                      Icons.camera_alt_outlined,
                      const Color(0xFFE4405F),
                      () => _launchURL('https://www.instagram.com/shaun_mistula/'),
                    ),
                    _buildSocialButton(
                      context,
                      'TikTok',
                      Icons.music_note_outlined,
                      Colors.white,
                      () => _launchURL('https://www.tiktok.com/@swswswsw0'),
                    ),
                    _buildSocialButton(
                      context,
                      'YouTube',
                      Icons.play_circle_outline,
                      const Color(0xFFFF0000),
                      () => _launchURL('https://www.youtube.com/playlist?list=PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        SizedBox(width: SamsungOneUITheme.spacingXXL),
        
        // Right side - Profile Image with Parallax
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(SamsungOneUITheme.spacingXXL),
            child: Center(
              child: AnimatedBuilder(
                animation: _parallaxAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _parallaxAnimation.value * 20),
                    child: Container(
                      width: 400,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusXL),
                        boxShadow: [
                          BoxShadow(
                            color: SamsungOneUITheme.primaryBlue.withOpacity(0.3),
                            blurRadius: 30,
                            spreadRadius: 10,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusXL),
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                              child: Icon(
                                Icons.person,
                                size: 200,
                                color: SamsungOneUITheme.primaryBlue,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Image with Parallax
          AnimatedBuilder(
            animation: _parallaxAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _parallaxAnimation.value * 15),
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusXL),
                    boxShadow: [
                      BoxShadow(
                        color: SamsungOneUITheme.primaryBlue.withOpacity(0.3),
                        blurRadius: 25,
                        spreadRadius: 8,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusXL),
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: SamsungOneUITheme.primaryBlue,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          
          SizedBox(height: SamsungOneUITheme.spacingXXL),
          
          // Name Text
          Text(
            'SHAUN MISTULA',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2.0,
              height: 0.9,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: SamsungOneUITheme.spacingL),
          
          // Subtitle
          Text(
            'Computer Engineering Student',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: SamsungOneUITheme.spacingS),
          
          Text(
            'Samsung Galaxy Campus Ambassador',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: SamsungOneUITheme.primaryBlue.withOpacity(0.8),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: SamsungOneUITheme.spacingXXL),
          
          // Social Links
          Wrap(
            spacing: SamsungOneUITheme.spacingM,
            runSpacing: SamsungOneUITheme.spacingM,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialButton(
                context,
                'Email',
                Icons.email_outlined,
                Colors.white,
                () => _launchURL('mailto:shaunmistula@gmail.com'),
              ),
              _buildSocialButton(
                context,
                'Instagram',
                Icons.camera_alt_outlined,
                const Color(0xFFE4405F),
                () => _launchURL('https://www.instagram.com/shaun_mistula/'),
              ),
              _buildSocialButton(
                context,
                'TikTok',
                Icons.music_note_outlined,
                Colors.white,
                () => _launchURL('https://www.tiktok.com/@swswswsw0'),
              ),
              _buildSocialButton(
                context,
                'YouTube',
                Icons.play_circle_outline,
                const Color(0xFFFF0000),
                () => _launchURL('https://www.youtube.com/playlist?list=PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SamsungOneUITheme.spacingL,
              vertical: SamsungOneUITheme.spacingM,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: SamsungOneUITheme.spacingS),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
