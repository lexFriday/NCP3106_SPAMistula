import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/fonts.dart';

class PhotographyCarousel extends StatefulWidget {
  const PhotographyCarousel({super.key});

  @override
  State<PhotographyCarousel> createState() => _PhotographyCarouselState();
}

class _PhotographyCarouselState extends State<PhotographyCarousel>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _carouselController;
  bool _isLowEndDevice = false;

  final List<PhotoItem> _photos = [
    PhotoItem(
      id: '1',
      imageUrl: 'assets/images/photography/_IGP1451(1)(1).jpg',
      title: 'Street Photography',
      description: 'Urban life and culture',
    ),
    PhotoItem(
      id: '2',
      imageUrl: 'assets/images/photography/1000031090 (1).jpg',
      title: 'Artistic Composition',
      description: 'Creative visual storytelling',
    ),
    PhotoItem(
      id: '3',
      imageUrl: 'assets/images/photography/1000031102.jpg',
      title: 'Lifestyle Photography',
      description: 'Capturing authentic moments',
    ),
    PhotoItem(
      id: '4',
      imageUrl: 'assets/images/photography/1000039409.jpg',
      title: 'Portrait Photography',
      description: 'Human emotion and expression',
    ),
    PhotoItem(
      id: '5',
      imageUrl: 'assets/images/photography/20250515_120304(2).jpg',
      title: 'Nature Photography',
      description: 'Beauty in the natural world',
    ),
    PhotoItem(
      id: '6',
      imageUrl: 'assets/images/photography/20250612_233907.jpg',
      title: 'Documentary Photography',
      description: 'Real moments captured',
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Detect low-end device
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      _isLowEndDevice = screenSize.width < 400 || devicePixelRatio < 2.0;
    });

    // Use shorter durations for low-end devices
    final animationDuration = _isLowEndDevice ? 300 : 600;
    final carouselDuration = _isLowEndDevice ? 400 : 800;

    _titleController = AnimationController(
      duration: Duration(milliseconds: animationDuration),
      vsync: this,
    );
    _carouselController = AnimationController(
      duration: Duration(milliseconds: carouselDuration),
      vsync: this,
    );

    // Start animations immediately for better mobile experience
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        _titleController.forward();
        _carouselController.forward();
      } catch (e) {
        // Controllers already disposed, ignore
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  void _launchInstagram() async {
    const url = 'https://www.instagram.com/shaun_mistula/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final isMedium = screenWidth < 900;
    final isLowEnd = screenWidth < 400;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            isDark ? const Color(0xFF0A0A0A) : const Color(0xFFFAF5FF),
            isDark ? const Color(0xFF1A1A1A) : Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(isLowEnd ? 16 : 24),
      ),
      child: Column(
        children: [
          SizedBox(height: isLowEnd ? 20 : (isSmall ? 40 : 80)),

          // Title - Completely static for low-end devices
          Text(
            'My Photography',
            style: TextStyle(
              fontFamily: AppFonts.samsungSharp,
              fontWeight: AppFonts.bold,
              fontSize: isLowEnd ? 24 : (isSmall ? 28 : (isMedium ? 36 : 48)),
              color: isDark ? Colors.white : Colors.black87,
              letterSpacing: isLowEnd ? 1.0 : 1.5,
            ),
          ),

          SizedBox(height: isLowEnd ? 20 : (isSmall ? 30 : 60)),

          // Photography Gallery - Completely static for better performance
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isLowEnd ? 12 : (isSmall ? 16 : 20),
            ),
            child: _buildCustomGrid(isDark, isSmall, isLowEnd),
          ),

          SizedBox(height: isLowEnd ? 20 : (isSmall ? 40 : 80)),
        ],
      ),
    );
  }

  Widget _buildCustomGrid(bool isDark, bool isSmall, bool isLowEnd) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount =
        isLowEnd ? 2 : (isSmall ? 2 : (screenWidth < 1200 ? 3 : 4));
    final photoItems =
        isLowEnd ? 4 : _photos.length; // Limit items for low-end devices

    return Column(
      children: [
        // Photo grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isLowEnd ? 8 : (isSmall ? 12 : 16),
            mainAxisSpacing: isLowEnd ? 8 : (isSmall ? 12 : 16),
            childAspectRatio: isLowEnd ? 0.7 : (isSmall ? 0.75 : 0.8),
          ),
          itemCount: photoItems,
          itemBuilder: (context, index) {
            return _buildPhotoGridItem(
                _photos[index], isDark, isSmall, isLowEnd);
          },
        ),
        SizedBox(height: isLowEnd ? 8 : (isSmall ? 12 : 16)),
        // Instagram card spanning full width
        _buildViewMoreCard(isDark, isSmall, isLowEnd),
      ],
    );
  }

  Widget _buildPhotoGridItem(
      PhotoItem photo, bool isDark, bool isSmall, bool isLowEnd) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isLowEnd ? 6 : (isSmall ? 8 : 12)),
        boxShadow: isLowEnd
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: isSmall ? 6 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showImagePopup(photo);
          },
          borderRadius:
              BorderRadius.circular(isLowEnd ? 6 : (isSmall ? 8 : 12)),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(isLowEnd ? 6 : (isSmall ? 8 : 12)),
            child: Image.asset(
              photo.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              // Aggressive caching for low-end devices
              cacheWidth: isLowEnd ? 200 : (isSmall ? 300 : 400),
              cacheHeight: isLowEnd ? 280 : (isSmall ? 400 : 500),
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, color: Colors.grey),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePopup(PhotoItem photo) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AnimatedDialog(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black.withOpacity(0.9),
              child: Stack(
                children: [
                  // Full screen image
                  Center(
                    child: GestureDetector(
                      onTap: () {}, // Prevent closing when tapping image
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.95,
                          maxHeight: MediaQuery.of(context).size.height * 0.85,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            photo.imageUrl,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Close button
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  // Photo info
                  Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 20,
                    left: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {}, // Prevent closing when tapping info
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              photo.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 18
                                        : 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              photo.description,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 14
                                        : 16,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildViewMoreCard(bool isDark, bool isSmall, bool isLowEnd) {
    return Container(
      height: isLowEnd ? 80 : (isSmall ? 100 : 120),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8B5CF6),
            Color(0xFFEC4899),
          ],
        ),
        borderRadius: BorderRadius.circular(isLowEnd ? 6 : (isSmall ? 8 : 12)),
        boxShadow: isLowEnd
            ? null
            : [
                BoxShadow(
                  color: const Color(0xFF8B5CF6).withOpacity(0.3),
                  blurRadius: isSmall ? 8 : 12,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _launchInstagram,
          borderRadius:
              BorderRadius.circular(isLowEnd ? 6 : (isSmall ? 8 : 12)),
          child: Container(
            padding: EdgeInsets.all(isLowEnd ? 12 : (isSmall ? 16 : 24)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  size: isLowEnd ? 30 : (isSmall ? 40 : 60),
                  color: Colors.white,
                ),
                SizedBox(width: isLowEnd ? 8 : (isSmall ? 12 : 16)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                        fontFamily: AppFonts.samsungSharp,
                        fontWeight: AppFonts.bold,
                        fontSize: isLowEnd ? 16 : (isSmall ? 18 : 24),
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'on Instagram',
                      style: TextStyle(
                        fontFamily: AppFonts.samsungOne,
                        fontWeight: AppFonts.regular,
                        fontSize: isLowEnd ? 10 : (isSmall ? 12 : 16),
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedDialog extends StatefulWidget {
  final Widget child;

  const AnimatedDialog({super.key, required this.child});

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class PhotoItem {
  final String id;
  final String imageUrl;
  final String title;
  final String description;

  PhotoItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}
