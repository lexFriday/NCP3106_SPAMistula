import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleDriveDirectPlayer extends StatelessWidget {
  final String videoUrl;
  final String videoTitle;

  const GoogleDriveDirectPlayer({
    Key? key,
    required this.videoUrl,
    required this.videoTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewUrl = _convertToViewUrl(videoUrl);

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
                      videoTitle,
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
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24, width: 2),
                      ),
                      child: const Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Video Info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Text(
                            videoTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Click the button below to watch this video in Google Drive',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            final Uri url = Uri.parse(viewUrl);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Watch Video'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE4405F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                          label: const Text('Close'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Additional Info
                    const Text(
                      'The video will open in a new tab for the best viewing experience',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
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

  String _convertToViewUrl(String videoUrl) {
    // Extract file ID from Google Drive URL
    final fileIdMatch = RegExp(r'/file/d/([^/]+)').firstMatch(videoUrl);
    if (fileIdMatch != null) {
      final fileId = fileIdMatch.group(1);
      return 'https://drive.google.com/file/d/$fileId/view';
    }

    // If it's already a download URL, convert it
    final downloadMatch = RegExp(r'id=([^&]+)').firstMatch(videoUrl);
    if (downloadMatch != null) {
      final fileId = downloadMatch.group(1);
      return 'https://drive.google.com/file/d/$fileId/view';
    }

    // Fallback to original URL
    return videoUrl;
  }
}
