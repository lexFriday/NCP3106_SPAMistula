import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../constants/samsung_one_ui_theme.dart';

class ClickToPlayVideo extends StatelessWidget {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final VoidCallback onClose;

  const ClickToPlayVideo({
    super.key,
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
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
                  child: GestureDetector(
                    onTap: () {
                      html.window.open('https://www.youtube.com/watch?v=$videoId', '_blank');
                    },
                    child: Stack(
                      children: [
                        // Video thumbnail
                        Positioned.fill(
                          child: Image.network(
                            thumbnailUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey[300],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: const Color(0xFFFF0000),
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
                          child: Container(
                            width: 120,
                            height: 120,
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
                              size: 60,
                            ),
                          ),
                        ),
                        
                        // Click to play text
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SamsungOneUITheme.spacingM,
                              vertical: SamsungOneUITheme.spacingS,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: SamsungOneUITheme.spacingL,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
                            ),
                            child: Text(
                              'Click to play video in YouTube',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        
                        // YouTube logo
                        Positioned(
                          top: 10,
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
                    child: ElevatedButton.icon(
                      onPressed: () {
                        html.window.open('https://www.youtube.com/watch?v=$videoId', '_blank');
                      },
                      icon: Icon(Icons.play_arrow),
                      label: Text('Play Video'),
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
}

