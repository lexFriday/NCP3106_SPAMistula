import 'dart:convert';
import 'package:flutter/services.dart';
import 'instagram_service.dart';

class InstagramJsonService {
  static Future<List<InstagramPost>> getInstagramPosts() async {
    try {
      // Load posts from JSON file
      final String jsonString =
          await rootBundle.loadString('assets/data/instagram_posts.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> postsList = jsonData['posts'] ?? [];

      List<InstagramPost> posts = [];

      for (var postData in postsList) {
        posts.add(InstagramPost.fromJson(postData));
      }

      // Sort by timestamp (newest first)
      posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return posts;
    } catch (e) {
      print('Error loading Instagram posts from JSON: $e');
      return _getFallbackPosts();
    }
  }

  // Fallback posts if JSON loading fails
  static List<InstagramPost> _getFallbackPosts() {
    return [
      InstagramPost(
        id: '1',
        caption:
            'Latest coding project! Check out what I\'ve been working on 🚀 #coding #flutter #portfolio',
        mediaUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        thumbnailUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      InstagramPost(
        id: '2',
        caption:
            'Behind the scenes of my latest video creation 📹 #behindthescenes #creative #video',
        mediaUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        thumbnailUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
      ),
      InstagramPost(
        id: '3',
        caption:
            'Creative process: From idea to final video 🎬 #creativeprocess #design #inspiration',
        mediaUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        thumbnailUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
      ),
      InstagramPost(
        id: '4',
        caption:
            'A day in the life of a computer engineering student 💻 #studentlife #engineering #coding',
        mediaUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
        thumbnailUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
      ),
      InstagramPost(
        id: '5',
        caption:
            'Tutorial time! Sharing what I learn with you all 📚 #tutorial #learning #education',
        mediaUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
        thumbnailUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 10)),
      ),
      InstagramPost(
        id: '6',
        caption:
            'Fun moments and memories that make life special ✨ #lifestyle #memories #fun',
        mediaUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
        thumbnailUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 14)),
      ),
    ];
  }
}
