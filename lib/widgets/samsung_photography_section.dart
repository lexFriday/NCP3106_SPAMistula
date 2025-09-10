import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/samsung_one_ui_theme.dart';

class SamsungPhotographySection extends StatefulWidget {
  const SamsungPhotographySection({super.key});

  @override
  State<SamsungPhotographySection> createState() => _SamsungPhotographySectionState();
}

class _SamsungPhotographySectionState extends State<SamsungPhotographySection> with TickerProviderStateMixin {
  late AnimationController _creativeController;
  late Animation<double> _creativeAnimation;
  final List<Map<String, dynamic>> _photos = [
    {
      'image': 'assets/images/photography/_IGP1451(1)(1).jpg',
      'title': 'Street Photography',
      'description': 'Urban life and culture',
      'category': 'Street',
    },
    {
      'image': 'assets/images/photography/1000031090 (1).jpg',
      'title': 'Artistic Composition',
      'description': 'Creative visual storytelling',
      'category': 'Art',
    },
    {
      'image': 'assets/images/photography/1000031102.jpg',
      'title': 'Lifestyle Photography',
      'description': 'Capturing authentic moments',
      'category': 'Lifestyle',
    },
    {
      'image': 'assets/images/photography/1000039409.jpg',
      'title': 'Portrait Photography',
      'description': 'Human emotion and expression',
      'category': 'Portrait',
    },
    {
      'image': 'assets/images/photography/20250515_120304(2).jpg',
      'title': 'Nature Photography',
      'description': 'Beauty in the natural world',
      'category': 'Nature',
    },
    {
      'image': 'assets/images/photography/20250612_233907.jpg',
      'title': 'Documentary Photography',
      'description': 'Real moments captured',
      'category': 'Documentary',
    },
  ];

  int _selectedCategory = 0;
  final List<String> _categories = ['All', 'Street', 'Art', 'Lifestyle', 'Portrait', 'Nature', 'Documentary'];

