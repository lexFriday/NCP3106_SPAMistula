import 'dart:convert';
import 'package:http/http.dart' as http;
import 'instagram_service.dart';

class InstagramVideoScraper {
  static Future<String?> getVideoUrlFromReel(String reelUrl) async {
    try {
      print('Fetching video URL from: $reelUrl');

      // Make a request to the Instagram reel page
      final response = await http.get(Uri.parse(reelUrl));

      if (response.statusCode == 200) {
        final html = response.body;

        // Look for video URL patterns in the HTML
        // Instagram typically embeds video URLs in JSON data
        final videoUrlPattern = RegExp(r'"video_url":"([^"]+)"');
        final match = videoUrlPattern.firstMatch(html);

        if (match != null) {
          final videoUrl = match.group(1)!.replaceAll('\\u0026', '&');
          print('Found video URL: $videoUrl');
          return videoUrl;
        }

        // Alternative pattern for different Instagram page structures
        final alternativePattern = RegExp(r'"contentUrl":"([^"]+\.mp4[^"]*)"');
        final altMatch = alternativePattern.firstMatch(html);

        if (altMatch != null) {
          final videoUrl = altMatch.group(1)!.replaceAll('\\u0026', '&');
          print('Found alternative video URL: $videoUrl');
          return videoUrl;
        }
      }

      print('Could not extract video URL from Instagram reel');
      return null;
    } catch (e) {
      print('Error fetching Instagram video URL: $e');
      return null;
    }
  }

  static Future<List<InstagramPost>> getInstagramPostsWithVideos() async {
    final List<Map<String, String>> reelData = [
      {
        'id': 'DJq5ZYtvcbK',
        'url': 'https://www.instagram.com/reel/DJq5ZYtvcbK/',
        'caption':
            'Latest coding project! Check out what I\'ve been working on 🚀 #coding #flutter #portfolio',
      },
      {
        'id': 'DHpxXnKTzhs',
        'url': 'https://www.instagram.com/reel/DHpxXnKTzhs/',
        'caption':
            'Behind the scenes of my latest video creation 📹 #behindthescenes #creative #video',
      },
      {
        'id': 'DAdTg09Prd5',
        'url': 'https://www.instagram.com/reel/DAdTg09Prd5/',
        'caption':
            'Creative process: From idea to final video 🎬 #creativeprocess #design #inspiration',
      },
    ];

    List<InstagramPost> posts = [];

    for (int i = 0; i < reelData.length; i++) {
      final data = reelData[i];
      final videoUrl = await getVideoUrlFromReel(data['url']!);

      posts.add(InstagramPost(
        id: data['id']!,
        caption: data['caption']!,
        mediaUrl: videoUrl ??
            data['url']!, // Fallback to original URL if video URL not found
        thumbnailUrl: _getThumbnailUrl(i),
        permalink: data['url']!,
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(Duration(days: i * 2)),
      ));
    }

    // Add some duplicate posts to fill the grid
    for (int i = 0; i < 3; i++) {
      final originalPost = posts[i % posts.length];
      posts.add(InstagramPost(
        id: '${originalPost.id}_copy_$i',
        caption: originalPost.caption,
        mediaUrl: originalPost.mediaUrl,
        thumbnailUrl: originalPost.thumbnailUrl,
        permalink: originalPost.permalink,
        mediaType: originalPost.mediaType,
        timestamp: DateTime.now().subtract(Duration(days: (i + 3) * 2)),
      ));
    }

    return posts;
  }

  static String _getThumbnailUrl(int index) {
    final List<String> thumbnails = [
      'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1517077304055-6e89abbf09b0?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop',
      'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400&h=400&fit=crop',
    ];

    return thumbnails[index % thumbnails.length];
  }
}

