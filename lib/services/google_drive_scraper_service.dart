import 'dart:convert';
import 'package:http/http.dart' as http;
import 'instagram_service.dart';

class GoogleDriveScraperService {
  static Future<List<InstagramPost>> getGoogleDriveVideos() async {
    print('GoogleDriveScraperService: Loading your real videos...');

    // Always return your real videos with actual file IDs
    final videos = _createRealVideoPosts();
    print('Loaded ${videos.length} real videos from your Google Drive');

    return videos;
  }

  static List<String> _extractFileIds(String html) {
    // Look for Google Drive file IDs in the HTML
    // Google Drive typically uses patterns like "data-id" or specific URL patterns
    final List<String> fileIds = [];

    // Pattern 1: Look for data-id attributes
    final dataIdPattern = RegExp(r'data-id="([^"]+)"');
    final dataIdMatches = dataIdPattern.allMatches(html);

    for (final match in dataIdMatches) {
      final id = match.group(1)!;
      if (id.length > 20) {
        // Google Drive IDs are typically long
        fileIds.add(id);
        print('Found file ID: $id');
      }
    }

    // Pattern 2: Look for /file/d/ patterns in URLs
    final fileUrlPattern = RegExp(r'/file/d/([^/]+)');
    final fileUrlMatches = fileUrlPattern.allMatches(html);

    for (final match in fileUrlMatches) {
      final id = match.group(1)!;
      if (!fileIds.contains(id)) {
        fileIds.add(id);
        print('Found file ID from URL: $id');
      }
    }

    // Pattern 3: Look for specific video file patterns
    final videoPattern = RegExp(r'"([^"]+\.mp4)"');
    final videoMatches = videoPattern.allMatches(html);

    for (final match in videoMatches) {
      final videoName = match.group(1)!;
      print('Found video file: $videoName');
    }

    return fileIds;
  }

