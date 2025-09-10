import 'package:flutter/material.dart';
import '../constants/apple_ui_theme.dart';
import '../widgets/apple_navbar.dart';
import '../widgets/footer_section.dart';
import '../widgets/apple_hero_section.dart';
import '../widgets/simple_about_section.dart';
import '../widgets/samsung_projects_section.dart';
import '../widgets/simple_photography_section.dart';
import '../widgets/simple_videos_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // Section anchors for navigation
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _photographyKey = GlobalKey();
  final GlobalKey _videosKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    GlobalKey? targetKey;
    switch (section) {
      case 'home':
        targetKey = _heroKey;
        break;
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'projects':
        targetKey = _projectsKey;
        break;
      case 'photography':
        targetKey = _photographyKey;
        break;
      case 'videos':
        targetKey = _videosKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building HomeScreen');
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor:
          isDark ? AppleUITheme.backgroundDark : AppleUITheme.backgroundLight,
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero Section
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _heroKey,
                  child: AppleHeroSection(),
                ),
              ),

              // About Section
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _aboutKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile
                          ? AppleUITheme.spacingL
                          : (screenWidth < 1200
                              ? AppleUITheme.spacingXXL
                              : AppleUITheme.spacingXXL * 2),
                    ),
                    child: SimpleAboutSection(),
                  ),
                ),
              ),

              // Projects Section
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _projectsKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile
                          ? AppleUITheme.spacingL
                          : (screenWidth < 1200
                              ? AppleUITheme.spacingXXL
                              : AppleUITheme.spacingXXL * 2),
                    ),
                    child: SamsungProjectsSection(),
                  ),
                ),
              ),

              // Photography Section
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _photographyKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile
                          ? AppleUITheme.spacingL
                          : (screenWidth < 1200
                              ? AppleUITheme.spacingXXL
                              : AppleUITheme.spacingXXL * 2),
                    ),
                    child: SimplePhotographySection(),
                  ),
                ),
              ),

              // Videos Section
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _videosKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile
                          ? AppleUITheme.spacingL
                          : (screenWidth < 1200
                              ? AppleUITheme.spacingXXL
                              : AppleUITheme.spacingXXL * 2),
                    ),
                    child: SimpleVideosSection(),
                  ),
                ),
              ),

              // Footer
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile
                        ? AppleUITheme.spacingL
                        : (screenWidth < 1200
                            ? AppleUITheme.spacingXXL
                            : AppleUITheme.spacingXXL * 2),
                  ),
                  child: const FooterSection(),
                ),
              ),
            ],
          ),

          // Navigation Bar
          AppleNavBar(
            onNavigate: (section) {
              _scrollToSection(section);
            },
          ),
        ],
      ),
    );
  }
}
