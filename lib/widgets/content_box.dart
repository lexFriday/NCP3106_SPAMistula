import 'package:flutter/material.dart';
import '../constants/fonts.dart';

class ContentBox extends StatefulWidget {
  final String title;
  final String content;
  final String imagePath;
  final bool isReversed;

  const ContentBox({
    super.key,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.isReversed,
  });

  @override
  State<ContentBox> createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, child) {
          final lift = 40 * _hoverAnimation.value;
          return Transform.translate(
            offset: Offset(0, -lift),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF121212)
                    : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.6)
                        : const Color(0xFF7FEFAC).withOpacity(0.8),
                    blurRadius: 30,
                    spreadRadius: 3,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.isReversed
                          ? [
                              Expanded(
                                flex: 2,
                                child: _buildContent(),
                              ),
                              const SizedBox(width: 32),
                              _buildImage(),
                            ]
                          : [
                              _buildImage(),
                              const SizedBox(width: 32),
                              Expanded(
                                flex: 2,
                                child: _buildContent(),
                              ),
                            ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildImage(),
                        const SizedBox(height: 24),
                        _buildContent(),
                      ],
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage() {
    return MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: 0.95 - (0.45 * _hoverAnimation.value),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final imageSize = constraints.maxWidth < 600 ? 120.0 : 160.0;
                return Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black.withOpacity(0.5)
                            : Colors.black.withOpacity(0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final titleSize = constraints.maxWidth < 600 ? 24.0 : 33.0;
        final contentSize = constraints.maxWidth < 600 ? 18.0 : 29.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: titleSize,
                fontFamily: AppFonts.samsungOne,
                fontWeight: AppFonts.extraBold,
                color: Theme.of(context).colorScheme.onBackground,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.content,
              style: TextStyle(
                fontSize: contentSize,
                fontFamily: AppFonts.samsungSharp,
                fontWeight: AppFonts.regular,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white70
                    : const Color(0xFF315345),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
