import React, { useRef } from 'react';
import Navigation from '../components/Navigation';
import HeroSection from '../components/HeroSection';
import AboutSection from '../components/AboutSection';
import ProjectsSection from '../components/ProjectsSection';
import PhotographySection from '../components/PhotographySection';
import VideosSection from '../components/VideosSection';
import Footer from '../components/Footer';

const HomePage: React.FC = () => {
  const heroRef = useRef<HTMLElement | null>(null);
  const aboutRef = useRef<HTMLElement | null>(null);
  const projectsRef = useRef<HTMLElement | null>(null);
  const photographyRef = useRef<HTMLElement | null>(null);
  const videosRef = useRef<HTMLElement | null>(null);

  // const scrollToSection = (section: string) => {
  //   let targetRef: React.RefObject<HTMLElement | null> | null = null;
  //   
  //   switch (section) {
  //     case 'home':
  //       targetRef = heroRef;
  //       break;
  //     case 'about':
  //       targetRef = aboutRef;
  //       break;
  //     case 'projects':
  //       targetRef = projectsRef;
  //       break;
  //     case 'photography':
  //       targetRef = photographyRef;
  //       break;
  //     case 'videos':
  //       targetRef = videosRef;
  //       break;
  //   }

  //   if (targetRef?.current) {
  //     targetRef.current.scrollIntoView({
  //       behavior: 'smooth',
  //       block: 'start',
  //     });
  //   }
  // };

  return (
    <div className="portfolio-container">
      <Navigation />
      
      <main>
        <section ref={heroRef} id="home">
          <HeroSection />
        </section>
        
        <section ref={aboutRef} id="about">
          <AboutSection />
        </section>
        
        <section ref={projectsRef} id="projects">
          <ProjectsSection />
        </section>
        
        <section ref={photographyRef} id="photography">
          <PhotographySection />
        </section>
        
        <section ref={videosRef} id="videos">
          <VideosSection />
        </section>
      </main>
      
      <Footer />
    </div>
  );
};

export default HomePage;

