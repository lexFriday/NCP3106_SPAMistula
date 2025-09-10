import 'package:flutter/material.dart';
import '../services/instagram_service.dart';
import 'embedded_youtube_player.dart';

class SamsungVideoPlayer extends StatelessWidget {
  final InstagramPost video;
  final VoidCallback onClose;

  const SamsungVideoPlayer({
    super.key,
    required this.video,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return EmbeddedYouTubePlayer(
      videoId: video.id,
      title: video.caption,
      onClose: onClose,
    );
  }
}
