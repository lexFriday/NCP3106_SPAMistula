import 'package:flutter/material.dart';
import '../constants/fonts.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _imageController;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _imageSlideAnimation;
  late AnimationController _hoverController;
  late AnimationController _breathController;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _imageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _breathController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true);

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _imageSlideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeOutBack,
    ));

    _textController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      try {
        _imageController.forward();
      } catch (e) {
        // Controller already disposed, ignore
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _imageController.dispose();
    _hoverController.dispose();
    _breathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: const BoxConstraints.expand(),
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth < 600
                  ? 16
                  : 96), // Small padding on mobile
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTextSection(),
                      const SizedBox(width: 64),
                      _buildImageSection(),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTextSection(),
                      const SizedBox(height: 32),
                      _buildImageSection(),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildTextSection() {
    final isWide = MediaQuery.of(context).size.width > 900;
    final isSmall = MediaQuery.of(context).size.width < 600;

    return AnimatedBuilder(
      animation: _textFadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _textFadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _textFadeAnimation.value)),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 0,
                top: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Shaun'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isWide ? 120 : (isSmall ? 60 : 80),
                      fontFamily: AppFonts.samsungOne,
                      fontWeight: AppFonts.black,
                      height: 0.9,
                      color: Theme.of(context).colorScheme.onBackground,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mistula'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isWide ? 120 : (isSmall ? 60 : 80),
                      fontFamily: AppFonts.samsungOne,
                      fontWeight: AppFonts.black,
                      height: 0.9,
                      color: Theme.of(context).colorScheme.onBackground,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _imageSlideAnimation,
        _hoverController,
        _breathController,
      ]),
      builder: (context, child) {
        final slide = 50 * _imageSlideAnimation.value;
        final hoverShift = 10 * _hoverController.value;
        final borderRadius = 100 - (60 * _hoverController.value);
        // Breathing intensity
        final double breath = 0.30 + 0.40 * _breathController.value; // 0.3..0.7
        final double hoverBoost = 0.25 * _hoverController.value;
        return MouseRegion(
          onEnter: (_) => _hoverController.forward(),
          onExit: (_) => _hoverController.reverse(),
          child: Transform.translate(
            offset: Offset(slide + hoverShift, 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final imageSize = constraints.maxWidth < 600 ? 250.0 : 350.0;
                return SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Container(
                        width: imageSize,
                        height: imageSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.25 * (0.6 + 0.4 * _hoverController.value)),
                              blurRadius: 40,
                              spreadRadius: 0,
                              offset: const Offset(6, 6),
                            ),
                            // Green breathing glow aura
                            BoxShadow(
                              color: const Color(0xFF7FEFAC).withOpacity(
                                  (breath + hoverBoost).clamp(0.0, 1.0)),
                              blurRadius: 50 + 30 * _breathController.value,
                              spreadRadius: 10 + 8 * _breathController.value,
                              offset: const Offset(0, 0),
                            ),
                            // Outer soft ring for depth
                            BoxShadow(
                              color: const Color(0xFF5CDB95).withOpacity(
                                  0.25 * (0.5 + 0.5 * _breathController.value)),
                              blurRadius: 80,
                              spreadRadius: 20,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(borderRadius),
                          child: Image.asset(
                            'assets/images/profile.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: _NotifDot(size: imageSize * 0.09),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _NotifDot extends StatelessWidget {
  final double size;
  const _NotifDot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFFF00A0A),
        shape: BoxShape.circle,
      ),
    );
  }
}
