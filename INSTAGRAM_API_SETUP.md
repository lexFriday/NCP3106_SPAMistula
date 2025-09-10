# Instagram API Setup Guide

To display your actual Instagram videos and thumbnails on your portfolio, you need to set up Instagram Basic Display API access.

## Step 1: Create a Meta for Developers Account

1. Go to [Meta for Developers](https://developers.facebook.com/)
2. Click "Get Started" or "Log In"
3. Create a new app or use an existing one

## Step 2: Set Up Instagram Basic Display

1. In your Meta app dashboard, go to "Add Products"
2. Find "Instagram Basic Display" and click "Set Up"
3. Follow the setup wizard

## Step 3: Configure Instagram Basic Display

1. **Basic Settings:**
   - App Name: Your portfolio name
   - App Contact Email: Your email
   - App Privacy Policy URL: Your privacy policy (can be a placeholder for now)
   - App Terms of Service URL: Your terms (can be a placeholder for now)

2. **Instagram App ID:**
   - Copy your Instagram App ID (you'll need this)

## Step 4: Add Instagram Test Users

1. Go to "Roles" → "Instagram Test Users"
2. Add your Instagram account as a test user
3. Accept the invitation from your Instagram account

## Step 5: Generate Access Token

1. Go to "Instagram Basic Display" → "Basic Display"
2. Click "Generate Token"
3. Authorize your app
4. Copy the generated access token

## Step 6: Get Your User ID

1. Make a GET request to:
   ```
   https://graph.instagram.com/me?fields=id,username&access_token=YOUR_ACCESS_TOKEN
   ```
2. Copy your user ID from the response

## Step 7: Update Your Code

Replace the placeholder values in `lib/services/instagram_service.dart`:

```dart
static const String _accessToken = 'YOUR_ACTUAL_ACCESS_TOKEN';
static const String _userId = 'YOUR_ACTUAL_USER_ID';
```

## Step 8: Test the Integration

1. Run your Flutter app
2. The Instagram gallery should now display your real posts
3. Click on videos to play them directly on your site

## API Endpoints Used

- **User Media:** `https://graph.instagram.com/me/media`
- **User Info:** `https://graph.instagram.com/me`
- **Specific Media:** `https://graph.instagram.com/{media-id}`

## Permissions Required

- `user_profile` - Basic profile info
- `user_media` - Access to your posts

## Troubleshooting

### Common Issues:

1. **"Invalid access token"**
   - Make sure your token is valid and not expired
   - Regenerate the token if needed

2. **"Permission denied"**
   - Ensure your Instagram account is added as a test user
   - Check that you've authorized the app

3. **"No media found"**
   - Make sure your posts are public or you're a test user
   - Check that your posts contain videos/images

4. **CORS Issues (Web)**
   - Instagram API supports CORS for web applications
   - If you encounter issues, consider using a backend proxy

## Security Notes

- Never commit your access token to version control
- Use environment variables or secure storage
- Consider implementing token refresh logic
- Monitor your API usage (Instagram has rate limits)

## Rate Limits

- Instagram Basic Display API has rate limits
- Monitor your usage in the Meta for Developers dashboard
- Implement caching to reduce API calls

## Alternative: Manual Integration

If you prefer not to use the API, you can manually add your Instagram posts:

1. Create a JSON file with your post data
2. Include video URLs, thumbnails, and captions
3. Update the service to load from this file instead

Example JSON structure:
```json
{
  "posts": [
    {
      "id": "1",
      "caption": "My latest video!",
      "mediaUrl": "https://your-video-url.mp4",
      "thumbnailUrl": "https://your-thumbnail-url.jpg",
      "permalink": "https://www.instagram.com/p/your-post-id/",
      "mediaType": "VIDEO",
      "timestamp": "2024-01-01T12:00:00Z"
    }
  ]
}
```

## Next Steps

1. Set up your Instagram API access
2. Update the service with your credentials
3. Test the integration
4. Deploy your portfolio with real Instagram content!

Your portfolio will then display your actual Instagram videos and thumbnails with full playback functionality! 🎬✨

