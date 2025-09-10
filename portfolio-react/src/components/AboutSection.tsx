import React, { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { User, GraduationCap, Star, Crown } from 'lucide-react';

const AboutSection: React.FC = () => {
  const [isMobile, setIsMobile] = useState(false);

  useEffect(() => {
    const checkScreenSize = () => {
      setIsMobile(window.innerWidth < 768);
    };

    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
    return () => window.removeEventListener('resize', checkScreenSize);
  }, []);

  const highlightCards = [
    {
      title: 'Education',
      subtitle: 'Computer Engineering Student',
      description: 'University of the East Manila',
      color: 'samsung-green',
      icon: GraduationCap
    },
    {
      title: 'Samsung Ambassador',
      subtitle: 'Galaxy Campus Student Ambassador',
      description: 'Creating content with Galaxy S25 Ultra, Z Fold6, Tab S9 FE, and Watch7',
      color: 'samsung-blue',
      icon: Star
    },
    {
      title: 'Leadership',
      subtitle: 'SCPES President',
      description: 'Society of Computer Engineering Students',
      color: 'samsung-purple',
      icon: Crown
    }
  ];

  return (
    <section id="about" className="w-full py-16 px-4 sm:px-6 md:px-8 lg:px-12">
      <div className="max-w-7xl mx-auto">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
          viewport={{ once: true }}
          className="p-8 bg-gradient-to-br from-blue-500/10 to-blue-600/5 backdrop-blur-xl rounded-3xl border border-blue-500/30 mb-12 shadow-glass"
        >
          <div className="flex items-start gap-6">
            <div className="p-4 bg-blue-500/20 backdrop-blur-sm rounded-2xl">
              <User className="w-8 h-8 text-blue-500" />
            </div>
            <div className="flex-1">
              <h2 className="text-4xl sm:text-5xl font-bold text-white mb-2 font-sf-pro">
                About Me
              </h2>
              <p className="text-lg text-white/70 font-sf-pro-text">
                Get to know my journey and passion
              </p>
            </div>
          </div>
        </motion.div>

        {/* Main Content */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.2 }}
          viewport={{ once: true }}
          className="p-8 bg-white/5 backdrop-blur-xl rounded-3xl border border-white/10 shadow-glass-heavy"
        >
          {/* Main Description */}
          <motion.p
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            transition={{ duration: 0.8, delay: 0.4 }}
            viewport={{ once: true }}
            className="text-lg text-center mb-12 font-sf-pro-text text-white/90"
            style={{ lineHeight: '1.8' }}
          >
            I'm Shaun Paul Alexis Mistula — a Filipino Computer Engineering student at the University of the East Manila. As President of SCPES and a Samsung Galaxy Campus Student Ambassador, I build, lead, and create. I'm passionate about embedded systems, IoT, and integrating AI into real-world solutions.
          </motion.p>

          {/* Key Highlights Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
            {highlightCards.map((card, index) => (
              <motion.div
                key={card.title}
                initial={{ opacity: 0, y: 30 }}
                whileInView={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.8, delay: 0.6 + index * 0.1 }}
                viewport={{ once: true }}
                className={`p-6 bg-gradient-to-br from-${card.color}/15 to-${card.color}/5 backdrop-blur-xl rounded-2xl border border-${card.color}/30 shadow-glass hover:shadow-glass-heavy transition-all duration-300`}
                style={{ aspectRatio: isMobile ? '2.5' : '1.2' }}
              >
                <div className="flex items-start gap-4 mb-4">
                  <div className={`p-3 bg-${card.color}/20 backdrop-blur-sm rounded-xl`}>
                    <card.icon className={`w-6 h-6 text-${card.color}`} />
                  </div>
                  <div className="flex-1">
                    <h3 className={`text-xl font-bold text-${card.color} font-sf-pro font-bold`}>
                      {card.title}
                    </h3>
                  </div>
                </div>
                
                <h4 className="text-lg font-semibold mb-2 font-sf-pro-text font-semibold text-white">
                  {card.subtitle}
                </h4>
                
                <p 
                  className="text-sm text-white/70 font-sf-pro-text"
                  style={{ lineHeight: '1.5' }}
                >
                  {card.description}
                </p>
              </motion.div>
            ))}
          </div>
        </motion.div>
      </div>
    </section>
  );
};

export default AboutSection;