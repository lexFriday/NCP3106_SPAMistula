import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../constants/samsung_one_ui_theme.dart';

class DirectVideoPlayer extends StatefulWidget {
  final String videoId;
  final String title;
  final VoidCallback onClose;

  const DirectVideoPlayer({
    super.key,
    required this.videoId,
    required this.title,
    required this.onClose,
  });

  @override
  State<DirectVideoPlayer> createState() => _DirectVideoPlayerState();
}

class _DirectVideoPlayerState extends State<DirectVideoPlayer> {
  @override
  void initState() {
    super.initState();
    _createIframe();
  }

  void _createIframe() {
    // Create iframe element directly
    final iframe = html.IFrameElement()
      ..src = 'https://www.youtube.com/embed/${widget.videoId}?autoplay=1&rel=0&modestbranding=1&showinfo=0&controls=1'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true
      ..allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';

    // Add to document body temporarily for testing
    html.document.body?.append(iframe);
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
            
            // Video Player Area - Simple approach
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
                  child: _buildVideoContent(),
                ),
              ),
            ),
            
            // Action Buttons
            Container(
              padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        html.window.open('https://www.youtube.com/watch?v=${widget.videoId}', '_blank');
                      },
                      icon: Icon(Icons.open_in_new),
                      label: Text('Open in YouTube'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF0000),
                        foregroundColor: Colors.white,
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

  Widget _buildVideoContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Video thumbnail with play button
          Positioned.fill(
            child: Image.network(
              'https://img.youtube.com/vi/${widget.videoId}/maxresdefault.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.video_library_outlined,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
          
          // Play button overlay
          Center(
            child: GestureDetector(
              onTap: () {
                _openVideoInNewTab();
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
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
          
          // YouTube logo
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'YouTube',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openVideoInNewTab() {
    html.window.open('https://www.youtube.com/watch?v=${widget.videoId}', '_blank');
  }
}

