import React, { useEffect, useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Camera, X, Eye } from 'lucide-react';

interface PhotoItem {
  id: string;
  imageUrl: string;
  title: string;
  description: string;
}

const PhotographySection: React.FC = () => {
  const [isMobile, setIsMobile] = useState(false);
  const [isSmall, setIsSmall] = useState(false);
  const [isLowEnd, setIsLowEnd] = useState(false);
  const [selectedPhoto, setSelectedPhoto] = useState<PhotoItem | null>(null);

  useEffect(() => {
    const checkScreenSize = () => {
      const width = window.innerWidth;
      setIsMobile(width < 768);
      setIsSmall(width < 600);
      setIsLowEnd(width < 400);
    };

    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
    return () => window.removeEventListener('resize', checkScreenSize);
  }, []);

  const photos: PhotoItem[] = [
    {
      id: '1',
      imageUrl: '/assets/images/photography/_IGP1451(1)(1).jpg',
      title: 'Street Photography',
      description: 'Urban life and culture'
    },
    {
      id: '2',
      imageUrl: '/assets/images/photography/1000031090 (1).jpg',
      title: 'Artistic Composition',
      description: 'Creative visual storytelling'
    },
    {
      id: '3',
      imageUrl: '/assets/images/photography/1000031102.jpg',
      title: 'Lifestyle Photography',
      description: 'Capturing authentic moments'
    },
    {
      id: '4',
      imageUrl: '/assets/images/photography/1000039409.jpg',
      title: 'Portrait Photography',
      description: 'Human emotion and expression'
    },
    {
      id: '5',
      imageUrl: '/assets/images/photography/20250515_120304(2).jpg',
      title: 'Nature Photography',
      description: 'Beauty in the natural world'
    },
    {
      id: '6',
      imageUrl: '/assets/images/photography/20250612_233907.jpg',
      title: 'Documentary Photography',
      description: 'Real moments captured'
    }
  ];

  const handleInstagramClick = () => {
    window.open('https://www.instagram.com/shaun_mistula/', '_blank');
  };

  // const getGridCols = () => {
  //   if (isLowEnd) return 2;
  //   if (isSmall) return 2;
  //   if (window.innerWidth < 1200) return 3;
  //   return 4;
  // };

  const getPhotoItems = () => {
    return isLowEnd ? photos.slice(0, 4) : photos;
  };

  return (
    <section id="photography" className="w-full py-16 px-4 sm:px-6 md:px-8 lg:px-12">
      <div className="max-w-7xl mx-auto">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
          viewport={{ once: true }}
          className="text-center mb-12"
        >
          <h2 
            className="font-sf-pro font-bold text-white mb-6"
            style={{ 
              fontSize: isLowEnd ? '24px' : isSmall ? '28px' : isMobile ? '36px' : '48px',
              letterSpacing: isLowEnd ? '1px' : '1.5px'
            }}
          >
            My Photography
          </h2>
        </motion.div>

        {/* Photography Gallery */}
        <div className="space-y-6">
          {/* Photo Grid */}
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-2 sm:gap-3 md:gap-4 lg:gap-6">
            {getPhotoItems().map((photo, index) => (
              <motion.div
                key={photo.id}
                initial={{ opacity: 0, y: 30 }}
                whileInView={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.8, delay: index * 0.1 }}
                viewport={{ once: true }}
                className="relative overflow-hidden rounded-xl sm:rounded-2xl cursor-pointer group shadow-glass hover:shadow-glass-heavy transition-all duration-300 aspect-square sm:aspect-[4/5]"
                onClick={() => setSelectedPhoto(photo)}
              >
                <img
                  src={photo.imageUrl}
                  alt={photo.title}
                  className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
                  onError={(e) => {
                    const target = e.target as HTMLImageElement;
                    target.style.display = 'none';
                    const parent = target.parentElement;
                    if (parent) {
                      parent.innerHTML = `
                        <div class="w-full h-full bg-gray-300/20 dark:bg-gray-700/20 flex items-center justify-center backdrop-blur-sm">
                          <Camera class="w-8 h-8 text-gray-500 dark:text-gray-400" />
                        </div>
                      `;
                    }
                  }}
                />
                <div className="absolute inset-0 bg-black/50 group-hover:bg-black/30 transition-all duration-300 flex items-center justify-center">
                  <div className="text-white text-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                    <Eye className="w-8 h-8 mx-auto mb-2" />
                    <div className="text-sm font-medium font-sf-pro-text">Click to view</div>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>

          {/* Instagram Card */}
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.6 }}
            viewport={{ once: true }}
            className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-purple-500 to-pink-500 shadow-glass-heavy hover:shadow-glass-heavy transition-all duration-300 cursor-pointer backdrop-blur-xl"
            onClick={handleInstagramClick}
            style={{ height: isLowEnd ? '80px' : isSmall ? '100px' : '120px' }}
          >
            <div className="absolute inset-0 bg-gradient-to-br from-purple-500/30 to-pink-500/30 backdrop-blur-sm" />
            <div className="relative h-full flex items-center justify-center px-6">
              <div className="flex items-center gap-4">
                <Camera className="w-8 h-8 text-white" />
                <div className="text-white">
                  <h3 
                    className="font-sf-pro font-bold text-white mb-1"
                    style={{ fontSize: isLowEnd ? '16px' : isSmall ? '18px' : '24px' }}
                  >
                    View More
                  </h3>
                  <p 
                    className="font-sf-pro-text font-normal text-white/70"
                    style={{ fontSize: isLowEnd ? '10px' : isSmall ? '12px' : '16px' }}
                  >
                    on Instagram
                  </p>
                </div>
              </div>
            </div>
          </motion.div>
        </div>
      </div>

      {/* Image Modal */}
      <AnimatePresence>
        {selectedPhoto && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 flex items-center justify-center bg-black/90 backdrop-blur-xl"
            onClick={() => setSelectedPhoto(null)}
          >
            <motion.div
              initial={{ scale: 0.8, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.8, opacity: 0 }}
              transition={{ type: "spring", damping: 20, stiffness: 300 }}
              className="relative max-w-[90vw] max-h-[90vh] w-full h-full flex flex-col"
              onClick={(e) => e.stopPropagation()}
            >
              {/* Close Button */}
              <button
                onClick={() => setSelectedPhoto(null)}
                className="absolute -top-12 right-0 p-3 bg-black/60 backdrop-blur-xl rounded-full text-white hover:bg-black/80 transition-colors duration-200 border border-white/20"
              >
                <X className="w-6 h-6" />
              </button>

              {/* Image Container */}
              <div className="flex-1 flex items-center justify-center p-4 min-h-0">
                <div className="relative w-full h-full flex items-center justify-center">
                  <img
                    src={selectedPhoto.imageUrl}
                    alt={selectedPhoto.title}
                    className="max-w-full max-h-full object-contain rounded-2xl shadow-glass-heavy"
                    style={{ 
                      maxWidth: '100%', 
                      maxHeight: '100%',
                      width: 'auto',
                      height: 'auto'
                    }}
                  />
                </div>
              </div>

              {/* Photo Info */}
              <div className="p-5 bg-black/80 backdrop-blur-xl rounded-b-2xl border-t border-white/20 flex-shrink-0">
                <h3 
                  className="text-white font-bold mb-2 font-sf-pro"
                  style={{ fontSize: window.innerWidth < 600 ? '18px' : '22px' }}
                >
                  {selectedPhoto.title}
                </h3>
                <p 
                  className="text-white/70 font-sf-pro-text"
                  style={{ fontSize: window.innerWidth < 600 ? '14px' : '16px' }}
                >
                  {selectedPhoto.description}
                </p>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </section>
  );
};

export default PhotographySection;