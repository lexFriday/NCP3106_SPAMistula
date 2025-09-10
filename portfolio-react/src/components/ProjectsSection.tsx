import React, { useEffect, useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Code, Cpu, Bot, Server, Camera, Zap, ChevronDown, ChevronUp } from 'lucide-react';

interface Project {
  title: string;
  description: string;
  icon: React.ComponentType<any>;
  color: string;
  category: string;
  tech: string[];
}

const ProjectsSection: React.FC = () => {
  const [, setIsMobile] = useState(false);
  const [isExpanded, setIsExpanded] = useState(false);

  useEffect(() => {
    const checkScreenSize = () => {
      setIsMobile(window.innerWidth < 768);
    };

    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
    return () => window.removeEventListener('resize', checkScreenSize);
  }, []);

  const projects: Project[] = [
    {
      title: 'ESP32/Arduino Sensors',
      description: 'Real-time sensors for temperature, humidity, pressure, and altitude monitoring',
      icon: Cpu,
      color: 'samsung-blue',
      category: 'IoT & Hardware',
      tech: ['ESP32', 'Arduino', 'C++', 'IoT']
    },
    {
      title: 'Raspberry Pi Automation',
      description: 'Orange Pi automation and monitoring systems for smart environments',
      icon: Bot,
      color: 'samsung-green',
      category: 'Automation',
      tech: ['Raspberry Pi', 'Python', 'Linux', 'Automation']
    },
    {
      title: 'Smart Glasses',
      description: 'AI-powered smart glasses with YOLO, Vosk, eSpeak, and Tinallmaa AI integration',
      icon: Zap,
      color: 'samsung-purple',
      category: 'AI & Wearables',
      tech: ['AI', 'YOLO', 'Python', 'Computer Vision']
    },
    {
      title: 'Personal Storage Server',
      description: 'Self-hosted storage server for personal data management and backup',
      icon: Server,
      color: 'samsung-orange',
      category: 'Infrastructure',
      tech: ['Linux', 'Docker', 'Networking', 'Storage']
    },
    {
      title: 'Photoshoot Website',
      description: 'Website with templates and camera integration for photography services',
      icon: Camera,
      color: 'apple-pink',
      category: 'Web Development',
      tech: ['Flutter', 'Web', 'Photography', 'UI/UX']
    },
    {
      title: 'Circuit Design',
      description: 'LTspice circuits, RC filters, and PCB design via UV printing',
      icon: Zap,
      color: 'gray-600',
      category: 'Electronics',
      tech: ['LTspice', 'PCB Design', 'Electronics', 'Hardware']
    }
  ];

  return (
    <section id="projects" className="w-full py-16 px-4 sm:px-6 md:px-8 lg:px-12">
      <div className="max-w-7xl mx-auto">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
          viewport={{ once: true }}
          className="p-8 bg-gradient-to-br from-samsung-green/10 to-samsung-green/5 backdrop-blur-xl rounded-3xl border border-samsung-green/30 mb-12 shadow-glass"
        >
          <div className="flex items-start gap-6">
            <div className="p-4 bg-samsung-green/20 backdrop-blur-sm rounded-2xl">
              <Code className="w-8 h-8 text-samsung-green" />
            </div>
            <div className="flex-1">
              <h2 className="text-4xl sm:text-5xl font-bold text-white mb-2 font-sf-pro">
                Projects & Technical Work
              </h2>
              <p className="text-lg text-white/70 font-sf-pro-text">
                Explore my technical projects spanning IoT, AI, web development, and hardware design
              </p>
            </div>
          </div>
        </motion.div>

        {/* Projects Dropdown */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.2 }}
          viewport={{ once: true }}
          className="bg-samsung-green/5 backdrop-blur-xl rounded-2xl border border-samsung-green/20 overflow-hidden shadow-glass"
        >
          {/* Dropdown Header */}
          <motion.button
            onClick={() => setIsExpanded(!isExpanded)}
            whileHover={{ backgroundColor: 'rgba(52, 199, 89, 0.1)' }}
            className="w-full p-6 flex items-center gap-4 hover:bg-samsung-green/10 transition-colors duration-200"
          >
            <Code className="w-6 h-6 text-samsung-green" />
            <div className="flex-1 text-left">
              <h3 className="text-xl font-bold text-samsung-green font-sf-pro font-bold">
                Technical Projects ({projects.length})
              </h3>
            </div>
            <motion.div
              animate={{ rotate: isExpanded ? 180 : 0 }}
              transition={{ duration: 0.3 }}
              className="text-samsung-green"
            >
              {isExpanded ? <ChevronUp className="w-6 h-6" /> : <ChevronDown className="w-6 h-6" />}
            </motion.div>
          </motion.button>

          {/* Dropdown Content */}
          <AnimatePresence>
            {isExpanded && (
              <motion.div
                initial={{ height: 0, opacity: 0 }}
                animate={{ height: 'auto', opacity: 1 }}
                exit={{ height: 0, opacity: 0 }}
                transition={{ duration: 0.3, ease: 'easeInOut' }}
                className="overflow-hidden"
              >
                <div className="border-t border-samsung-green/20 p-6 space-y-3">
                  {projects.map((project, index) => (
                    <motion.div
                      key={project.title}
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ duration: 0.3, delay: index * 0.05 }}
                      className={`p-4 bg-gradient-to-br from-${project.color}/10 to-${project.color}/5 backdrop-blur-sm rounded-xl border border-${project.color}/20 hover:shadow-glass transition-all duration-200`}
                    >
                      <div className="flex items-start gap-3">
                        <div className={`p-2 bg-${project.color}/20 backdrop-blur-sm rounded-lg`}>
                          <project.icon className={`w-5 h-5 text-${project.color}`} />
                        </div>
                        <div className="flex-1">
                          <div className="flex items-center gap-2 mb-1">
                            <h4 className="text-sm font-semibold text-white font-sf-pro-text font-semibold">
                              {project.title}
                            </h4>
                            <span className={`text-xs font-medium text-${project.color} font-sf-pro-text font-medium`}>
                              • {project.category}
                            </span>
                          </div>
                          <p className="text-xs text-white/70 mb-1 font-sf-pro-text" style={{ lineHeight: '1.2' }}>
                            {project.description}
                          </p>
                          <p className={`text-xs text-${project.color}/70 font-sf-pro-text font-normal`}>
                            {project.tech.slice(0, 3).join(' • ')}
                          </p>
                        </div>
                      </div>
                    </motion.div>
                  ))}
                </div>
              </motion.div>
            )}
          </AnimatePresence>
        </motion.div>
      </div>
    </section>
  );
};

export default ProjectsSection;