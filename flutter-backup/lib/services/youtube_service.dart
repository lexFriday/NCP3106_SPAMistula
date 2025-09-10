import '../services/instagram_service.dart';

class YouTubeService {
  static List<InstagramPost> fromVideoIds(List<String> videoIds) {
    return videoIds.map((id) {
      final thumbnail = 'https://img.youtube.com/vi/$id/hqdefault.jpg';
      final embedUrl = 'https://www.youtube.com/embed/$id';
      final title = id; // Placeholder title; replace if you have real titles
      return InstagramPost(
        id: id,
        caption: title,
        mediaUrl: embedUrl,
        thumbnailUrl: thumbnail,
        permalink: 'https://www.youtube.com/watch?v=$id',
        mediaType: 'YOUTUBE',
        timestamp: DateTime.now(),
      );
    }).toList();
  }
}

