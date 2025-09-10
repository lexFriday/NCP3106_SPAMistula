import 'dart:convert';
import 'package:http/http.dart' as http;

class InstagramService {
  // Instagram Basic Display API configuration
  static const String _baseUrl = 'https://graph.instagram.com';
  static const String _accessToken =
      'YOUR_INSTAGRAM_ACCESS_TOKEN'; // Replace with your token
  static const String _userId =
      'YOUR_INSTAGRAM_USER_ID'; // Replace with your user ID

  static Future<List<InstagramPost>> getInstagramPosts() async {
    try {
      // First, get user's media
      final mediaResponse = await http.get(
        Uri.parse(
            '$_baseUrl/me/media?fields=id,caption,media_type,media_url,thumbnail_url,permalink,timestamp&access_token=$_accessToken'),
      );

      if (mediaResponse.statusCode == 200) {
        final data = json.decode(mediaResponse.body);
        final List<dynamic> mediaList = data['data'] ?? [];

        List<InstagramPost> posts = [];

        for (var media in mediaList) {
          // Only include videos and images
          if (media['media_type'] == 'VIDEO' ||
              media['media_type'] == 'IMAGE') {
            posts.add(InstagramPost.fromJson(media));
          }
        }

        // Sort by timestamp (newest first)
        posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        // Return only the first 6 posts for the gallery
        return posts.take(6).toList();
      } else {
        print('Error fetching Instagram posts: ${mediaResponse.statusCode}');
        print('Response: ${mediaResponse.body}');
        return _getSamplePosts();
      }
    } catch (e) {
      print('Error fetching Instagram posts: $e');
      return _getSamplePosts();
    }
  }

  // Method to get user info
  static Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/me?fields=id,username,account_type&access_token=$_accessToken'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error fetching user info: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user info: $e');
      return null;
    }
  }

  // Method to get a specific media by ID
  static Future<InstagramPost?> getMediaById(String mediaId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/$mediaId?fields=id,caption,media_type,media_url,thumbnail_url,permalink,timestamp&access_token=$_accessToken'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return InstagramPost.fromJson(data);
      } else {
        print('Error fetching media: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching media: $e');
      return null;
    }
  }

  // Sample data for development/testing
  static List<InstagramPost> _getSamplePosts() {
    return [
      InstagramPost(
        id: '1',
        caption:
            'Latest coding project! Check out what I\'ve been working on 🚀',
        mediaUrl: 'assets/images/insta.png',
        thumbnailUrl: 'assets/images/insta.png',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      InstagramPost(
        id: '2',
        caption: 'Behind the scenes of my latest video creation 📹',
        mediaUrl: 'assets/images/insta.png',
        thumbnailUrl: 'assets/images/insta.png',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
      ),
      InstagramPost(
        id: '3',
        caption: 'Creative process: From idea to final video 🎬',
        mediaUrl: 'assets/images/insta.png',
        thumbnailUrl: 'assets/images/insta.png',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
      ),
      InstagramPost(
        id: '4',
        caption: 'A day in the life of a computer engineering student 💻',
        mediaUrl: 'assets/images/insta.png',
        thumbnailUrl: 'assets/images/insta.png',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
      ),
      InstagramPost(
        id: '5',
        caption: 'Tutorial time! Sharing what I learn with you all 📚',
        mediaUrl: 'assets/images/insta.png',
        thumbnailUrl: 'assets/images/insta.png',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 10)),
      ),
      InstagramPost(
        id: '6',
        caption: 'Fun moments and memories that make life special ✨',
        mediaUrl: 'assets/images/insta.png',
        thumbnailUrl: 'assets/images/insta.png',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: DateTime.now().subtract(const Duration(days: 14)),
      ),
    ];
  }
}

class InstagramPost {
  final String id;
  final String caption;
  final String mediaUrl;
  final String thumbnailUrl;
  final String permalink;
  final String mediaType;
  final DateTime timestamp;

  InstagramPost({
    required this.id,
    required this.caption,
    required this.mediaUrl,
    required this.thumbnailUrl,
    required this.permalink,
    required this.mediaType,
    required this.timestamp,
  });

  factory InstagramPost.fromJson(Map<String, dynamic> json) {
    return InstagramPost(
      id: json['id'] ?? '',
      caption: json['caption'] ?? '',
      mediaUrl: json['media_url'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? json['media_url'] ?? '',
      permalink: json['permalink'] ?? '',
      mediaType: json['media_type'] ?? 'IMAGE',
      timestamp:
          DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caption': caption,
      'media_url': mediaUrl,
      'thumbnail_url': thumbnailUrl,
      'permalink': permalink,
      'media_type': mediaType,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
