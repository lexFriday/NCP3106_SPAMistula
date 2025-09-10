import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../constants/samsung_one_ui_theme.dart';

class WorkingVideoPlayer extends StatefulWidget {
  final String videoId;
  final String title;
  final VoidCallback onClose;

  const WorkingVideoPlayer({
    super.key,
    required this.videoId,
    required this.title,
    required this.onClose,
  });

  @override
  State<WorkingVideoPlayer> createState() => _WorkingVideoPlayerState();
}

class _WorkingVideoPlayerState extends State<WorkingVideoPlayer> {
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _createPlayer();
  }

  void _createPlayer() {
    // Create a unique ID for this player
    final playerId = 'youtube-player-${widget.videoId}-${DateTime.now().millisecondsSinceEpoch}';
    
    // Create the iframe element
    final iframe = html.IFrameElement()
      ..src = 'https://www.youtube.com/embed/${widget.videoId}?autoplay=1&rel=0&modestbranding=1&showinfo=0&controls=1'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true
      ..allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';

    // Create a container div
    final container = html.DivElement()
      ..id = playerId
      ..style.width = '100%'
      ..style.height = '100%'
      ..append(iframe);

    // Add the container to the document
    html.document.body?.append(container);

    // Set up the platform view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isPlayerReady = true;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the iframe when the widget is disposed
    final playerId = 'youtube-player-${widget.videoId}-${DateTime.now().millisecondsSinceEpoch}';
    html.document.getElementById(playerId)?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: isMobile ? screenWidth * 0.95 : 900,
        height: isMobile ? screenWidth * 0.6 : 600,
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
                  child: _buildVideoPlayer(),
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

  Widget _buildVideoPlayer() {
    if (!_isPlayerReady) {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: const Color(0xFFFF0000),
              ),
              SizedBox(height: SamsungOneUITheme.spacingM),
              Text(
                'Loading video player...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    // Use HtmlElementView to embed the iframe
    return HtmlElementView(
      viewType: 'youtube-iframe-${widget.videoId}',
      onPlatformViewCreated: (int id) {
        // The iframe is already created in initState
      },
    );
  }
}

