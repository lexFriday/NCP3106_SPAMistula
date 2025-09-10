import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleDriveVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final String videoTitle;

  const GoogleDriveVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.videoTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert Google Drive URL to view format
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

            // Video Player Placeholder
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 80,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Click to open video in Google Drive',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final Uri url = Uri.parse(viewUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Open Video'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
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
