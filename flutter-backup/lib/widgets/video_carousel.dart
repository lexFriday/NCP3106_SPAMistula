import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/instagram_service.dart';
import '../services/youtube_api_service.dart';
import '../constants/fonts.dart';
import '../constants/design_tokens.dart';
import 'youtube_embedded_player.dart';

class VideoCarousel extends StatefulWidget {
  const VideoCarousel({super.key});

  @override
  State<VideoCarousel> createState() => _VideoCarouselState();
}

class _VideoCarouselState extends State<VideoCarousel>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _carouselController;
  late PageController _pageController;
  List<InstagramPost> _videos = [];
  int _currentIndex = 0;
  InstagramPost? _selectedVideo;
  bool _isLoading = true;
  bool _isLowEndDevice = false;

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
    final animationDuration = _isLowEndDevice ? 400 : 800;

    _titleController = AnimationController(
      duration: Duration(milliseconds: animationDuration),
      vsync: this,
    );
    _carouselController = AnimationController(
      duration: Duration(milliseconds: animationDuration),
      vsync: this,
    );
    _pageController = PageController(
      viewportFraction: _isLowEndDevice ? 0.9 : 0.8,
    );

    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      print('VideoCarousel: Loading YouTube via API...');
      const playlistId = 'PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E';
      const apiKey = 'AIzaSyCuvgQAYv9F5pR1rLGXMnJ7M7mNbLpxG7U';
      final posts = await YouTubeApiService.fetchPlaylistItems(
        apiKey: apiKey,
        playlistId: playlistId,
        maxResults: 25,
      );
      setState(() {
        _videos = posts;
        _isLoading = false;
      });
      // Ensure header and carousel are visible
      try {
        _titleController.forward();
        _carouselController.forward();
      } catch (e) {
        // Controllers already disposed, ignore
      }
    } catch (e) {
      print('Error loading videos: $e');
      setState(() {
        _isLoading = false;
      });
      // Still show header even on error
      try {
        _titleController.forward();
      } catch (e) {
        // Controller already disposed, ignore
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _carouselController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final isMedium = screenWidth < 1000;
    final isLowEnd = screenWidth < 400;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isLowEnd ? 12 : (isSmall ? 16 : 24),
            vertical: isLowEnd ? 20 : (isSmall ? 40 : 80),
          ),
          child: Column(
            children: [
              // Section Title - Static for better performance
              Column(
                children: [
                  Text(
                    'My Videos',
                    style: TextStyle(
                      fontSize:
                          isLowEnd ? 24 : (isSmall ? 28 : (isMedium ? 36 : 48)),
                      fontFamily: AppFonts.samsungOne,
                      fontWeight: AppFonts.extraBold,
                      color: Theme.of(context).colorScheme.onBackground,
                      letterSpacing: isLowEnd ? 1.0 : 1.5,
                    ),
                  ),
                  SizedBox(height: isLowEnd ? 8 : 12),
                  Text(
                    'Check out my latest video content',
                    style: TextStyle(
                      fontSize:
                          isLowEnd ? 12 : (isSmall ? 14 : (isMedium ? 18 : 24)),
                      fontFamily: AppFonts.samsungSharp,
                      fontWeight: AppFonts.regular,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.black54,
                    ),
                  ),
                  SizedBox(
                      height: isLowEnd
                          ? 20
                          : (isSmall ? 32 : (isMedium ? 44 : 60))),
                ],
              ),

              // Video Carousel
              if (_isLoading)
                SizedBox(
                  height: isLowEnd ? 200 : (isSmall ? 300 : 500),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Tokens.primaryGreen,
                    ),
                  ),
                )
              else if (_videos.isEmpty)
                SizedBox(
                  height: isLowEnd ? 200 : (isSmall ? 300 : 500),
                  child: Center(
                    child: Text(
                      'No videos found.',
                      style: TextStyle(
                        fontSize: isLowEnd ? 14 : (isSmall ? 16 : 18),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : Colors.black54,
                        fontFamily: AppFonts.samsungSharp,
                        fontWeight: AppFonts.regular,
                      ),
                    ),
                  ),
                )
              else
                Column(
                  children: [
                    // Carousel with Navigation Buttons - Static for better performance
                    SizedBox(
                      height: isLowEnd ? 200 : (isSmall ? 300 : 500),
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemCount: _videos.length + 1,
                            itemBuilder: (context, index) {
                              if (index == _videos.length) {
                                return _buildViewMoreCard();
                              }
                              return _buildVideoCard(_videos[index], index);
                            },
                          ),

                          // Left Fade Effect (theme-aware)
                          if (_currentIndex > 0)
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: isLowEnd ? 40 : (isSmall ? 60 : 80),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? [
                                            const Color(0xFF0F1412)
                                                .withOpacity(0.9),
                                            const Color(0xFF0F1412)
                                                .withOpacity(0.0),
                                          ]
                                        : [
                                            const Color(0xFF7FEFAC)
                                                .withOpacity(0.3),
                                            const Color(0xFF7FEFAC)
                                                .withOpacity(0.0),
                                          ],
                                  ),
                                ),
                              ),
                            ),

                          // Right Fade Effect (theme-aware)
                          if (_currentIndex < _videos.length)
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: isLowEnd ? 40 : (isSmall ? 60 : 80),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? [
                                            const Color(0xFF0F1412)
                                                .withOpacity(0.9),
                                            const Color(0xFF0F1412)
                                                .withOpacity(0.0),
                                          ]
                                        : [
                                            const Color(0xFF7FEFAC)
                                                .withOpacity(0.3),
                                            const Color(0xFF7FEFAC)
                                                .withOpacity(0.0),
                                          ],
                                  ),
                                ),
                              ),
                            ),

                          // Left Navigation Button
                          if (_currentIndex > 0)
                            Positioned(
                              left: isLowEnd ? 5 : (isSmall ? 10 : 20),
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    width: isLowEnd ? 30 : (isSmall ? 40 : 50),
                                    height: isLowEnd ? 30 : (isSmall ? 40 : 50),
                                    decoration: BoxDecoration(
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? const Color(0xFF1A1A1A)
                                          : Colors.white.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius:
                                              isLowEnd ? 6 : (isSmall ? 8 : 10),
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.black87,
                                      size: isLowEnd ? 12 : (isSmall ? 16 : 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          // Right Navigation Button
                          if (_currentIndex < _videos.length)
                            Positioned(
                              right: isLowEnd ? 5 : (isSmall ? 10 : 20),
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    width: isLowEnd ? 30 : (isSmall ? 40 : 50),
                                    height: isLowEnd ? 30 : (isSmall ? 40 : 50),
                                    decoration: BoxDecoration(
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? const Color(0xFF1A1A1A)
                                          : Colors.white.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius:
                                              isLowEnd ? 6 : (isSmall ? 8 : 10),
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.black87,
                                      size: isLowEnd ? 12 : (isSmall ? 16 : 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: isLowEnd ? 15 : (isSmall ? 20 : 40)),

                    // Indicators (responsive)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _videos.length + 1,
                        (index) {
                          final bool isActive = _currentIndex == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            width: isActive
                                ? (isLowEnd ? 8.0 : (isSmall ? 10.0 : 14.0))
                                : (isLowEnd ? 6.0 : (isSmall ? 8.0 : 12.0)),
                            height: isActive
                                ? (isLowEnd ? 8.0 : (isSmall ? 10.0 : 14.0))
                                : (isLowEnd ? 6.0 : (isSmall ? 8.0 : 12.0)),
                            margin: EdgeInsets.symmetric(
                              horizontal: isLowEnd ? 2 : (isSmall ? 3 : 5),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? const Color(0xFF7FEFAC)
                                  : Colors.grey.withOpacity(0.3),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF7FEFAC)
                                            .withOpacity(0.5),
                                        blurRadius:
                                            isLowEnd ? 6 : (isSmall ? 8 : 12),
                                        spreadRadius: 1,
                                      )
                                    ]
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),

        // Video Player Dialog
        if (_selectedVideo != null)
          EmbeddedYouTubePlayer(
            videoId: _selectedVideo!.id,
            title: _selectedVideo!.caption,
            onClose: () {
              setState(() {
                _selectedVideo = null;
              });
            },
          ),
      ],
    );
  }

  Widget _buildVideoCard(InstagramPost video, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final isLowEnd = screenWidth < 400;

    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: isLowEnd ? 6 : (isSmall ? 8 : 10)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedVideo = video;
          });
        },
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(isLowEnd ? 8 : (isSmall ? 12 : 20)),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  video.thumbnailUrl,
                  fit: BoxFit.cover,
                  cacheWidth: isLowEnd ? 200 : (isSmall ? 300 : 400),
                  cacheHeight: isLowEnd ? 150 : (isSmall ? 200 : 300),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Tokens.primaryGreen,
                          strokeWidth: isLowEnd ? 1 : 2,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(isLowEnd ? 8 : (isSmall ? 12 : 16)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.85)
                      ],
                    ),
                  ),
                  child: Text(
                    video.caption,
                    maxLines: isLowEnd ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: isLowEnd ? 12 : (isSmall ? 14 : 16),
                        fontFamily: AppFonts.samsungSharp,
                        fontWeight: AppFonts.medium),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: isLowEnd ? 40 : (isSmall ? 60 : 80),
                  height: isLowEnd ? 40 : (isSmall ? 60 : 80),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7FEFAC),
                    borderRadius: BorderRadius.circular(
                        isLowEnd ? 20 : (isSmall ? 30 : 40)),
                    boxShadow: isLowEnd
                        ? null
                        : [
                            BoxShadow(
                              color: const Color(0xFF7FEFAC).withOpacity(0.5),
                              blurRadius: isSmall ? 20 : 30,
                              spreadRadius: isSmall ? 3 : 5,
                            ),
                          ],
                  ),
                  child: Icon(Icons.play_arrow,
                      color: Colors.white,
                      size: isLowEnd ? 20 : (isSmall ? 30 : 40)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewMoreCard() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final isLowEnd = screenWidth < 400;

    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: isLowEnd ? 6 : (isSmall ? 8 : 10)),
      child: GestureDetector(
        onTap: () {
          _launchURL(
              'https://www.tiktok.com/@swswswsw0?is_from_webapp=1&sender_device=pc');
        },
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(isLowEnd ? 8 : (isSmall ? 12 : 20)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [
                        const Color(0xFF1A1A1A),
                        const Color(0xFF121212),
                        const Color(0xFF0D0D0D),
                      ]
                    : [
                        const Color(0xFF7FEFAC),
                        const Color(0xFF5CDB95),
                        const Color(0xFF4CAF50),
                      ],
              ),
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          isLowEnd ? 8 : (isSmall ? 12 : 20)),
                      color: (Theme.of(context).brightness == Brightness.dark)
                          ? Colors.black.withOpacity(0.15)
                          : Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                // Content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: isLowEnd ? 50 : (isSmall ? 60 : 80),
                        height: isLowEnd ? 50 : (isSmall ? 60 : 80),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              isLowEnd ? 25 : (isSmall ? 30 : 40)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: isLowEnd ? 10 : (isSmall ? 15 : 20),
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.music_note,
                          color: const Color(0xFF7FEFAC),
                          size: isLowEnd ? 25 : (isSmall ? 30 : 40),
                        ),
                      ),
                      SizedBox(height: isLowEnd ? 10 : (isSmall ? 15 : 20)),
                      Text(
                        'View More on',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isLowEnd ? 14 : (isSmall ? 16 : 18),
                          fontFamily: AppFonts.samsungSharp,
                          fontWeight: AppFonts.medium,
                        ),
                      ),
                      Text(
                        'TikTok',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isLowEnd ? 18 : (isSmall ? 20 : 24),
                          fontFamily: AppFonts.samsungSharp,
                          fontWeight: AppFonts.bold,
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
    );
  }
}
