import '../services/instagram_service.dart';

class GoogleDriveVideoService {
  static Future<List<InstagramPost>> getGoogleDriveVideos() async {
    // Your actual Google Drive video IDs from the folder
    final List<Map<String, String>> videoData = [
      {
        'id':
            '1h-w9-57ouVCK_diL5Kz1E4f-UKCtJL6e', // This is the folder ID, we need individual file IDs
        'name': 'APRIL_08_MISSION#1_MISTULA.mp4',
        'caption':
            'APRIL 08 MISSION #1 - Latest coding project showcase 🚀 #coding #portfolio #mission',
        'date': '2024-04-07',
      },
      {
        'id': '1h-w9-57ouVCK_diL5Kz1E4f-UKCtJL6e',
        'name': 'AUGUST02_MISSION#3_MISTULA.mp4',
        'caption':
            'AUGUST 02 MISSION #3 - Behind the scenes of my latest video creation 📹 #behindthescenes #creative',
        'date': '2024-08-02',
      },
      {
        'id': '1h-w9-57ouVCK_diL5Kz1E4f-UKCtJL6e',
        'name': 'DECEMBER_20_MISSION_CCLI_MISTULA.mp4',
        'caption':
            'DECEMBER 20 MISSION CCLI - Creative process: From idea to final video 🎬 #creativeprocess #design',
        'date': '2024-12-19',
      },
      {
        'id': '1h-w9-57ouVCK_diL5Kz1E4f-UKCtJL6e',
        'name': 'FEBRUARY_04_MISSION#1_MISTULA.mp4',
        'caption':
            'FEBRUARY 04 MISSION #1 - A day in the life of a computer engineering student 💻 #studentlife #engineering',
        'date': '2024-02-04',
      },
      {
        'id': '1h-w9-57ouVCK_diL5Kz1E4f-UKCtJL6e',
        'name': 'FEBRUARY_22_MISSION#2_MISTULA.mp4',
        'caption':
            'FEBRUARY 22 MISSION #2 - Tutorial time! Sharing what I learn with you all 📚 #tutorial #learning',
        'date': '2024-02-21',
      },
      {
        'id': '1h-w9-57ouVCK_diL5Kz1E4f-UKCtJL6e',
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
        caption: data['caption']!,
        mediaUrl: _getGoogleDriveVideoUrl(data['id']!, data['name']!),
        thumbnailUrl: _getThumbnailUrl(index),
        permalink:
            'https://drive.google.com/drive/folders/${data['id']}?usp=drive_link',
        mediaType: 'VIDEO',
        timestamp: DateTime.parse('${data['date']}T12:00:00Z'),
      );
    }).toList();
  }

  static String _getGoogleDriveVideoUrl(String folderId, String fileName) {
    // For now, we'll use a sample video URL since we need individual file IDs
    // In a real implementation, you would need to get the individual file IDs from the folder
    return 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
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

