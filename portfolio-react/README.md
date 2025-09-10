# Shaun Mistula's Portfolio - ReactJS Version

A modern, responsive portfolio website built with ReactJS, TypeScript, and Tailwind CSS, featuring smooth animations, responsive design, and integrated APIs.

## 🚀 Features

### Frontend Features
- **Modern React Architecture**: Built with React 18, TypeScript, and Vite
- **Responsive Design**: Mobile-first approach with Tailwind CSS
- **Smooth Animations**: Framer Motion for beautiful transitions
- **Apple-Inspired UI**: Clean, modern design with Apple design principles
- **Samsung Design Elements**: Samsung One UI inspired components
- **Dark Theme**: Optimized for dark mode experience
- **Performance Optimized**: Lazy loading, code splitting, and optimized assets

### Sections
1. **Hero Section**: Full-screen background with profile picture and social links
2. **About Section**: Personal information with highlight cards
3. **Projects Section**: Interactive project showcase with expandable details
4. **Photography Section**: Image gallery with modal popups
5. **Videos Section**: YouTube integration with video carousel
6. **Footer**: Social media links and branding

### Backend Features
- **Express.js API**: RESTful API with TypeScript
- **YouTube Integration**: Fetch videos from YouTube playlists
- **Instagram Integration**: Fetch posts from Instagram API
- **Error Handling**: Comprehensive error handling and fallbacks
- **CORS Support**: Proper CORS configuration for frontend integration
- **Environment Configuration**: Secure environment variable management

## 🛠️ Tech Stack

### Frontend
- **React 18** - Modern React with hooks and concurrent features
- **TypeScript** - Type-safe JavaScript
- **Vite** - Fast build tool and dev server
- **Tailwind CSS** - Utility-first CSS framework
- **Framer Motion** - Animation library
- **React Router** - Client-side routing

### Backend
- **Node.js** - JavaScript runtime
- **Express.js** - Web framework
- **TypeScript** - Type-safe backend development
- **Axios** - HTTP client for API calls
- **Helmet** - Security middleware
- **Morgan** - HTTP request logger
- **CORS** - Cross-origin resource sharing

## 📦 Installation

### Prerequisites
- Node.js (v18 or higher)
- npm or yarn

### Frontend Setup
```bash
# Navigate to the frontend directory
cd portfolio-react

# Install dependencies
npm install

# Start development server
npm run dev
```

### Backend Setup
```bash
# Navigate to the backend directory
cd backend

# Install dependencies
npm install

# Copy environment file
cp env.example .env

# Start development server
npm run dev
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the backend directory:

```env
# Server Configuration
PORT=3001
NODE_ENV=development
FRONTEND_URL=http://localhost:5173

# YouTube API Configuration
YOUTUBE_API_KEY=your_youtube_api_key
PLAYLIST_ID=your_playlist_id

# Instagram API Configuration
INSTAGRAM_ACCESS_TOKEN=your_instagram_access_token
INSTAGRAM_USER_ID=your_instagram_user_id
```

### API Keys Setup

1. **YouTube API**:
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Enable YouTube Data API v3
   - Create credentials and get your API key

2. **Instagram API**:
   - Go to [Facebook Developers](https://developers.facebook.com/)
   - Create an app and get Instagram Basic Display API access
   - Generate access token and user ID

## 🎨 Design System

### Color Palette
- **Apple Green**: #34C759 (Primary)
- **Apple Blue**: #007AFF (Secondary)
- **Samsung Blue**: #007AFF
- **Samsung Green**: #34C759
- **Background Dark**: #000000
- **Surface Dark**: #1C1C1E

### Typography
- **SF Pro Display**: Headers and titles
- **SF Pro Text**: Body text
- **Samsung Sharp Sans**: Samsung-themed components
- **Samsung One**: Special accents

### Spacing System
- **XS**: 4px
- **S**: 8px
- **M**: 16px
- **L**: 24px
- **XL**: 32px
- **XXL**: 48px
- **XXXL**: 64px

## 📱 Responsive Breakpoints

- **Mobile**: < 768px
- **Tablet**: 768px - 1024px
- **Desktop**: > 1024px
- **Large Desktop**: > 1200px

## 🚀 Deployment

### Frontend Deployment (Vercel/Netlify)
```bash
# Build the project
npm run build

# Deploy to your preferred platform
```

### Backend Deployment (Railway/Heroku)
```bash
# Build the backend
cd backend
npm run build

# Deploy with your preferred platform
```

## 📁 Project Structure

```
portfolio-react/
├── src/
│   ├── components/          # React components
│   │   ├── Navigation.tsx
│   │   ├── HeroSection.tsx
│   │   ├── AboutSection.tsx
│   │   ├── ProjectsSection.tsx
│   │   ├── PhotographySection.tsx
│   │   ├── VideosSection.tsx
│   │   └── Footer.tsx
│   ├── pages/              # Page components
│   │   └── HomePage.tsx
│   ├── App.tsx             # Main app component
│   ├── App.css             # Global styles
│   └── index.css           # Tailwind CSS imports
├── public/
│   └── assets/             # Static assets
├── backend/
│   ├── src/
│   │   ├── routes/         # API routes
│   │   │   ├── youtube.ts
│   │   │   └── instagram.ts
│   │   └── server.ts       # Express server
│   ├── package.json
│   └── tsconfig.json
├── tailwind.config.js      # Tailwind configuration
└── package.json
```

## 🎯 Key Features Implemented

### ✅ Completed Features
- [x] Modern ReactJS architecture with TypeScript
- [x] Responsive design for all screen sizes
- [x] Smooth animations with Framer Motion
- [x] Apple-inspired hero section with background image
- [x] Interactive navigation with smooth scrolling
- [x] About section with highlight cards
- [x] Projects section with expandable details
- [x] Photography gallery with modal popups
- [x] Videos section with YouTube integration
- [x] Footer with social media links
- [x] Backend API with Express.js
- [x] YouTube API integration
- [x] Instagram API integration
- [x] Error handling and fallbacks
- [x] Performance optimizations

## 🔄 Migration from Flutter

This ReactJS version is a complete migration from the original Flutter app, featuring:

- **Same Design Language**: Maintained Apple and Samsung design principles
- **Enhanced Performance**: Better web performance with React
- **Improved SEO**: Better search engine optimization
- **Cross-Platform**: Works on all modern browsers
- **Easier Maintenance**: Standard web technologies
- **Better Integration**: Native web APIs and services

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Shaun Mistula**
- Computer Engineering Student at University of the East Manila
- Samsung Galaxy Campus Student Ambassador
- President of SCPES (Society of Computer Engineering Students)

## 📞 Contact

- **Email**: shaunmistula@gmail.com
- **Instagram**: [@shaun_mistula](https://instagram.com/shaun_mistula)
- **TikTok**: [@swswswsw0](https://tiktok.com/@swswswsw0)
- **Facebook**: [SPAM.00l](https://facebook.com/SPAM.00l)
- **YouTube**: [Portfolio Playlist](https://www.youtube.com/playlist?list=PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E)

---

Built with ❤️ by Shaun Mistula