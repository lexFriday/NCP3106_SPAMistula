import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import '../constants/samsung_one_ui_theme.dart';

class EmbeddedYouTubePlayer extends StatefulWidget {
  final String videoId;
  final String title;
  final VoidCallback onClose;

  const EmbeddedYouTubePlayer({
    super.key,
    required this.videoId,
    required this.title,
    required this.onClose,
  });

  @override
  State<EmbeddedYouTubePlayer> createState() => _EmbeddedYouTubePlayerState();
}

class _EmbeddedYouTubePlayerState extends State<EmbeddedYouTubePlayer> {
  late String _iframeId;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _iframeId = 'youtube_player_${DateTime.now().millisecondsSinceEpoch}';
    _initializePlayer();
  }

  void _initializePlayer() {
    // Register the iframe view factory
    ui_web.platformViewRegistry.registerViewFactory(
      _iframeId,
      (int viewId) {
        final iframe = html.IFrameElement()
          ..width = '100%'
          ..height = '100%'
          ..src = 'https://www.youtube.com/embed/${widget.videoId}?autoplay=1&rel=0&modestbranding=1&showinfo=0&controls=1&enablejsapi=1&origin=${html.window.location.origin}'
          ..style.border = 'none'
          ..allowFullscreen = true
          ..allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share'
          ..onLoad.listen((_) {
            setState(() {
              _isPlayerReady = true;
            });
          });

        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;
    
    // Portrait aspect ratio for reels (9:16) - larger for better viewing
    final portraitWidth = isMobile ? screenWidth * 0.85 : 450.0;
    final portraitHeight = portraitWidth * (16 / 9); // Portrait ratio (height > width)
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: portraitWidth,
        height: portraitHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
              decoration: BoxDecoration(
                color: const Color(0xFFFF0000).withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(SamsungOneUITheme.radiusL),
                  topRight: Radius.circular(SamsungOneUITheme.radiusL),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    color: const Color(0xFFFF0000),
                    size: 24,
                  ),
                  SizedBox(width: SamsungOneUITheme.spacingM),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onClose,
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            // Video Player Area
            Expanded(
              child: Container(
                margin: EdgeInsets.all(SamsungOneUITheme.spacingL),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusM),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusM),
                  child: Stack(
                    children: [
                      // YouTube Player
                      Positioned.fill(
                        child: HtmlElementView(viewType: _iframeId),
                      ),
                      
                      // Loading indicator
                      if (!_isPlayerReady)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: const Color(0xFFFF0000),
                                  ),
                                  SizedBox(height: SamsungOneUITheme.spacingM),
                                  Text(
                                    'Loading video...',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
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
            ),
            
            // Action Buttons
            Container(
              padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        html.window.open('https://www.youtube.com/watch?v=${widget.videoId}', '_blank');
                      },
                      icon: Icon(Icons.open_in_new),
                      label: Text('Open in YouTube'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFFF0000),
                        padding: EdgeInsets.symmetric(
                          vertical: SamsungOneUITheme.spacingM,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusM),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: SamsungOneUITheme.spacingM),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        html.window.open('https://www.tiktok.com/@swswswsw0', '_blank');
                      },
                      icon: Icon(Icons.music_note_outlined),
                      label: Text('View on TikTok'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          vertical: SamsungOneUITheme.spacingM,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusM),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