  static List<InstagramPost> _createPostsFromFileIds(List<String> fileIds) {
    final List<Map<String, String>> videoData = [
      {
        'name': 'APRIL_08_MISSION#1_MISTULA.mp4',
        'caption':
            'APRIL 08 MISSION #1 - Latest coding project showcase 🚀 #coding #portfolio #mission',
        'date': '2024-04-07',
      },
      {
        'name': 'AUGUST02_MISSION#3_MISTULA.mp4',
        'caption':
            'AUGUST 02 MISSION #3 - Behind the scenes of my latest video creation 📹 #behindthescenes #creative',
        'date': '2024-08-02',
      },
      {
        'name': 'DECEMBER_20_MISSION_CCLI_MISTULA.mp4',
        'caption':
            'DECEMBER 20 MISSION CCLI - Creative process: From idea to final video 🎬 #creativeprocess #design',
        'date': '2024-12-19',
      },
      {
        'name': 'FEBRUARY_04_MISSION#1_MISTULA.mp4',
        'caption':
            'FEBRUARY 04 MISSION #1 - A day in the life of a computer engineering student 💻 #studentlife #engineering',
        'date': '2024-02-04',
      },
      {
        'name': 'FEBRUARY_22_MISSION#2_MISTULA.mp4',
        'caption':
            'FEBRUARY 22 MISSION #2 - Tutorial time! Sharing what I learn with you all 📚 #tutorial #learning',
        'date': '2024-02-21',
      },
      {
        'name': 'FEBRUARY_28_MISSION#1A_MISTULA.mp4',
        'caption':
            'FEBRUARY 28 MISSION #1A - Fun moments and memories that make life special ✨ #lifestyle #memories',
        'date': '2024-02-28',
      },
    ];

    return videoData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      // Use scraped file ID if available, otherwise use fallback
      final fileId = index < fileIds.length ? fileIds[index] : null;
      final videoUrl = fileId != null
          ? 'https://drive.google.com/uc?export=download&id=$fileId'
          : 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

      print('Creating post for ${data['name']} with URL: $videoUrl');

      final realTitle = _stripExtension(data['name']!);
      final thumbnail = fileId != null
          ? 'https://drive.usercontent.google.com/thumbnail?id=$fileId&sz=w1000'
          : _getThumbnailUrl(index);

      return InstagramPost(
        id: data['name']!,
        caption: realTitle,
        mediaUrl: videoUrl,
        thumbnailUrl: thumbnail,
        permalink: fileId != null
            ? 'https://drive.google.com/file/d/$fileId/view'
            : 'https://drive.google.com/drive/folders/1h-w9-57ouVCK_diL5Kz1E4f-UKCtJL6e?usp=drive_link',
        mediaType: 'VIDEO',
        timestamp: DateTime.parse('${data['date']}T12:00:00Z'),
      );
    }).toList();
  }

  static List<InstagramPost> _createRealVideoPosts() {
    print('Creating real video posts with your actual content...');

    // Your actual videos from the Google Drive folder with real file IDs
    final List<Map<String, dynamic>> videoData = [
      {
        'name': 'APRIL_08_MISSION#1_MISTULA.mp4',
        'caption':
            'APRIL 08 MISSION #1 - Latest coding project showcase 🚀 #coding #portfolio #mission',
        'date': '2024-04-07',
        'fileId': '18G6uCq6LFLRi09fHe6qOxWl_lGV5S11f',
        'size': '362.1 MB',
      },
      {
        'name': 'AUGUST02_MISSION#3_MISTULA.mp4',
        'caption':
            'AUGUST 02 MISSION #3 - Behind the scenes of my latest video creation 📹 #behindthescenes #creative',
        'date': '2024-08-02',
        'fileId': '1akXVkS0N-h3Lz6n6GRaZOGcymx8Wudca',
        'size': '598.1 MB',
      },
      {
        'name': 'DECEMBER_20_MISSION_CCLI_MISTULA.mp4',
        'caption':
            'DECEMBER 20 MISSION CCLI - Creative process: From idea to final video 🎬 #creativeprocess #design',
        'date': '2024-12-19',
        'fileId': '1j676XWO0If0-0hZCVa2w0Caj2sfy-D94',
        'size': '89.3 MB',
      },
      {
        'name': 'FEBRUARY_04_MISSION#1_MISTULA.mp4',
        'caption':
            'FEBRUARY 04 MISSION #1 - A day in the life of a computer engineering student 💻 #studentlife #engineering',
        'date': '2024-02-04',
        'fileId': '1KjopPMuBXrWKxFGhdBEbW4FLHxNa6Fym',
        'size': '104.3 MB',
      },
      {
        'name': 'FEBRUARY_22_MISSION#2_MISTULA.mp4',
        'caption':
            'FEBRUARY 22 MISSION #2 - Tutorial time! Sharing what I learn with you all 📚 #tutorial #learning',
        'date': '2024-02-21',
        'fileId': '1icAJjzASZNSrCR156exbGZ3pQXJUl1Nr',
        'size': '159.1 MB',
      },
      {
        'name': 'FEBRUARY_28_MISSION#1A_MISTULA.mp4',
        'caption':
            'FEBRUARY 28 MISSION #1A - Fun moments and memories that make life special ✨ #lifestyle #memories',
        'date': '2024-02-28',
        'fileId': '1VI1hfewJ3h2nQZTE6J9vTf7nP0m8zq65',
        'size': '278.2 MB',
      },
      {
        'name': 'JANUARY_06_MISSION#2A_MISTULA.mp4',
        'caption':
            'JANUARY 06 MISSION #2A - Creative coding journey and project development 💻 #coding #development',
        'date': '2024-01-06',
        'fileId': '1G5HorsRsZtv1gE7jMKhsCrVCn2vtfDHb',
        'size': '81.9 MB',
      },
      {
        'name': 'JANUARY_22_MISSION#2A_MISTULA.mp4',
        'caption':
            'JANUARY 22 MISSION #2A - Advanced programming techniques and solutions 🚀 #programming #tech',
        'date': '2024-01-22',
        'fileId': '1UWCmjNPQDog6RktHj2SFx59Evuck49ft',
        'size': '93 MB',
      },
      {
        'name': 'JULY13_MISSION#2_MISTULA.mp4',
        'caption':
            'JULY 13 MISSION #2 - Summer coding projects and innovations 🌞 #summer #innovation',
        'date': '2024-07-13',
        'fileId': '1JXLvMNJlNmEc9LKnuut6Te1egEkTGGcj',
        'size': '470.9 MB',
      },
      {
        'name': 'MARCH_25_MISSION#1_MISTULA2.mp4',
        'caption':
            'MARCH 25 MISSION #1 - Spring coding challenges and solutions 🌱 #spring #challenges',
        'date': '2024-03-25',
        'fileId': '1gOPvvvnDqqB3zM2WLjy9SPI5ZcXEpzCk',
        'size': '325.2 MB',
      },
      {
        'name': 'MAY_14_MISSION#1_MISTULA.mp4',
        'caption':
            'MAY 14 MISSION #1 - Mid-year project showcase and achievements 🎯 #showcase #achievements',
        'date': '2024-05-14',
        'fileId': '17TGh02YJdjW3WOLsAjXtNpU3pseI9PYx',
        'size': '398.4 MB',
      },
      {
        'name': 'MAY_28_MISSION#2_MISTULA.mp4',
        'caption':
            'MAY 28 MISSION #2 - Advanced development techniques and best practices 📚 #development #bestpractices',
        'date': '2024-05-28',
        'fileId': '1_ajd-mvxC7MowA140W6U1QR2BNT8yNNI',
        'size': '193 MB',
      },
      {
        'name': 'MISSION#1_GALAXYSTARS_GROUP12.mp4',
        'caption':
            'MISSION #1 GALAXYSTARS GROUP 12 - Collaborative project with team innovation 🌟 #collaboration #teamwork',
        'date': '2024-07-06',
        'fileId': '1KlGEonU6m2rsCqqNOVVmQNfNcSxSuJa6',
        'size': '72 MB',
      },
      {
        'name': 'NOVEMBER_3_MISSION#1A_MISTULA.mp4',
        'caption':
            'NOVEMBER 3 MISSION #1A - Fall semester highlights and achievements 🍂 #fall #highlights',
        'date': '2024-11-03',
        'fileId': '1fuxdrx-sENH4HD9Eo9fLaxOaHCUPO-HU',
        'size': '648.3 MB',
      },
      {
        'name': 'NOVEMBER_15_MISSION#2A_MISTULA.mp4',
        'caption':
            'NOVEMBER 15 MISSION #2A - Mid-month progress and project updates 📊 #progress #updates',
        'date': '2024-11-15',
        'fileId': '1vGfNg5wLlvYqox8ffvGtkYolSDmocsyH',
        'size': '221.5 MB',
      },
      {
        'name': 'NOVEMBER_20_MISSION#1_MISTULA.mp4',
        'caption':
            'NOVEMBER 20 MISSION #1 - Late fall project completion and review 📋 #completion #review',
        'date': '2024-11-20',
        'fileId': '12DVyR0S2LCEMzwNhSWBXTlLFYTfiqMDX',
        'size': '106.1 MB',
      },
      {
        'name': 'SEPTEMBER_28_MISSION#2B_MISTULA.mp4',
        'caption':
            'SEPTEMBER 28 MISSION #2B - End of summer project finalization 🏁 #finalization #summer',
        'date': '2024-09-28',
        'fileId': '1hKhx6Rnv2DtuNbzmBJIsfiRmTbgjszQ8',
        'size': '592.4 MB',
      },
      {
        'name': 'SEPTEMBER_28_MISSION#3A_MISTULA.mp4',
        'caption':
            'SEPTEMBER 28 MISSION #3A - Advanced project implementation and testing 🧪 #implementation #testing',
        'date': '2024-09-28',
        'fileId': '1sSkyYbP7NxfeQSKGHxa6mPAyHG3l4iC3',
        'size': '468.3 MB',
      },
      {
        'name': 'SEPTEMBER3_MISSION#3_MISTULA.mp4',
        'caption':
            'SEPTEMBER 3 MISSION #3 - Early fall semester kickoff and planning 📅 #kickoff #planning',
        'date': '2024-09-03',
        'fileId': '1rICm9RM6uhZqFhGdSPcCC6_9qwYkW4pf',
        'size': '649 MB',
      },
    ];

    final result = videoData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      // Create the proper Google Drive video URL for web playback using preview links
      final fileId = data['fileId'] as String;
      final videoUrl = 'https://drive.google.com/file/d/$fileId/preview';
      final viewUrl = 'https://drive.google.com/file/d/$fileId/view';
      final realTitle = _stripExtension(data['name'] as String);
      final thumbnail =
          'https://drive.usercontent.google.com/thumbnail?id=$fileId&sz=w1000';

      print('Creating video: ${data['name']} with URL: $videoUrl');

      return InstagramPost(
        id: data['name'] as String,
        caption: realTitle,
        mediaUrl: videoUrl,
        thumbnailUrl: thumbnail,
        permalink: viewUrl,
        mediaType: 'VIDEO',
        timestamp: DateTime.parse('${data['date']}T12:00:00Z'),
      );
    }).toList();

    print('Successfully created ${videoData.length} real video posts');
    return result;
  }

  static List<InstagramPost> _getFallbackPosts() {
    print('Using fallback posts with sample videos');

    final List<Map<String, String>> videoData = [
      {
        'name': 'APRIL_08_MISSION#1_MISTULA.mp4',
        'caption':
            'APRIL 08 MISSION #1 - Latest coding project showcase 🚀 #coding #portfolio #mission',
        'date': '2024-04-07',
      },
      {
        'name': 'AUGUST02_MISSION#3_MISTULA.mp4',
        'caption':
            'AUGUST 02 MISSION #3 - Behind the scenes of my latest video creation 📹 #behindthescenes #creative',
        'date': '2024-08-02',
      },
      {
        'name': 'DECEMBER_20_MISSION_CCLI_MISTULA.mp4',
        'caption':
            'DECEMBER 20 MISSION CCLI - Creative process: From idea to final video 🎬 #creativeprocess #design',
        'date': '2024-12-19',
      },
      {
        'name': 'FEBRUARY_04_MISSION#1_MISTULA.mp4',
        'caption':
            'FEBRUARY 04 MISSION #1 - A day in the life of a computer engineering student 💻 #studentlife #engineering',
        'date': '2024-02-04',
      },
      {
        'name': 'FEBRUARY_22_MISSION#2_MISTULA.mp4',
        'caption':
            'FEBRUARY 22 MISSION #2 - Tutorial time! Sharing what I learn with you all 📚 #tutorial #learning',
        'date': '2024-02-21',
      },
      {
        'name': 'FEBRUARY_28_MISSION#1A_MISTULA.mp4',
        'caption':
            'FEBRUARY 28 MISSION #1A - Fun moments and memories that make life special ✨ #lifestyle #memories',
        'date': '2024-02-28',
      },
    ];

    return videoData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      return InstagramPost(
        id: data['name']!,
        caption: _stripExtension(data['name']!),
        mediaUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        thumbnailUrl: _getThumbnailUrl(index),
        permalink:
            'https://drive.google.com/drive/folders/1h-w9-57ouVCK_diL5Kz1E4f-UKCtJL6e?usp=drive_link',
        mediaType: 'VIDEO',
        timestamp: DateTime.parse('${data['date']}T12:00:00Z'),
      );
    }).toList();
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

  static String _stripExtension(String fileName) {
    final dot = fileName.lastIndexOf('.');
    if (dot == -1) return fileName;
    return fileName.substring(0, dot);
  }
}
