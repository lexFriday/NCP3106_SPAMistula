import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui_web'
    as ui; // Use ui_web for platformViewRegistry on Flutter Web

class GoogleDriveWorkingEmbeddedPlayer extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final VoidCallback? onClose;

  const GoogleDriveWorkingEmbeddedPlayer({
    Key? key,
    required this.videoUrl,
    required this.videoTitle,
    this.onClose,
  }) : super(key: key);

  @override
  State<GoogleDriveWorkingEmbeddedPlayer> createState() =>
      _GoogleDriveWorkingEmbeddedPlayerState();
}

class _GoogleDriveWorkingEmbeddedPlayerState
    extends State<GoogleDriveWorkingEmbeddedPlayer> {
  bool _isLoaded = false;
  late final String _viewType;
  late final html.IFrameElement _iframe;

  @override
  void initState() {
    super.initState();
    _viewType = 'gd-embedded-${DateTime.now().millisecondsSinceEpoch}';
    _registerIframe();
  }

  void _registerIframe() {
    final fileId = _extractFileId(widget.videoUrl);
    final embedUrl = 'https://drive.google.com/file/d/$fileId/preview';

    _iframe = html.IFrameElement()
      ..src = embedUrl
      ..style.border = '0'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allow =
          'autoplay; encrypted-media; fullscreen' // allow takes precedence
      ..referrerPolicy = 'no-referrer'
      ..onLoad.listen((event) {
        if (mounted) {
          setState(() {
            _isLoaded = true;
          });
        }
      });

    // Sandbox: allow scripts + same-origin for Drive preview, but no top navigation
    _iframe.setAttribute(
      'sandbox',
      'allow-scripts allow-same-origin allow-forms allow-presentation allow-popups',
    );

    ui.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      return _iframe;
    });
  }

  void _neutralizeIframe() {
    // Remove same-origin and blank out to avoid console warnings and side effects
    _iframe.setAttribute(
      'sandbox',
      'allow-scripts allow-forms allow-presentation allow-popups',
    );
    _iframe.src = 'about:blank';
  }

  @override
  void dispose() {
    _neutralizeIframe();
    super.dispose();
  }

  String _extractFileId(String videoUrl) {
    final fileIdMatch = RegExp(r'/file/d/([^/]+)').firstMatch(videoUrl);
    if (fileIdMatch != null) return fileIdMatch.group(1)!;
    final downloadMatch = RegExp(r'id=([^&]+)').firstMatch(videoUrl);
    if (downloadMatch != null) return downloadMatch.group(1)!;
    return videoUrl;
  }

  void _closeVideo() {
    _neutralizeIframe();
    if (widget.onClose != null) {
      widget.onClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.6),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.videoTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _closeVideo,
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: HtmlElementView(viewType: _viewType),
                    ),
                    if (!_isLoaded)
                      const Positioned.fill(
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
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
