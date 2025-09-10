import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InstagramEmbedPlayer extends StatefulWidget {
  final String instagramUrl;

  const InstagramEmbedPlayer({Key? key, required this.instagramUrl})
      : super(key: key);

  @override
  State<InstagramEmbedPlayer> createState() => _InstagramEmbedPlayerState();
}

class _InstagramEmbedPlayerState extends State<InstagramEmbedPlayer> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Instagram Video',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // Instagram Embed
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildInstagramEmbed(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstagramEmbed() {
    // For web, we'll use an iframe approach
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.play_circle_outline,
            size: 80,
            color: Color(0xFFE4405F),
          ),
          const SizedBox(height: 20),
          const Text(
            'Instagram Video',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Click below to view this video on Instagram',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () async {
              final url = widget.instagramUrl.replaceAll('/embed/', '');
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url),
                    mode: LaunchMode.externalApplication);
              }
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('View on Instagram'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE4405F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
