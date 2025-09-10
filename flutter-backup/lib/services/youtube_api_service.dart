import 'dart:convert';
import 'package:http/http.dart' as http;
import 'instagram_service.dart';

class YouTubeApiService {
  static const String _apiBase = 'https://www.googleapis.com/youtube/v3';

  static Future<List<InstagramPost>> fetchPlaylistItems({
    required String apiKey,
    required String playlistId,
    int maxResults = 25,
  }) async {
    final List<InstagramPost> posts = [];
    String? pageToken;

    do {
      final uri = Uri.parse(
        '$_apiBase/playlistItems?part=snippet&playlistId=$playlistId&maxResults=$maxResults&key=$apiKey${pageToken != null ? '&pageToken=$pageToken' : ''}',
      );
      final resp = await http.get(uri);
      if (resp.statusCode != 200) {
        throw Exception('YouTube API error ${resp.statusCode}: ${resp.body}');
      }
      final data = json.decode(resp.body) as Map<String, dynamic>;
      pageToken = data['nextPageToken'] as String?;

      final items = (data['items'] as List<dynamic>? ?? []);
      for (final item in items) {
        final snippet = item['snippet'] as Map<String, dynamic>?;
        if (snippet == null) continue;
        final resourceId = snippet['resourceId'] as Map<String, dynamic>?;
        final videoId =
            resourceId != null ? resourceId['videoId'] as String? : null;
        if (videoId == null) continue;
        final title = (snippet['title'] as String?)?.trim() ?? videoId;
        final publishedAtStr = snippet['publishedAt'] as String?;
        DateTime publishedAt;
        try {
          publishedAt = DateTime.parse(
              publishedAtStr ?? DateTime.now().toIso8601String());
        } catch (_) {
          publishedAt = DateTime.now();
        }
        // Prefer high->medium->default
        final thumbs = snippet['thumbnails'] as Map<String, dynamic>?;
        String thumbUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
        if (thumbs != null) {
          if (thumbs['maxres'] != null)
            thumbUrl = thumbs['maxres']['url'] as String;
          else if (thumbs['standard'] != null)
            thumbUrl = thumbs['standard']['url'] as String;
          else if (thumbs['high'] != null)
            thumbUrl = thumbs['high']['url'] as String;
          else if (thumbs['medium'] != null)
            thumbUrl = thumbs['medium']['url'] as String;
          else if (thumbs['default'] != null)
            thumbUrl = thumbs['default']['url'] as String;
        }

        posts.add(
          InstagramPost(
            id: videoId,
            caption: title,
            mediaUrl: 'https://www.youtube.com/embed/$videoId',
            thumbnailUrl: thumbUrl,
            permalink: 'https://www.youtube.com/watch?v=$videoId',
            mediaType: 'YOUTUBE',
            timestamp: publishedAt,
          ),
        );
      }

      // For now, fetch only first page unless list is small
      // Break to avoid hitting quota unnecessarily
      break;
    } while (pageToken != null);

    return posts;
  }
}

