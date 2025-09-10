import 'dart:convert';
import 'package:http/http.dart' as http;
import 'instagram_service.dart';

class YouTubePlaylistService {
  static Future<List<InstagramPost>> getPlaylistVideos(
      String playlistId) async {
    final feedUrl = Uri.parse(
        'https://www.youtube.com/feeds/videos.xml?playlist_id=$playlistId');
    try {
      final resp = await http.get(feedUrl);
      if (resp.statusCode != 200) {
        throw Exception('HTTP ${resp.statusCode}');
      }
      final xml = resp.body;

      final entries = _splitEntries(xml);
      final posts = <InstagramPost>[];
      for (final entry in entries) {
        final id =
            _firstMatch(entry, RegExp(r'<yt:videoId>([^<]+)</yt:videoId>'));
        if (id == null) continue;
        final title =
            _firstMatch(entry, RegExp(r'<title>([^<]+)</title>')) ?? id;
        final thumb =
            _firstAttr(entry, RegExp(r'<media:thumbnail[^>]*url="([^"]+)"')) ??
                'https://img.youtube.com/vi/$id/hqdefault.jpg';

        posts.add(
          InstagramPost(
            id: id,
            caption: title,
            mediaUrl: 'https://www.youtube.com/embed/$id',
            thumbnailUrl: thumb,
            permalink: 'https://www.youtube.com/watch?v=$id',
            mediaType: 'YOUTUBE',
            timestamp: DateTime.now(),
          ),
        );
      }
      return posts;
    } catch (e) {
      // On failure, return empty to allow UI fallback
      return [];
    }
  }

  static List<String> _splitEntries(String xml) {
    final matches = RegExp(r'<entry>[\s\S]*?</entry>').allMatches(xml);
    return matches.map((m) => m.group(0)!).toList();
  }

  static String? _firstMatch(String text, RegExp re) {
    final m = re.firstMatch(text);
    return m != null ? m.group(1) : null;
  }

  static String? _firstAttr(String text, RegExp re) {
    final m = re.firstMatch(text);
    return m != null ? m.group(1) : null;
  }
}

