import express from 'express';
import axios from 'axios';

const router = express.Router();

interface InstagramPost {
  id: string;
  caption: string;
  mediaUrl: string;
  thumbnailUrl: string;
  permalink: string;
  mediaType: string;
  timestamp: string;
}

// Instagram API configuration
const INSTAGRAM_ACCESS_TOKEN = process.env.INSTAGRAM_ACCESS_TOKEN || 'YOUR_INSTAGRAM_ACCESS_TOKEN';
const INSTAGRAM_USER_ID = process.env.INSTAGRAM_USER_ID || 'YOUR_INSTAGRAM_USER_ID';

// Fetch Instagram posts
router.get('/posts', async (req, res) => {
  try {
    const maxResults = parseInt(req.query.maxResults as string) || 6;
    
    const response = await axios.get(`https://graph.instagram.com/${INSTAGRAM_USER_ID}/media`, {
      params: {
        fields: 'id,caption,media_type,media_url,thumbnail_url,permalink,timestamp',
        access_token: INSTAGRAM_ACCESS_TOKEN,
        limit: maxResults,
      },
    });

    const posts: InstagramPost[] = response.data.data
      .filter((item: any) => item.media_type === 'VIDEO' || item.media_type === 'IMAGE')
      .map((item: any) => ({
        id: item.id,
        caption: item.caption || 'No caption',
        mediaUrl: item.media_url,
        thumbnailUrl: item.thumbnail_url || item.media_url,
        permalink: item.permalink,
        mediaType: item.media_type,
        timestamp: item.timestamp,
      }))
      .sort((a: InstagramPost, b: InstagramPost) => 
        new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime()
      );

    res.json({
      success: true,
      data: posts,
      total: posts.length,
    });

  } catch (error: any) {
    console.error('Instagram API Error:', error.response?.data || error.message);
    
    // Return sample data if API fails
    const samplePosts: InstagramPost[] = [
      {
        id: 'sample1',
        caption: 'Latest coding project! Check out what I\'ve been working on 🚀',
        mediaUrl: '/assets/images/photography/1000031090 (1).jpg',
        thumbnailUrl: '/assets/images/photography/1000031090 (1).jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'IMAGE',
        timestamp: new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString(),
      },
      {
        id: 'sample2',
        caption: 'Behind the scenes of my latest video creation 📹',
        mediaUrl: '/assets/images/photography/_IGP1451(1)(1).jpg',
        thumbnailUrl: '/assets/images/photography/_IGP1451(1)(1).jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString(),
      },
      {
        id: 'sample3',
        caption: 'Creative process: From idea to final video 🎬',
        mediaUrl: '/assets/images/photography/1000031102.jpg',
        thumbnailUrl: '/assets/images/photography/1000031102.jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString(),
      },
      {
        id: 'sample4',
        caption: 'A day in the life of a computer engineering student 💻',
        mediaUrl: '/assets/images/photography/1000039409.jpg',
        thumbnailUrl: '/assets/images/photography/1000039409.jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'IMAGE',
        timestamp: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString(),
      },
      {
        id: 'sample5',
        caption: 'Tutorial time! Sharing what I learn with you all 📚',
        mediaUrl: '/assets/images/photography/20250515_120304(2).jpg',
        thumbnailUrl: '/assets/images/photography/20250515_120304(2).jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'VIDEO',
        timestamp: new Date(Date.now() - 10 * 24 * 60 * 60 * 1000).toISOString(),
      },
      {
        id: 'sample6',
        caption: 'Fun moments and memories that make life special ✨',
        mediaUrl: '/assets/images/photography/20250612_233907.jpg',
        thumbnailUrl: '/assets/images/photography/20250612_233907.jpg',
        permalink: 'https://www.instagram.com/shaun_mistula/',
        mediaType: 'IMAGE',
        timestamp: new Date(Date.now() - 14 * 24 * 60 * 60 * 1000).toISOString(),
      },
    ];

    res.json({
      success: true,
      data: samplePosts,
      total: samplePosts.length,
      note: 'Using sample data due to API error',
    });
  }
});

// Get Instagram user info
router.get('/user', async (req, res) => {
  try {
    const response = await axios.get(`https://graph.instagram.com/${INSTAGRAM_USER_ID}`, {
      params: {
        fields: 'id,username,account_type',
        access_token: INSTAGRAM_ACCESS_TOKEN,
      },
    });

    res.json({
      success: true,
      data: response.data,
    });

  } catch (error: any) {
    console.error('Instagram User API Error:', error.response?.data || error.message);
    
    res.json({
      success: true,
      data: {
        id: 'sample_user',
        username: 'shaun_mistula',
        account_type: 'PERSONAL',
      },
      note: 'Using sample data due to API error',
    });
  }
});

// Get specific media by ID
router.get('/media/:id', async (req, res) => {
  try {
    const mediaId = req.params.id;
    
    const response = await axios.get(`https://graph.instagram.com/${mediaId}`, {
      params: {
        fields: 'id,caption,media_type,media_url,thumbnail_url,permalink,timestamp',
        access_token: INSTAGRAM_ACCESS_TOKEN,
      },
    });

    const post: InstagramPost = {
      id: response.data.id,
      caption: response.data.caption || 'No caption',
      mediaUrl: response.data.media_url,
      thumbnailUrl: response.data.thumbnail_url || response.data.media_url,
      permalink: response.data.permalink,
      mediaType: response.data.media_type,
      timestamp: response.data.timestamp,
    };

    res.json({
      success: true,
      data: post,
    });

  } catch (error: any) {
    console.error('Instagram Media API Error:', error.response?.data || error.message);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch media details',
    });
  }
});

export default router;

