import React, { useEffect, useState, useRef } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Play, ChevronLeft, ChevronRight, X, Music, Youtube } from 'lucide-react';

interface VideoItem {
  id: string;
  title: string;
  thumbnailUrl: string;
  videoUrl: string;
  duration: string;
  category: string;
}

const VideosSection: React.FC = () => {
  const [, setIsMobile] = useState(false);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isLoading, setIsLoading] = useState(true);
  const [selectedVideo, setSelectedVideo] = useState<VideoItem | null>(null);
  const [videos, setVideos] = useState<VideoItem[]>([]);
  const [isDragging, setIsDragging] = useState(false);
  const [startX, setStartX] = useState(0);
  const [translateX, setTranslateX] = useState(0);
  const carouselRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const checkScreenSize = () => {
      setIsMobile(window.innerWidth < 768);
    };

    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
    return () => window.removeEventListener('resize', checkScreenSize);
  }, []);

  useEffect(() => {
    // Fetch videos from Google API
    const fetchVideos = async () => {
      try {
        const playlistId = 'PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E';
        const apiKey = 'AIzaSyCuvgQAYv9F5pR1rLGXMnJ7M7mNbLpxG7U';
        
        const response = await fetch(
          `https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=${playlistId}&key=${apiKey}&maxResults=10`
        );
        
        if (response.ok) {
          const data = await response.json();
          const videoItems: VideoItem[] = data.items.map((item: any) => ({
            id: item.snippet.resourceId.videoId,
            title: item.snippet.title,
            thumbnailUrl: item.snippet.thumbnails.maxres?.url || item.snippet.thumbnails.high?.url || item.snippet.thumbnails.default.url,
            videoUrl: `https://www.youtube.com/watch?v=${item.snippet.resourceId.videoId}`,
            duration: '2:30', // You can fetch this separately if needed
            category: 'Creative'
          }));
          
          setVideos(videoItems);
        } else {
          // Fallback to mock data if API fails
          setVideos([
            {
              id: '1',
              title: 'Creative Development Journey',
              thumbnailUrl: '/assets/images/photography/1000031090 (1).jpg',
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
              duration: '2:30',
              category: 'Development'
            },
            {
              id: '2',
              title: 'Samsung Galaxy Campus Ambassador',
              thumbnailUrl: '/assets/images/photography/_IGP1451(1)(1).jpg',
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
              duration: '1:45',
              category: 'Lifestyle'
            },
            {
              id: '3',
              title: 'Computer Engineering Projects',
              thumbnailUrl: '/assets/images/photography/1000031102.jpg',
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
              duration: '3:15',
              category: 'Education'
            },
            {
              id: '4',
              title: 'SCPES Leadership Experience',
              thumbnailUrl: '/assets/images/photography/1000039409.jpg',
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
              duration: '2:00',
              category: 'Leadership'
            }
          ]);
        }
      } catch (error) {
        console.error('Error fetching videos:', error);
        // Fallback to mock data
        setVideos([
          {
            id: '1',
            title: 'Creative Development Journey',
            thumbnailUrl: '/assets/images/photography/1000031090 (1).jpg',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            duration: '2:30',
            category: 'Development'
          }
        ]);
      } finally {
        setIsLoading(false);
      }
    };

    fetchVideos();
  }, []);

  const nextVideo = () => {
    setCurrentIndex((prev) => (prev + 1) % videos.length);
  };

  const prevVideo = () => {
    setCurrentIndex((prev) => (prev - 1 + videos.length) % videos.length);
  };

  const handleTikTokClick = () => {
    window.open('https://www.tiktok.com/@swswswsw0', '_blank');
  };

  const handleYouTubeClick = () => {
    window.open('https://www.youtube.com/playlist?list=PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E', '_blank');
  };

  const getYouTubeEmbedUrl = (videoUrl: string) => {
    const videoId = videoUrl.split('v=')[1]?.split('&')[0];
    return `https://www.youtube.com/embed/${videoId}?autoplay=1&rel=0`;
  };

  const handleMouseDown = (e: React.MouseEvent) => {
    setIsDragging(true);
    setStartX(e.clientX);
  };

  const handleMouseMove = (e: React.MouseEvent) => {
    if (!isDragging) return;
    const deltaX = e.clientX - startX;
    setTranslateX(deltaX);
  };

  const handleMouseUp = () => {
    if (!isDragging) return;
    setIsDragging(false);
    
    if (translateX > 100 && currentIndex > 0) {
      prevVideo();
    } else if (translateX < -100 && currentIndex < videos.length - 1) {
      nextVideo();
    }
    
    setTranslateX(0);
  };

  const handleTouchStart = (e: React.TouchEvent) => {
    setIsDragging(true);
    setStartX(e.touches[0].clientX);
  };

  const handleTouchMove = (e: React.TouchEvent) => {
    if (!isDragging) return;
    const deltaX = e.touches[0].clientX - startX;
    setTranslateX(deltaX);
  };

  const handleTouchEnd = () => {
    if (!isDragging) return;
    setIsDragging(false);
    
    if (translateX > 100 && currentIndex > 0) {
      prevVideo();
    } else if (translateX < -100 && currentIndex < videos.length - 1) {
      nextVideo();
    }
    
    setTranslateX(0);
  };

  return (
    <section id="videos" className="w-full py-16 px-4 sm:px-6 md:px-8 lg:px-12">
      <div className="max-w-7xl mx-auto">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
          viewport={{ once: true }}
          className="p-8 bg-gradient-to-br from-red-500/10 to-red-600/5 backdrop-blur-xl rounded-3xl border border-red-500/30 mb-12 shadow-glass"
        >
          <div className="flex items-start gap-6">
            <div className="p-4 bg-red-500/20 backdrop-blur-sm rounded-2xl">
              <Play className="w-8 h-8 text-red-500" />
            </div>
            <div className="flex-1">
              <h2 className="text-4xl sm:text-5xl font-bold text-white mb-2 font-sf-pro">
                Video Content & Reels
              </h2>
              <p className="text-lg text-white/70 font-sf-pro-text">
                Creative video content showcasing my projects and lifestyle
              </p>
            </div>
          </div>
        </motion.div>

        {/* Videos Content */}
        {isLoading ? (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            className="h-96 md:h-[700px] bg-white/5 backdrop-blur-xl rounded-2xl border border-white/10 flex items-center justify-center shadow-glass"
          >
            <div className="text-center">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-white mx-auto mb-4"></div>
              <p className="text-white/70 font-sf-pro-text">Loading videos...</p>
            </div>
          </motion.div>
        ) : videos.length === 0 ? (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            className="h-96 md:h-[700px] bg-white/5 backdrop-blur-xl rounded-2xl border border-white/10 flex items-center justify-center shadow-glass"
          >
            <div className="text-center">
              <Play className="w-16 h-16 text-white/30 mx-auto mb-4" />
              <p className="text-white/70 font-sf-pro-text">No videos available</p>
            </div>
          </motion.div>
        ) : (
          <div className="space-y-12">
            {/* Video Carousel */}
            <motion.div
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8 }}
              viewport={{ once: true }}
              className="bg-white/5 backdrop-blur-xl rounded-2xl border border-white/10 overflow-hidden shadow-glass p-6"
            >
              {/* Carousel Container */}
              <div className="relative">
                <div 
                  ref={carouselRef}
                  className="flex gap-4 overflow-x-auto scrollbar-hide pb-4"
                  onMouseDown={handleMouseDown}
                  onMouseMove={handleMouseMove}
                  onMouseUp={handleMouseUp}
                  onMouseLeave={handleMouseUp}
                  onTouchStart={handleTouchStart}
                  onTouchMove={handleTouchMove}
                  onTouchEnd={handleTouchEnd}
                  style={{ cursor: isDragging ? 'grabbing' : 'grab' }}
                >
                  {videos.map((video, index) => (
                    <motion.div
                      key={video.id}
                      initial={{ opacity: 0, scale: 0.8 }}
                      animate={{ 
                        opacity: index === currentIndex ? 1 : 0.7, 
                        scale: index === currentIndex ? 1 : 0.9 
                      }}
                      transition={{ duration: 0.3 }}
                      className={`flex-shrink-0 rounded-2xl overflow-hidden shadow-glass relative group cursor-pointer ${
                        index === currentIndex 
                          ? 'w-64 h-80 md:w-80 md:h-96 shadow-glass-heavy' 
                          : 'w-48 h-60 md:w-64 md:h-80'
                      }`}
                      onClick={() => {
                        setCurrentIndex(index);
                        setSelectedVideo(video);
                      }}
                    >
                      <img
                        src={video.thumbnailUrl}
                        alt={video.title}
                        className="w-full h-full object-cover"
                      />
                      
                      {/* Gradient Overlay */}
                      <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent" />
                      
                      {/* Play Button */}
                      <div className="absolute inset-0 flex items-center justify-center">
                        <motion.div
                          whileHover={{ scale: 1.1 }}
                          whileTap={{ scale: 0.9 }}
                          className={`bg-black/70 backdrop-blur-xl rounded-full border-2 border-white flex items-center justify-center shadow-glass-heavy hover:bg-black/80 transition-colors duration-300 ${
                            index === currentIndex 
                              ? 'w-20 h-20 md:w-24 md:h-24' 
                              : 'w-16 h-16 md:w-20 md:h-20'
                          }`}
                        >
                          <Play className={`text-white ml-1 ${
                            index === currentIndex 
                              ? 'w-8 h-8 md:w-10 md:h-10' 
                              : 'w-6 h-6 md:w-8 md:h-8'
                          }`} />
                        </motion.div>
                      </div>

                      {/* Video Info */}
                      <div className="absolute bottom-0 left-0 right-0 p-4">
                        <h3 className={`text-white font-bold mb-2 font-sf-pro font-bold line-clamp-2 ${
                          index === currentIndex ? 'text-base md:text-lg' : 'text-sm md:text-base'
                        }`}>
                          {video.title}
                        </h3>
                        <div className="flex gap-1">
                          <span className="px-2 py-1 bg-red-500 backdrop-blur-sm rounded-lg text-white text-xs font-bold">
                            REEL
                          </span>
                          <span className="px-2 py-1 bg-white/20 backdrop-blur-sm border border-white/30 rounded-lg text-white text-xs font-semibold">
                            CREATIVE
                          </span>
                        </div>
                      </div>
                    </motion.div>
                  ))}
                </div>

                {/* Navigation Controls */}
                <div className="flex items-center justify-center gap-4 mt-6">
                  {/* Previous Button */}
                  <button
                    onClick={prevVideo}
                    disabled={currentIndex === 0}
                    className={`p-3 rounded-full transition-colors duration-200 ${
                      currentIndex === 0 
                        ? 'text-white/30 cursor-not-allowed' 
                        : 'text-white hover:bg-white/10 bg-white/5 backdrop-blur-sm border border-white/20'
                    }`}
                  >
                    <ChevronLeft className="w-6 h-6" />
                  </button>

                  {/* Page Indicators */}
                  <div className="flex gap-2">
                    {videos.map((_, index) => (
                      <button
                        key={index}
                        onClick={() => setCurrentIndex(index)}
                        className={`h-2 rounded-full transition-all duration-200 ${
                          index === currentIndex 
                            ? 'w-8 bg-white' 
                            : 'w-2 bg-white/30'
                        }`}
                      />
                    ))}
                  </div>

                  {/* Next Button */}
                  <button
                    onClick={nextVideo}
                    disabled={currentIndex === videos.length - 1}
                    className={`p-3 rounded-full transition-colors duration-200 ${
                      currentIndex === videos.length - 1 
                        ? 'text-white/30 cursor-not-allowed' 
                        : 'text-white hover:bg-white/10 bg-white/5 backdrop-blur-sm border border-white/20'
                    }`}
                  >
                    <ChevronRight className="w-6 h-6" />
                  </button>
                </div>
              </div>
            </motion.div>

            {/* Action Buttons */}
            <motion.div
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8, delay: 0.2 }}
              viewport={{ once: true }}
              className="grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-6"
            >
              {/* TikTok Button */}
              <motion.button
                onClick={handleTikTokClick}
                whileHover={{ scale: 1.02 }}
                whileTap={{ scale: 0.98 }}
                className="p-6 bg-gradient-to-r from-black to-black/80 backdrop-blur-xl rounded-2xl shadow-glass hover:shadow-glass-heavy transition-all duration-300 border border-white/10"
              >
                <div className="flex items-center justify-center gap-4">
                  <Music className="w-6 h-6 text-white" />
                  <span className="text-white font-bold text-lg font-sf-pro">
                    View More on TikTok
                  </span>
                </div>
              </motion.button>

              {/* YouTube Button */}
              <motion.button
                onClick={handleYouTubeClick}
                whileHover={{ scale: 1.02 }}
                whileTap={{ scale: 0.98 }}
                className="p-6 bg-gradient-to-r from-red-500 to-red-500/80 backdrop-blur-xl rounded-2xl shadow-glass hover:shadow-glass-heavy transition-all duration-300 border border-white/10"
              >
                <div className="flex items-center justify-center gap-4">
                  <Youtube className="w-6 h-6 text-white" />
                  <span className="text-white font-bold text-lg font-sf-pro">
                    YouTube Playlist
                  </span>
                </div>
              </motion.button>
            </motion.div>
          </div>
        )}
      </div>

      {/* Video Modal */}
      <AnimatePresence>
        {selectedVideo && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 flex items-center justify-center bg-black/90 backdrop-blur-xl"
            onClick={() => setSelectedVideo(null)}
          >
            <motion.div
              initial={{ scale: 0.8, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.8, opacity: 0 }}
              transition={{ type: "spring", damping: 20, stiffness: 300 }}
              className="relative w-full max-w-4xl aspect-video mx-4"
              onClick={(e) => e.stopPropagation()}
            >
              {/* Close Button */}
              <button
                onClick={() => setSelectedVideo(null)}
                className="absolute -top-12 right-0 p-3 bg-black/60 backdrop-blur-xl rounded-full text-white hover:bg-black/80 transition-colors duration-200 z-10 border border-white/20"
              >
                <X className="w-6 h-6" />
              </button>

              {/* YouTube Embed */}
              <iframe
                src={getYouTubeEmbedUrl(selectedVideo.videoUrl)}
                title={selectedVideo.title}
                className="w-full h-full rounded-2xl shadow-glass-heavy"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowFullScreen
              />
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </section>
  );
};

export default VideosSection;