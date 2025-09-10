import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/google_drive_scraper_service.dart';
import '../services/instagram_service.dart';
import 'video_player_widget.dart';

class InstagramGallery extends StatefulWidget {
  const InstagramGallery({super.key});

  @override
  State<InstagramGallery> createState() => _InstagramGalleryState();
}

class _InstagramGalleryState extends State<InstagramGallery>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _gridController;
  late List<AnimationController> _itemControllers;
  List<InstagramPost> _instagramPosts = [];
  bool _isLoading = true;
  InstagramPost? _selectedVideo;

  @override
  void initState() {
    super.initState();
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _gridController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _loadInstagramPosts();
  }

  Future<void> _loadInstagramPosts() async {
    try {
      final posts = await GoogleDriveScraperService.getGoogleDriveVideos();
      setState(() {
        _instagramPosts = posts;
        _isLoading = false;
      });

      // Initialize item controllers after loading posts
      _itemControllers = List.generate(
        _instagramPosts.length,
        (index) => AnimationController(
          duration: const Duration(milliseconds: 400),
          vsync: this,
        ),
      );

      // Start animations
      Future.delayed(const Duration(milliseconds: 300), () {
        _titleController.forward();
      });
      Future.delayed(const Duration(milliseconds: 600), () {
        _gridController.forward();
      });
    } catch (e) {
      print('Error loading Instagram posts: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _gridController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
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
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Column(
            children: [
              // Section Title
              AnimatedBuilder(
                animation: _titleController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 50 * (1 - _titleController.value)),
                    child: Opacity(
                      opacity: _titleController.value,
                      child: Column(
                        children: [
                          const Text(
                            'MY INSTAGRAM',
                            style: TextStyle(
                              fontSize: 48,
                              fontFamily: 'SFUI',
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Check out my latest videos and content',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'SFUI-light',
                              fontWeight: FontWeight.w300,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Instagram Grid
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFE4405F),
                  ),
                )
              else
                AnimatedBuilder(
                  animation: _gridController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 100 * (1 - _gridController.value)),
                      child: Opacity(
                        opacity: _gridController.value,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final isSmallScreen = constraints.maxWidth < 800;
                            final crossAxisCount = isSmallScreen ? 2 : 3;
                            final childAspectRatio = isSmallScreen ? 0.8 : 1.0;

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: childAspectRatio,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24,
                              ),
                              itemCount: _instagramPosts.length,
                              itemBuilder: (context, index) {
                                if (index >= _instagramPosts.length ||
                                    index >= _itemControllers.length)
                                  return const SizedBox();

                                return _buildInstagramCard(
                                  _instagramPosts[index],
                                  index,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 60),

              // Follow Button
              AnimatedBuilder(
                animation: _gridController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 50 * (1 - _gridController.value)),
                    child: Opacity(
                      opacity: _gridController.value,
                      child: _buildFollowButton(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Video Player Dialog
        if (_selectedVideo != null)
          VideoPlayerWidget(
            videoUrl: _selectedVideo!.mediaUrl,
          ),
      ],
    );
  }

  Widget _buildInstagramCard(InstagramPost post, int index) {
    return MouseRegion(
      onEnter: (_) => _itemControllers[index].forward(),
      onExit: (_) => _itemControllers[index].reverse(),
      child: GestureDetector(
        onTap: () {
          print('Tapped on post: ${post.mediaType} - ${post.caption}');
          if (post.mediaType == 'VIDEO') {
            print('Opening video player for: ${post.caption}');
            setState(() {
              _selectedVideo = post;
            });
          } else {
            print('Redirecting to Instagram for: ${post.caption}');
            _launchURL(post.permalink);
          }
        },
        child: AnimatedBuilder(
          animation: _itemControllers[index],
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (0.1 * _itemControllers[index].value),
              child: Transform.translate(
                offset: Offset(0, -15 * _itemControllers[index].value),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE4405F).withOpacity(
                          0.4 * _itemControllers[index].value,
                        ),
                        blurRadius: 25,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.2 * _itemControllers[index].value),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Background Image/Video Thumbnail
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(post.thumbnailUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Overlay with content
                        Container(
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

                        // Content
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.caption.length > 30
                                      ? '${post.caption.substring(0, 30)}...'
                                      : post.caption,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'SFUI',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _formatDate(post.timestamp),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'SFUI-light',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Play button for videos
                        if (post.mediaType == 'VIDEO')
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE4405F),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFE4405F)
                                          .withOpacity(0.5),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Widget _buildFollowButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL('https://www.instagram.com/shaun_mistula/'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFE4405F),
                Color(0xFF833AB4),
                Color(0xFFF77737),
              ],
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE4405F).withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'FOLLOW ON INSTAGRAM',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'SFUI',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
