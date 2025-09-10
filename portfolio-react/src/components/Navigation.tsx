import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Menu, X, Home, User, Code, Camera, Play, Mail, Download } from 'lucide-react';

const Navigation: React.FC = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobile, setIsMobile] = useState(false);

  useEffect(() => {
    const checkScreenSize = () => {
      setIsMobile(window.innerWidth < 768);
    };

    const handleScroll = () => {
      setIsScrolled(window.scrollY > 50);
    };

    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
    window.addEventListener('scroll', handleScroll);

    return () => {
      window.removeEventListener('resize', checkScreenSize);
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);

  const menuItems = [
    { id: 'hero', label: 'Home', icon: Home },
    { id: 'about', label: 'About', icon: User },
    { id: 'projects', label: 'Projects', icon: Code },
    { id: 'photography', label: 'Photography', icon: Camera },
    { id: 'videos', label: 'Videos', icon: Play },
    { id: 'contact', label: 'Contact', icon: Mail }
  ];

  const scrollToSection = (sectionId: string) => {
    const element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' });
    }
    setIsOpen(false);
  };

  const handleContactClick = () => {
    window.open('mailto:shaunmistula@gmail.com', '_blank');
    setIsOpen(false);
  };

  const handleDownloadCV = () => {
    // Download CV from assets
    const link = document.createElement('a');
    link.href = '/assets/pdf/MISTULA_CV.pdf';
    link.download = 'Shaun_Mistula_CV.pdf';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    setIsOpen(false);
  };

  return (
    <>
      {/* Desktop Navigation */}
      {!isMobile && (
        <motion.nav
          initial={{ y: -100 }}
          animate={{ y: 0 }}
          transition={{ duration: 0.8 }}
          className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
            isScrolled 
              ? 'bg-black/80 backdrop-blur-xl border-b border-white/10' 
              : 'bg-transparent'
          }`}
        >
          <div className="max-w-7xl mx-auto px-6 py-4">
            <div className="flex items-center justify-between">
              {/* Logo */}
              <motion.div
                whileHover={{ scale: 1.05 }}
                className="text-2xl font-bold text-white font-sf-pro cursor-pointer"
                onClick={() => scrollToSection('hero')}
              >
                Shaun Mistula
              </motion.div>

              {/* Desktop Menu */}
              <div className="flex items-center gap-8">
                {menuItems.map((item) => (
                  <motion.button
                    key={item.id}
                    onClick={() => item.id === 'contact' ? handleContactClick() : scrollToSection(item.id)}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    className="text-white/80 hover:text-white transition-colors duration-200 font-sf-pro-text font-medium"
                  >
                    {item.label}
                  </motion.button>
                ))}
              </div>
            </div>
          </div>
        </motion.nav>
      )}

      {/* Mobile Navigation */}
      {isMobile && (
        <>
          {/* Mobile Header */}
          <motion.nav
            initial={{ y: -100 }}
            animate={{ y: 0 }}
            transition={{ duration: 0.8 }}
            className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
              isScrolled 
                ? 'bg-black/80 backdrop-blur-xl border-b border-white/10' 
                : 'bg-transparent'
            }`}
          >
            <div className="px-4 py-4">
              <div className="flex items-center justify-between">
                {/* Logo */}
                <motion.div
                  whileHover={{ scale: 1.05 }}
                  className="text-xl font-bold text-white font-sf-pro cursor-pointer"
                  onClick={() => scrollToSection('hero')}
                >
                  Shaun Mistula
                </motion.div>

                {/* Hamburger Button */}
                <motion.button
                  onClick={() => setIsOpen(!isOpen)}
                  whileTap={{ scale: 0.95 }}
                  className="p-2 text-white"
                >
                  {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
                </motion.button>
              </div>
            </div>
          </motion.nav>

          {/* Mobile Menu Overlay */}
          <AnimatePresence>
            {isOpen && (
              <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                className="fixed inset-0 z-40 bg-black/90 backdrop-blur-xl"
                onClick={() => setIsOpen(false)}
              >
                <motion.div
                  initial={{ x: '100%' }}
                  animate={{ x: 0 }}
                  exit={{ x: '100%' }}
                  transition={{ type: 'spring', damping: 20, stiffness: 300 }}
                  className="absolute right-0 top-0 h-full w-80 bg-black/95 backdrop-blur-xl border-l border-white/10"
                  onClick={(e) => e.stopPropagation()}
                >
                  <div className="p-8 pt-20">
                    <div className="space-y-6">
                      {menuItems.map((item, index) => (
                        <motion.button
                          key={item.id}
                          initial={{ opacity: 0, x: 50 }}
                          animate={{ opacity: 1, x: 0 }}
                          transition={{ delay: index * 0.1 }}
                          onClick={() => item.id === 'contact' ? handleContactClick() : scrollToSection(item.id)}
                          className="flex items-center gap-4 w-full p-4 text-white hover:bg-white/10 rounded-xl transition-colors duration-200"
                        >
                          <item.icon className="w-6 h-6" />
                          <span className="text-lg font-sf-pro-text font-medium">{item.label}</span>
                        </motion.button>
                      ))}
                    </div>

                    {/* Download CV Button */}
                    <div className="mt-12 pt-8 border-t border-white/10">
                      <motion.button
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.6 }}
                        onClick={handleDownloadCV}
                        whileHover={{ scale: 1.05 }}
                        whileTap={{ scale: 0.95 }}
                        className="w-full flex items-center gap-4 p-4 bg-gradient-to-r from-apple-green to-apple-green-secondary backdrop-blur-sm rounded-xl border border-apple-green/30 hover:shadow-glass transition-all duration-200"
                      >
                        <Download className="w-6 h-6 text-white" />
                        <span className="text-white font-sf-pro-text font-medium">Download CV</span>
                      </motion.button>
                    </div>
                  </div>
                </motion.div>
              </motion.div>
            )}
          </AnimatePresence>
        </>
      )}
    </>
  );
};

export default Navigation;