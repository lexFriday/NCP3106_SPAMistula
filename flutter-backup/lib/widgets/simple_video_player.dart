import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../constants/samsung_one_ui_theme.dart';

class SimpleVideoPlayer extends StatelessWidget {
  final String videoId;
  final String title;
  final VoidCallback onClose;

  const SimpleVideoPlayer({
    super.key,
    required this.videoId,
    required this.title,
    required this.onClose,
  });

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
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            // Video Player Area - Direct iframe embed
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
                  child: _buildIframePlayer(),
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
                        html.window.open('https://www.youtube.com/watch?v=$videoId', '_blank');
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

  Widget _buildIframePlayer() {
    // Create the iframe URL with autoplay
    final embedUrl = 'https://www.youtube.com/embed/$videoId?autoplay=1&rel=0&modestbranding=1&showinfo=0&controls=1';
    
    return HtmlElementView(
      viewType: 'youtube-iframe-$videoId',
      onPlatformViewCreated: (int id) {
        _createIframe(embedUrl);
      },
    );
  }

  void _createIframe(String embedUrl) {
    // Create iframe element
    final iframe = html.IFrameElement()
      ..src = embedUrl
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true
      ..allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';

    // Find the container and add the iframe
    final container = html.document.querySelector('#youtube-iframe-$videoId');
    if (container != null) {
      container.children.clear();
      container.append(iframe);
    }
  }
}