import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/apple_ui_theme.dart';

class AppleHeroSection extends StatefulWidget {
  const AppleHeroSection({super.key});

  @override
  State<AppleHeroSection> createState() => _AppleHeroSectionState();
}

class _AppleHeroSectionState extends State<AppleHeroSection>
    with TickerProviderStateMixin {
  late AnimationController _parallaxController;
  late Animation<double> _parallaxAnimation;

  @override
  void initState() {
    super.initState();
    _parallaxController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _parallaxAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _parallaxController,
      curve: Curves.easeInOut,
    ));
    _parallaxController.forward();
  }

  @override
  void dispose() {
    _parallaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/photography/1000031090 (1).jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          scale: 1.0,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.4),
            ],
          ),
        ),
        child: isMobile
            ? _buildMobileLayout(context)
            : _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth < 1024;

    return Padding(
      padding: EdgeInsets.all(
          isTablet ? AppleUITheme.spacingXL : AppleUITheme.spacingXXL),
      child: Row(
        children: [
          // Left side - Name and Title
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Name
                Text(
                  'Shaun Mistula',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                ),
                const SizedBox(height: AppleUITheme.spacingL),

                // Title
                Text(
                  'Creative Developer & Designer',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(height: AppleUITheme.spacingXL),

                // Description
                Text(
                  'Passionate about creating beautiful, functional experiences through code and design.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: AppleUITheme.spacingXXL),

                // Social Links
                _buildSocialLinks(context),
              ],
            ),
          ),

          SizedBox(
              width:
                  isTablet ? AppleUITheme.spacingXL : AppleUITheme.spacingXXL),

          // Right side - Profile Picture
          Expanded(
            flex: 1,
            child: Center(
              child: AnimatedBuilder(
                animation: _parallaxAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _parallaxAnimation.value * 20),
                    child: Container(
                      width: isTablet ? 300 : 400,
                      height: isTablet ? 375 : 500,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppleUITheme.radiusXXL),
                        boxShadow: [
                          BoxShadow(
                            color: AppleUITheme.primaryGreen.withOpacity(0.3),
                            blurRadius: 40,
                            spreadRadius: 10,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppleUITheme.radiusXXL),
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppleUITheme.primaryGreen.withOpacity(0.1),
                              child: Icon(
                                Icons.person,
                                size: 200,
                                color: AppleUITheme.primaryGreen,
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
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppleUITheme.spacingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Picture
          AnimatedBuilder(
            animation: _parallaxAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _parallaxAnimation.value * 10),
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppleUITheme.radiusXL),
                    boxShadow: [
                      BoxShadow(
                        color: AppleUITheme.primaryGreen.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppleUITheme.radiusXL),
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppleUITheme.primaryGreen.withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: AppleUITheme.primaryGreen,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: AppleUITheme.spacingXL),

          // Name
          Text(
            'Shaun Mistula',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
          ),
          const SizedBox(height: AppleUITheme.spacingM),

          // Title
          Text(
            'Creative Developer & Designer',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: AppleUITheme.spacingL),

          // Description
          Text(
            'Passionate about creating beautiful, functional experiences through code and design.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: AppleUITheme.spacingXL),

          // Social Links
          _buildSocialLinks(context),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Wrap(
      spacing: AppleUITheme.spacingM,
      runSpacing: AppleUITheme.spacingS,
      children: [
        _buildSocialButton(
          context,
          'Instagram',
          Icons.camera_alt_outlined,
          AppleUITheme.accentPink,
          () => _launchURL('https://instagram.com/shaunmistula'),
        ),
        _buildSocialButton(
          context,
          'Facebook',
          Icons.facebook_outlined,
          AppleUITheme.accentBlue,
          () => _launchURL('https://facebook.com/shaunmistula'),
        ),
        _buildSocialButton(
          context,
          'Email',
          Icons.email_outlined,
          AppleUITheme.accentOrange,
          () => _launchURL('mailto:shaunmistula@gmail.com'),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppleUITheme.radiusM),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppleUITheme.spacingL,
            vertical: AppleUITheme.spacingM,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppleUITheme.radiusM),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: AppleUITheme.lightShadow,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 18,
              ),
              const SizedBox(width: AppleUITheme.spacingS),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
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