  @override
  void initState() {
    super.initState();
    _creativeController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _creativeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _creativeController,
      curve: Curves.easeInOut,
    ));
    _creativeController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _creativeController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredPhotos {
    if (_selectedCategory == 0) return _photos;
    return _photos.where((photo) => photo['category'] == _categories[_selectedCategory]).toList();
  }

  Future<void> _launchInstagram() async {
    const url = 'https://www.instagram.com/shaun_mistula/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  void _showPhotoDialog(Map<String, dynamic> photo) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            // Background overlay
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            // Photo content
            Center(
              child: Container(
                margin: EdgeInsets.all(SamsungOneUITheme.spacingL),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Photo
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                        ),
                        child: Image.asset(
                          photo['image'] as String,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 300,
                              color: SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                              child: Icon(
                                Icons.image_outlined,
                                size: 60,
                                color: SamsungOneUITheme.primaryBlue.withOpacity(0.5),
                              ),
                            );
                          },
                        ),
                      ),
                      // Photo info
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(SamsungOneUITheme.radiusL),
                            bottomRight: Radius.circular(SamsungOneUITheme.radiusL),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SamsungOneUITheme.spacingM,
                                vertical: SamsungOneUITheme.spacingS,
                              ),
                              decoration: BoxDecoration(
                                color: SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
                              ),
                              child: Text(
                                photo['category'] as String,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: SamsungOneUITheme.primaryBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: SamsungOneUITheme.spacingS),
                            Text(
                              photo['title'] as String,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: SamsungOneUITheme.spacingXS),
                            Text(
                              photo['description'] as String,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Close button
            Positioned(
              top: SamsungOneUITheme.spacingXL,
              right: SamsungOneUITheme.spacingXL,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Container(
                  padding: const EdgeInsets.all(SamsungOneUITheme.spacingS),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
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
          ],
        ),
      ),
    );
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
            animation: _creativeAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: 80 + (_creativeAnimation.value * 40),
                    right: 40,
                    child: _buildFloatingElement(Icons.camera_alt_outlined, const Color(0xFFE91E63), 0.25),
                  ),
                  Positioned(
                    top: 300 + (_creativeAnimation.value * -30),
                    left: 30,
                    child: _buildFloatingElement(Icons.photo_camera_outlined, const Color(0xFF9C27B0), 0.2),
                  ),
                  Positioned(
                    bottom: 150 + (_creativeAnimation.value * 35),
                    right: 70,
                    child: _buildFloatingElement(Icons.filter_vintage_outlined, const Color(0xFFE91E63), 0.18),
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
                  const Color(0xFFE91E63).withOpacity(0.1),
                  const Color(0xFFE91E63).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusXL),
              border: Border.all(
                color: const Color(0xFFE91E63).withOpacity(0.3),
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
                        color: const Color(0xFFE91E63).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: const Color(0xFFE91E63),
                        size: 32,
                      ),
                    ),
                    SizedBox(width: SamsungOneUITheme.spacingL),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Photography Portfolio',
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFE91E63),
                            ),
                          ),
                          SizedBox(height: SamsungOneUITheme.spacingS),
                          Text(
                            'Explore my visual storytelling through photography',
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
              
              // Category Filter
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategory == index;
                return Container(
                  margin: EdgeInsets.only(right: SamsungOneUITheme.spacingM),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SamsungOneUITheme.spacingL,
                          vertical: SamsungOneUITheme.spacingM,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: [
                                    const Color(0xFFE91E63).withOpacity(0.2),
                                    const Color(0xFFE91E63).withOpacity(0.1),
                                  ],
                                )
                              : null,
                          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFE91E63)
                                : Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _categories[index],
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: isSelected
                                  ? const Color(0xFFE91E63)
                                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
              ),
              
              SizedBox(height: SamsungOneUITheme.spacingXL),
              
              // Photo Gallery Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 3,
              crossAxisSpacing: SamsungOneUITheme.spacingL,
              mainAxisSpacing: SamsungOneUITheme.spacingL,
              childAspectRatio: 1.0,
            ),
            itemCount: _filteredPhotos.length,
            itemBuilder: (context, index) {
              final photo = _filteredPhotos[index];
              return _buildPhotoCard(context, photo);
            },
              ),
              
              SizedBox(height: SamsungOneUITheme.spacingXXL),
              
              // View More Button
          Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFE91E63),
                    const Color(0xFFE91E63).withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE91E63).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _launchInstagram,
                  borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SamsungOneUITheme.spacingXXL,
                      vertical: SamsungOneUITheme.spacingL,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt_outlined, color: Colors.white),
                        SizedBox(width: SamsungOneUITheme.spacingM),
                        Text(
                          'View More on Instagram',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingElement(IconData icon, Color color, double opacity) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(opacity * 0.6),
            blurRadius: 18,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white.withOpacity(0.9),
        size: 28,
      ),
    );
  }

  Widget _buildPhotoCard(BuildContext context, Map<String, dynamic> photo) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showPhotoDialog(photo),
        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
            child: Stack(
              children: [
                // Photo
                Positioned.fill(
                  child: Image.asset(
                    photo['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                        child: Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: SamsungOneUITheme.primaryBlue.withOpacity(0.5),
                        ),
                      );
                    },
                  ),
                ),
                
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Photo Info
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(SamsungOneUITheme.spacingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SamsungOneUITheme.spacingS,
                            vertical: SamsungOneUITheme.spacingXS,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE91E63).withOpacity(0.9),
                            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
                          ),
                          child: Text(
                            photo['category'] as String,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: SamsungOneUITheme.spacingXS),
                        Text(
                          photo['title'] as String,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Tap indicator
                Positioned(
                  top: SamsungOneUITheme.spacingM,
                  right: SamsungOneUITheme.spacingM,
                  child: Container(
                    padding: const EdgeInsets.all(SamsungOneUITheme.spacingS),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.zoom_in,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}