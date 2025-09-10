import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/samsung_one_ui_theme.dart';
import '../services/youtube_api_service.dart';
import '../services/instagram_service.dart';
import 'samsung_video_player.dart';

class SimpleVideosSection extends StatefulWidget {
  const SimpleVideosSection({super.key});

  @override
  State<SimpleVideosSection> createState() => _SimpleVideosSectionState();
}

class _SimpleVideosSectionState extends State<SimpleVideosSection> {
  final PageController _pageController = PageController();
  List<InstagramPost> _videos = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadVideos() async {
    try {
      const playlistId = 'PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E';
      const apiKey = 'AIzaSyCuvgQAYv9F5pR1rLGXMnJ7M7mNbLpxG7U';
      final posts = await YouTubeApiService.fetchPlaylistItems(
        apiKey: apiKey,
        playlistId: playlistId,
        maxResults: 10,
      );
      setState(() {
        _videos = posts;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading videos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchTikTok() async {
    const url = 'https://www.tiktok.com/@swswswsw0';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building SimpleVideosSection');
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? SamsungOneUITheme.spacingL : SamsungOneUITheme.spacingXXL,
        vertical: SamsungOneUITheme.spacingXXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: EdgeInsets.all(SamsungOneUITheme.spacingXL),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFF0000).withOpacity(0.1),
                  const Color(0xFFFF0000).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusXL),
              border: Border.all(
                color: const Color(0xFFFF0000).withOpacity(0.3),
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
                        color: const Color(0xFFFF0000).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                      ),
                      child: Icon(
                        Icons.play_circle_outline,
                        color: const Color(0xFFFF0000),
                        size: 32,
                      ),
                    ),
                    SizedBox(width: SamsungOneUITheme.spacingL),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Video Content & Reels',
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFFF0000),
                            ),
                          ),
                          SizedBox(height: SamsungOneUITheme.spacingS),
                          Text(
                            'Creative video content showcasing my projects and lifestyle',
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

          // Videos Content
          if (_isLoading)
            Container(
              height: 600,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                border: Border.all(
                  color: SamsungOneUITheme.primaryBlue.withOpacity(0.2),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: SamsungOneUITheme.primaryBlue,
                    ),
                    SizedBox(height: SamsungOneUITheme.spacingM),
                    Text(
                      'Loading videos...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          else if (_videos.isEmpty)
            Container(
              height: 600,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                border: Border.all(
                  color: SamsungOneUITheme.primaryBlue.withOpacity(0.2),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.video_library_outlined,
                      size: 80,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    ),
                    SizedBox(height: SamsungOneUITheme.spacingM),
                    Text(
                      'No videos available',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Column(
              children: [
                // Large Portrait Video Carousel
                Container(
                  height: isMobile ? 500 : 700,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                    border: Border.all(
                      color: SamsungOneUITheme.primaryBlue.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Video Display
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemCount: _videos.length,
                          itemBuilder: (context, index) {
                            return _buildPortraitVideoCard(context, _videos[index], isMobile);
                          },
                        ),
                      ),

                      // Navigation Controls
                      Container(
                        padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(SamsungOneUITheme.radiusM),
                            bottomRight: Radius.circular(SamsungOneUITheme.radiusM),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Previous Button
                            IconButton(
                              onPressed: _currentIndex > 0
                                  ? () {
                                      _pageController.previousPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  : null,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: _currentIndex > 0
                                    ? SamsungOneUITheme.primaryBlue
                                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                              ),
                            ),

                            const Spacer(),

                            // Page Indicators
                            Row(
                              children: List.generate(_videos.length, (index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  width: _currentIndex == index ? 24 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _currentIndex == index
                                        ? SamsungOneUITheme.primaryBlue
                                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              }),
                            ),

                            const Spacer(),

                            // Next Button
                            IconButton(
                              onPressed: _currentIndex < _videos.length - 1
                                  ? () {
                                      _pageController.nextPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  : null,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: _currentIndex < _videos.length - 1
                                    ? SamsungOneUITheme.primaryBlue
                                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: SamsungOneUITheme.spacingXXL),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _launchTikTok,
                            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: SamsungOneUITheme.spacingL,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.music_note_outlined, color: Colors.white),
                                  SizedBox(width: SamsungOneUITheme.spacingM),
                                  Text(
                                    'View More on TikTok',
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
                    SizedBox(width: SamsungOneUITheme.spacingL),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFF0000),
                              const Color(0xFFFF0000).withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF0000).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              const url = 'https://www.youtube.com/playlist?list=PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                              }
                            },
                            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: SamsungOneUITheme.spacingL,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.play_circle_outline, color: Colors.white),
                                  SizedBox(width: SamsungOneUITheme.spacingM),
                                  Text(
                                    'YouTube Playlist',
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
        ],
      ),
    );
  }

  Widget _buildPortraitVideoCard(BuildContext context, InstagramPost video, bool isMobile) {
    return Container(
      margin: EdgeInsets.all(SamsungOneUITheme.spacingL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
        child: Stack(
          children: [
            // Video Thumbnail
            Positioned.fill(
              child: Image.network(
                video.thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: SamsungOneUITheme.primaryBlue,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                    child: Icon(
                      Icons.video_library_outlined,
                      size: 80,
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
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),

            // Large Play Button Overlay
            Center(
              child: GestureDetector(
                onTap: () {
                  _showVideoPlayer(context, video);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),

            // Video Info
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video Title
                    Text(
                      video.caption,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: SamsungOneUITheme.spacingS),
                    // Tags
                    Wrap(
                      spacing: SamsungOneUITheme.spacingS,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SamsungOneUITheme.spacingS,
                            vertical: SamsungOneUITheme.spacingXS,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF0000).withOpacity(0.9),
                            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
                          ),
                          child: Text(
                            'REEL',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SamsungOneUITheme.spacingS,
                            vertical: SamsungOneUITheme.spacingXS,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Text(
                            'CREATIVE',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVideoPlayer(BuildContext context, InstagramPost video) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SamsungVideoPlayer(
        video: video,
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }
}


