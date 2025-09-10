import 'package:flutter/material.dart';
import 'dart:html' as html;

class GoogleDriveEmbeddedPlayer extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;

  const GoogleDriveEmbeddedPlayer({
    Key? key,
    required this.videoUrl,
    required this.videoTitle,
  }) : super(key: key);

  @override
  State<GoogleDriveEmbeddedPlayer> createState() =>
      _GoogleDriveEmbeddedPlayerState();
}

class _GoogleDriveEmbeddedPlayerState extends State<GoogleDriveEmbeddedPlayer> {
  bool _isLoaded = false;
  late html.IFrameElement _iframe;

  @override
  void initState() {
    super.initState();
    _createIframe();
  }

  void _createIframe() {
    final fileId = _extractFileId(widget.videoUrl);
    // Use a different embed URL format that works better
    final embedUrl = 'https://drive.google.com/file/d/$fileId/preview';

    _iframe = html.IFrameElement()
      ..src = embedUrl
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true
      ..allow = 'autoplay; encrypted-media; fullscreen'
      ..onLoad.listen((event) {
        setState(() {
          _isLoaded = true;
        });
      });

    // Create a container and append iframe
    final container = html.DivElement()
      ..id = 'video-container-${DateTime.now().millisecondsSinceEpoch}'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.position = 'relative'
      ..append(_iframe);

    // Add to DOM
    html.document.body?.append(container);
  }

  @override
  void dispose() {
    _iframe.parent?.remove();
    super.dispose();
  }

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
                    onPressed: () {
                      _iframe.parent?.remove();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Video Player
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: _isLoaded
                    ? const Center(
                        child: Text(
                          'Video is playing in background',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Loading video...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
    );
  }
}
