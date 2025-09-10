import express from 'express';
import axios from 'axios';

const router = express.Router();

interface YouTubeVideo {
  id: string;
  title: string;
  thumbnailUrl: string;
  videoUrl: string;
  description: string;
  publishedAt: string;
}

// YouTube API configuration
const YOUTUBE_API_KEY = process.env.YOUTUBE_API_KEY || 'AIzaSyCuvgQAYv9F5pR1rLGXMnJ7M7mNbLpxG7U';
const PLAYLIST_ID = 'PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E';

// Fetch YouTube playlist videos
router.get('/playlist', async (req, res) => {
  try {
    const maxResults = parseInt(req.query.maxResults as string) || 10;
    
    const response = await axios.get('https://www.googleapis.com/youtube/v3/playlistItems', {
      params: {
        part: 'snippet',
        playlistId: PLAYLIST_ID,
        maxResults: maxResults,
        key: YOUTUBE_API_KEY,
      },
    });

    const videos: YouTubeVideo[] = response.data.items.map((item: any) => {
      const snippet = item.snippet;
      const resourceId = snippet.resourceId;
      const videoId = resourceId?.videoId;
      
      if (!videoId) return null;

      // Get the best thumbnail available
      const thumbnails = snippet.thumbnails;
      let thumbnailUrl = `https://img.youtube.com/vi/${videoId}/hqdefault.jpg`;
      
      if (thumbnails.maxres) {
        thumbnailUrl = thumbnails.maxres.url;
      } else if (thumbnails.standard) {
        thumbnailUrl = thumbnails.standard.url;
      } else if (thumbnails.high) {
        thumbnailUrl = thumbnails.high.url;
      } else if (thumbnails.medium) {
        thumbnailUrl = thumbnails.medium.url;
      } else if (thumbnails.default) {
        thumbnailUrl = thumbnails.default.url;
      }

      return {
        id: videoId,
        title: snippet.title?.trim() || 'Untitled Video',
        thumbnailUrl,
        videoUrl: `https://www.youtube.com/embed/${videoId}`,
        description: snippet.description?.substring(0, 200) + '...' || 'No description available',
        publishedAt: snippet.publishedAt,
      };
    }).filter(Boolean);

    res.json({
      success: true,
      data: videos,
      total: videos.length,
    });

  } catch (error: any) {
    console.error('YouTube API Error:', error.response?.data || error.message);
    
    // Return sample data if API fails
    const sampleVideos: YouTubeVideo[] = [
      {
        id: 'sample1',
        title: 'ESP32 Sensor Project Tutorial',
        thumbnailUrl: '/assets/images/photography/1000031090 (1).jpg',
        videoUrl: 'https://www.youtube.com/embed/dQw4w9WgXcQ',
        description: 'Learn how to build a complete sensor monitoring system with ESP32',
        publishedAt: new Date().toISOString(),
      },
      {
        id: 'sample2',
        title: 'Smart Glasses Development',
        thumbnailUrl: '/assets/images/photography/_IGP1451(1)(1).jpg',
        videoUrl: 'https://www.youtube.com/embed/dQw4w9WgXcQ',
        description: 'Behind the scenes of my AI-powered smart glasses project',
        publishedAt: new Date().toISOString(),
      },
      {
        id: 'sample3',
        title: 'Raspberry Pi Automation',
        thumbnailUrl: '/assets/images/photography/1000031102.jpg',
        videoUrl: 'https://www.youtube.com/embed/dQw4w9WgXcQ',
        description: 'Setting up automated home systems with Raspberry Pi',
        publishedAt: new Date().toISOString(),
      },
    ];

    res.json({
      success: true,
      data: sampleVideos,
      total: sampleVideos.length,
      note: 'Using sample data due to API error',
    });
  }
});

// Get video details by ID
router.get('/video/:id', async (req, res) => {
  try {
    const videoId = req.params.id;
    
    const response = await axios.get('https://www.googleapis.com/youtube/v3/videos', {
      params: {
        part: 'snippet,statistics',
        id: videoId,
        key: YOUTUBE_API_KEY,
      },
    });

    if (response.data.items.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'Video not found',
      });
    }

    const video = response.data.items[0];
    const snippet = video.snippet;
    const statistics = video.statistics;

    const videoData: YouTubeVideo = {
      id: videoId,
      title: snippet.title,
      thumbnailUrl: snippet.thumbnails.maxres?.url || snippet.thumbnails.high?.url || snippet.thumbnails.default?.url,
      videoUrl: `https://www.youtube.com/embed/${videoId}`,
      description: snippet.description,
      publishedAt: snippet.publishedAt,
    };

    res.json({
      success: true,
      data: videoData,
      statistics: {
        viewCount: statistics.viewCount,
        likeCount: statistics.likeCount,
        commentCount: statistics.commentCount,
      },
    });

  } catch (error: any) {
    console.error('YouTube Video API Error:', error.response?.data || error.message);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch video details',
    });
  }
});

export default router;

