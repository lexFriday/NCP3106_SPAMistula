import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/samsung_one_ui_theme.dart';

class SamsungHeroSection extends StatefulWidget {
  const SamsungHeroSection({super.key});

  @override
  State<SamsungHeroSection> createState() => _SamsungHeroSectionState();
}

class _SamsungHeroSectionState extends State<SamsungHeroSection>
    with TickerProviderStateMixin {
  late AnimationController _parallaxController;
  late Animation<double> _parallaxAnimation;

  @override
  void initState() {
    super.initState();
    try {
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          _parallaxController.repeat(reverse: true);
        } catch (e) {
          print('Animation error: $e');
        }
      });
    } catch (e) {
      print('Controller initialization error: $e');
    }
  }

  @override
  void dispose() {
    try {
      _parallaxController.dispose();
    } catch (e) {
      print('Dispose error: $e');
    }
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building SamsungHeroSection');
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
      child: Stack(
        children: [
          // Dark overlay for better text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // Animated floating elements
          AnimatedBuilder(
            animation: _parallaxAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: 100 + (_parallaxAnimation.value * 20),
                    right: 50,
                    child: _buildFloatingElement(Icons.code_outlined,
                        SamsungOneUITheme.primaryBlue, 0.3),
                  ),
                  Positioned(
                    top: 200 + (_parallaxAnimation.value * -15),
                    left: 30,
                    child: _buildFloatingElement(Icons.camera_alt_outlined,
                        const Color(0xFFE91E63), 0.2),
                  ),
                  Positioned(
                    bottom: 150 + (_parallaxAnimation.value * 25),
                    right: 80,
                    child: _buildFloatingElement(Icons.play_circle_outline,
                        const Color(0xFFFF0000), 0.25),
                  ),
                ],
              );
            },
          ),

          // Main Content
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? SamsungOneUITheme.spacingL
                  : SamsungOneUITheme.spacingXXL,
              vertical: SamsungOneUITheme.spacingXXL,
            ),
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Left side - Name and Title
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Large Name Text
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Colors.white,
                    SamsungOneUITheme.primaryBlue,
                    SamsungOneUITheme.primaryGreen,
                  ],
                ).createShader(bounds),
                child: Text(
                  'SHAUN MISTULA',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 4.0,
                    height: 0.9,
                  ),
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
                    () =>
                        _launchURL('https://www.instagram.com/shaun_mistula/'),
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
                    () => _launchURL(
                        'https://www.youtube.com/playlist?list=PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E'),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(width: SamsungOneUITheme.spacingXXL),

        // Right side - Profile Image with Parallax
        Expanded(
          flex: 1,
          child: AnimatedBuilder(
            animation: _parallaxAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _parallaxAnimation.value * 20),
                child: Container(
                  width: 400,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SamsungOneUITheme.radiusXL),
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
                    borderRadius:
                        BorderRadius.circular(SamsungOneUITheme.radiusXL),
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
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
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
                  borderRadius:
                      BorderRadius.circular(SamsungOneUITheme.radiusXL),
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
                  borderRadius:
                      BorderRadius.circular(SamsungOneUITheme.radiusXL),
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
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.white,
              SamsungOneUITheme.primaryBlue,
              SamsungOneUITheme.primaryGreen,
            ],
          ).createShader(bounds),
          child: Text(
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
              () => _launchURL(
                  'https://www.youtube.com/playlist?list=PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E'),
            ),
          ],
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
        color: Colors.black.withOpacity(0.3),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
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

  Widget _buildStatusCard(
    BuildContext context,
    String text,
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
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: SamsungOneUITheme.spacingM),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingElement(IconData icon, Color color, double opacity) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(opacity * 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white.withOpacity(0.8),
        size: 30,
      ),
    );
  }
}

class CreativePatternPainter extends CustomPainter {
  final bool isDark;

  CreativePatternPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    // Creative geometric patterns
    final paint1 = Paint()
      ..color = SamsungOneUITheme.primaryBlue.withOpacity(0.02)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = SamsungOneUITheme.primaryGreen.withOpacity(0.02)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = const Color(0xFFE91E63).withOpacity(0.02)
      ..style = PaintingStyle.fill;

    // Draw creative geometric patterns
    for (int i = 0; i < size.width; i += 80) {
      for (int j = 0; j < size.height; j += 80) {
        // Circles
        canvas.drawCircle(
          Offset(i.toDouble(), j.toDouble()),
          3,
          paint1,
        );

        // Squares
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(i.toDouble() + 40, j.toDouble() + 40),
            width: 4,
            height: 4,
          ),
          paint2,
        );

        // Triangles (diamond shapes)
        final path = Path();
        path.moveTo(i.toDouble() + 20, j.toDouble() + 20);
        path.lineTo(i.toDouble() + 25, j.toDouble() + 15);
        path.lineTo(i.toDouble() + 30, j.toDouble() + 20);
        path.lineTo(i.toDouble() + 25, j.toDouble() + 25);
        path.close();
        canvas.drawPath(path, paint3);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
