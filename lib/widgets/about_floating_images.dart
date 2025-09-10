import 'dart:math';
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import '../constants/fonts.dart';

class AboutFloatingImages extends StatefulWidget {
  const AboutFloatingImages({super.key});

  @override
  State<AboutFloatingImages> createState() => _AboutFloatingImagesState();
}

class _AboutFloatingImagesState extends State<AboutFloatingImages>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 600;
        final double height = isSmall ? 360 : 480;
        final double baseHeight = isSmall ? 160 : 200; // card height
        final double baseWidth =
            baseHeight * (9 / 16); // enforce 9:16 (portrait)
        final double spacing = isSmall ? 2 : 4;

        final images = <String>[
          'assets/images/about/_DSC0444.jpg',
          'assets/images/about/_DSC5820(1).jpg',
          'assets/images/about/20240226_110112.jpg',
          'assets/images/about/20240923_143520.jpg',
          'assets/images/about/received_1019732753198638.jpeg',
        ];

        return SizedBox(
          height: height,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value * 2 * pi;
              final center = Offset(constraints.maxWidth / 2, height / 2);

              List<Widget> stackChildren = [];

              // Precompute positions for 5 images with floating animation
              final positions = [
                Offset(constraints.maxWidth * 0.2, height * 0.2 + sin(t) * 8),
                Offset(constraints.maxWidth * 0.8,
                    height * 0.25 + cos(t * 0.8) * 10),
                Offset(constraints.maxWidth * 0.5,
                    height * 0.5 + sin(t * 0.6) * 6),
                Offset(constraints.maxWidth * 0.15,
                    height * 0.8 + sin(t * 1.2) * 6),
                Offset(constraints.maxWidth * 0.75,
                    height * 0.75 + cos(t * 0.6) * 7),
              ];

              // Build floating images without focus functionality
              for (int i = 0; i < images.length; i++) {
                final pos = positions[i % positions.length];
                final rotBase = i == 0
                    ? (-4 + cos(t) * 1.5)
                    : (i == 1
                        ? (6 + sin(t * 0.8) * 2)
                        : (i == 2
                            ? (-3 + cos(t * 0.9) * 1.8)
                            : (i == 3
                                ? (-2 + cos(t * 1.2) * 1.2)
                                : (3 + sin(t * 1.1) * 1.8))));
                final rotation = rotBase;

                stackChildren.add(
                  Positioned(
                    left: pos.dx - baseWidth / 2,
                    top: pos.dy - baseHeight / 2,
                    child: Transform.rotate(
                      angle: rotation * pi / 180,
                      child: _imageCard(
                        width: baseWidth,
                        height: baseHeight,
                        image: images[i],
                      ),
                    ),
                  ),
                );
              }

              return Stack(clipBehavior: Clip.none, children: stackChildren);
            },
          ),
        );
      },
    );
  }

  Widget _imageCard(
      {required double width, required double height, required String image}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: scheme.onSurface.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: scheme.onSurface.withOpacity(0.08)),
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}
