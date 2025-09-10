import 'package:flutter/material.dart';
import 'dart:html' as html;

class YouTubeEmbeddedPlayer extends StatelessWidget {
  final String videoId;
  final double width;
  final double height;

  const YouTubeEmbeddedPlayer({
    super.key,
    required this.videoId,
    this.width = 560,
    this.height = 315,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: HtmlElementView(
        viewType: 'youtube-player-$videoId',
        onPlatformViewCreated: (int id) {
          _createYouTubePlayer(videoId);
        },
      ),
    );
  }

  void _createYouTubePlayer(String videoId) {
    final iframe = html.IFrameElement()
      ..src = 'https://www.youtube.com/embed/$videoId?autoplay=1&rel=0'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true;

    // Find the container and append the iframe
    final container = html.document.querySelector('#youtube-player-$videoId');
    if (container != null) {
      container.children.clear();
      container.append(iframe);
    }
  }
}

// Alternative widget for non-web platforms
class YouTubePlayerPlaceholder extends StatelessWidget {
  final String videoId;
  final String thumbnailUrl;
  final VoidCallback onTap;

  const YouTubePlayerPlaceholder({
    super.key,
    required this.videoId,
    required this.thumbnailUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Thumbnail
          Positioned.fill(
            child: Image.network(
              thumbnailUrl,
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

          // Play Button
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),

          // YouTube Logo
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'YouTube',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
