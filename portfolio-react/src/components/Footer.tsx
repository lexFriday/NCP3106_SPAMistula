import React from 'react';
import { motion } from 'framer-motion';
import { Instagram, Facebook, Mail, Heart } from 'lucide-react';

const Footer: React.FC = () => {
  const socialLinks = [
    {
      label: 'Instagram',
      icon: Instagram,
      url: 'https://instagram.com/shaunmistula'
    },
    {
      label: 'Facebook',
      icon: Facebook,
      url: 'https://facebook.com/shaunmistula'
    },
    {
      label: 'Email',
      icon: Mail,
      url: 'mailto:shaunmistula@gmail.com'
    }
  ];

  const handleSocialClick = (url: string) => {
    window.open(url, '_blank');
  };

  return (
    <footer id="contact" className="w-full py-16 px-4 sm:px-6 md:px-8 lg:px-12">
      <div className="max-w-7xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
          viewport={{ once: true }}
          className="p-8 bg-white/5 backdrop-blur-xl rounded-3xl border border-white/10 shadow-glass text-center"
        >
          <h3 className="text-2xl font-bold text-white mb-4 font-sf-pro">
            Let's Connect
          </h3>
          <p className="text-white/70 mb-8 font-sf-pro-text">
            Ready to collaborate or just want to say hello?
          </p>
          
          {/* Social Links */}
          <div className="flex flex-wrap gap-4 justify-center mb-8">
            {socialLinks.map((social, index) => (
              <motion.button
                key={social.label}
                onClick={() => handleSocialClick(social.url)}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.8, delay: 0.2 + index * 0.1 }}
                viewport={{ once: true }}
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

          {/* Copyright */}
          <div className="flex items-center justify-center gap-2 text-white/50 font-sf-pro-text text-sm">
            <span>Made with</span>
            <Heart className="w-4 h-4 text-red-500 fill-current" />
            <span>by Shaun Mistula</span>
          </div>
        </motion.div>
      </div>
    </footer>
  );
};

export default Footer;