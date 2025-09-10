import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class GoogleDriveFinalPlayer extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;

  const GoogleDriveFinalPlayer({
    Key? key,
    required this.videoUrl,
    required this.videoTitle,
  }) : super(key: key);

  @override
  State<GoogleDriveFinalPlayer> createState() => _GoogleDriveFinalPlayerState();
}

class _GoogleDriveFinalPlayerState extends State<GoogleDriveFinalPlayer> {
  bool _isLoading = false;

  String _extractFileId(String videoUrl) {
    // Extract file ID from Google Drive URL
    final fileIdMatch = RegExp(r'/file/d/([^/]+)').firstMatch(videoUrl);
    if (fileIdMatch != null) {
      return fileIdMatch.group(1)!;
    }

    // If it's already a download URL, convert it
    final downloadMatch = RegExp(r'id=([^&]+)').firstMatch(videoUrl);
    if (downloadMatch != null) {
      return downloadMatch.group(1)!;
    }

    // Fallback - return the URL as is
    return videoUrl;
  }

  Future<void> _playVideo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final fileId = _extractFileId(widget.videoUrl);
      final playUrl = 'https://drive.google.com/file/d/$fileId/preview';

      // Open in new window/tab
      final uri = Uri.parse(playUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Fallback to window.open
        html.window.open(playUrl, '_blank');
      }
    } catch (e) {
      print('Error playing video: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.videoTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Video Player Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Video Thumbnail/Preview
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.play_circle_filled,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Video Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        widget.videoTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Play Button
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _playVideo,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.play_arrow, size: 24),
                      label: Text(
                        _isLoading ? 'Opening Video...' : 'Play Video',
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Info Text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Video will open in a new tab/window',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
}
