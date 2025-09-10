import Navigation from './components/Navigation';
import HeroSection from './components/HeroSection';
import AboutSection from './components/AboutSection';
import ProjectsSection from './components/ProjectsSection';
import PhotographySection from './components/PhotographySection';
import VideosSection from './components/VideosSection';
import Footer from './components/Footer';
import './index.css';

function App() {
  return (
    <div className="min-h-screen bg-black text-white">
      <Navigation />
      <HeroSection />
      <AboutSection />
      <ProjectsSection />
      <PhotographySection />
      <VideosSection />
      <Footer />
    </div>
  );
}

export default App;