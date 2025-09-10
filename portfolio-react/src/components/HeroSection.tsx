import React, { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { Instagram, Facebook, Mail, ChevronDown } from 'lucide-react';

const HeroSection: React.FC = () => {
  const [isMobile, setIsMobile] = useState(false);
  const [, setIsTablet] = useState(false);

  useEffect(() => {
    const checkScreenSize = () => {
      setIsMobile(window.innerWidth < 768);
      setIsTablet(window.innerWidth < 1024);
    };

    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
    return () => window.removeEventListener('resize', checkScreenSize);
  }, []);

  const socialLinks = [
    {
      label: 'Instagram',
      icon: Instagram,
      color: 'text-pink-400',
      url: 'https://instagram.com/shaunmistula'
    },
    {
      label: 'Facebook',
      icon: Facebook,
      color: 'text-blue-400',
      url: 'https://facebook.com/shaunmistula'
    },
    {
      label: 'Email',
      icon: Mail,
      color: 'text-orange-400',
      url: 'mailto:shaunmistula@gmail.com'
    }
  ];

  const handleSocialClick = (url: string) => {
    window.open(url, '_blank');
  };

  const scrollToNext = () => {
    const nextSection = document.querySelector('#about');
    nextSection?.scrollIntoView({ behavior: 'smooth' });
  };

  if (isMobile) {
    return (
      <div 
        className="w-full h-screen relative overflow-hidden"
        style={{
          backgroundImage: 'url(/assets/images/photography/1000031090 (1).jpg)',
          backgroundSize: 'cover',
          backgroundPosition: 'center',
          backgroundAttachment: 'fixed'
        }}
      >
        {/* Gradient Overlay */}
        <div className="absolute inset-0 bg-gradient-to-b from-black/40 via-black/60 to-black/50" />
        
        {/* Content */}
        <div className="relative z-10 h-full flex flex-col items-center justify-center px-4 sm:px-6">
          {/* Profile Picture */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.2 }}
            className="relative mb-8"
          >
            <div className="w-48 h-60 rounded-2xl overflow-hidden shadow-glass-heavy">
              <img
                src="/assets/images/profile.jpg"
                alt="Shaun Mistula"
                className="w-full h-full object-cover"
                onError={(e) => {
                  const target = e.target as HTMLImageElement;
                  target.style.display = 'none';
                  const parent = target.parentElement;
                  if (parent) {
                    parent.innerHTML = `
                      <div class="w-full h-full bg-apple-green/10 flex items-center justify-center backdrop-blur-sm">
                        <div class="text-apple-green text-6xl">👤</div>
                      </div>
                    `;
                  }
                }}
              />
            </div>
          </motion.div>

          {/* Name */}
          <motion.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.4 }}
            className="text-4xl font-bold text-white text-center mb-4 font-sf-pro"
            style={{ lineHeight: '1.1' }}
          >
            Shaun Mistula
          </motion.h1>

          {/* Title */}
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.6 }}
            className="text-xl text-white/90 text-center mb-6 font-sf-pro-text font-normal"
          >
            Creative Developer & Designer
          </motion.h2>

          {/* Description */}
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.8 }}
            className="text-base text-white/80 text-center mb-8 font-sf-pro-text"
            style={{ lineHeight: '1.5' }}
          >
            Passionate about creating beautiful, functional experiences through code and design.
          </motion.p>

          {/* Social Links */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 1.0 }}
            className="flex flex-wrap gap-4 justify-center mb-8"
          >
            {socialLinks.map((social) => (
              <motion.button
                key={social.label}
                onClick={() => handleSocialClick(social.url)}
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className="flex items-center gap-2 px-6 py-3 bg-white/10 backdrop-blur-xl rounded-xl border border-white/20 hover:bg-white/20 transition-all duration-300 shadow-glass"
              >
                <social.icon className="w-4 h-4 text-white" />
                <span className="text-white font-medium text-sm font-sf-pro-text">
                  {social.label}
                </span>
              </motion.button>
            ))}
          </motion.div>

          {/* Scroll Indicator */}
          <motion.button
            onClick={scrollToNext}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.8, delay: 1.2 }}
            className="text-white/60 hover:text-white transition-colors duration-300"
          >
            <ChevronDown className="w-6 h-6 animate-bounce" />
          </motion.button>
        </div>
      </div>
    );
  }

  return (
    <section 
      id="hero"
      className="w-full h-screen relative overflow-hidden"
      style={{
        backgroundImage: 'url(/assets/images/photography/1000031090 (1).jpg)',
        backgroundSize: 'cover',
        backgroundPosition: 'center',
        backgroundAttachment: 'fixed'
      }}
    >
      {/* Gradient Overlay */}
      <div className="absolute inset-0 bg-gradient-to-b from-black/30 via-black/60 to-black/40" />
      
      {/* Content */}
      <div className="relative z-10 h-full flex items-center px-4 sm:px-6 md:px-8 lg:px-12">
        <div className="flex w-full">
          {/* Left side - Name and Title */}
          <div className="flex-1 flex flex-col justify-center">
            <motion.div
              initial={{ opacity: 0, x: -50 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.8, delay: 0.2 }}
            >
              {/* Name */}
              <h1 
                className="text-6xl font-bold text-white mb-6 font-sf-pro"
                style={{ 
                  lineHeight: '1.1',
                  fontWeight: '700'
                }}
              >
                Shaun Mistula
              </h1>

              {/* Title */}
              <h2 
                className="text-3xl text-white/90 mb-8 font-sf-pro-text font-normal"
              >
                Creative Developer & Designer
              </h2>

              {/* Description */}
              <p 
                className="text-lg text-white/80 mb-12 font-sf-pro-text"
                style={{ lineHeight: '1.5' }}
              >
                Passionate about creating beautiful, functional experiences through code and design.
              </p>

              {/* Social Links */}
              <div className="flex flex-wrap gap-4 mb-8">
                {socialLinks.map((social, index) => (
                  <motion.button
                    key={social.label}
                    onClick={() => handleSocialClick(social.url)}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8, delay: 0.8 + index * 0.1 }}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    className="flex items-center gap-2 px-6 py-3 bg-white/10 backdrop-blur-xl rounded-xl border border-white/20 hover:bg-white/20 transition-all duration-300 shadow-glass"
                  >
                    <social.icon className="w-4 h-4 text-white" />
                    <span className="text-white font-medium text-sm font-sf-pro-text">
                      {social.label}
                    </span>
                  </motion.button>
                ))}
              </div>
            </motion.div>
          </div>

          {/* Spacer */}
          <div className="w-4 sm:w-6 md:w-8 lg:w-12" />

          {/* Right side - Profile Picture */}
          <div className="flex-1 flex items-center justify-center">
            <motion.div
              initial={{ opacity: 0, y: 50 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8, delay: 0.4 }}
              className="relative"
            >
              <motion.div
                animate={{ y: [0, -10, 0] }}
                transition={{ duration: 3, repeat: Infinity, ease: "easeInOut" }}
                className="w-64 h-80 sm:w-72 sm:h-96 md:w-80 md:h-[400px] lg:w-96 lg:h-[500px] rounded-3xl overflow-hidden shadow-glass-heavy"
              >
                <img
                  src="/assets/images/profile.jpg"
                  alt="Shaun Mistula"
                  className="w-full h-full object-cover"
                  onError={(e) => {
                    const target = e.target as HTMLImageElement;
                    target.style.display = 'none';
                    const parent = target.parentElement;
                    if (parent) {
                      parent.innerHTML = `
                        <div class="w-full h-full bg-apple-green/10 flex items-center justify-center backdrop-blur-sm">
                          <div class="text-apple-green text-8xl">👤</div>
                        </div>
                      `;
                    }
                  }}
                />
              </motion.div>
            </motion.div>
          </div>
        </div>
      </div>

      {/* Scroll Indicator */}
      <motion.button
        onClick={scrollToNext}
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 0.8, delay: 1.2 }}
        className="absolute bottom-8 left-1/2 transform -translate-x-1/2 text-white/60 hover:text-white transition-colors duration-300"
      >
        <ChevronDown className="w-6 h-6 animate-bounce" />
      </motion.button>
    </section>
  );
};

export default HeroSection;