import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../constants/fonts.dart';
import '../constants/app_theme.dart';

enum MenuStyle {
  home,
  facebook,
  instagram,
  tiktok,
  youtube,
  videos,
  photography,
  about,
  email,
  cv
}

class NavBar extends StatefulWidget {
  const NavBar({super.key, this.onNavigate});

  final ValueChanged<String>? onNavigate;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  late AnimationController _menuController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _menuController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _openMenuSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final isSmall = MediaQuery.of(context).size.width < 600;
        final horizontalPad = isSmall ? 16.0 : 24.0;
        final fontSize = isSmall ? 12.0 : 14.0;
        final iconSize = isSmall ? 16.0 : 20.0;
        final maxButtonWidth = isSmall ? double.infinity : 440.0;

        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF1A1A1A).withOpacity(0.95)
                    : Colors.white.withOpacity(0.95),
                Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF0A0A0A).withOpacity(0.98)
                    : Colors.white.withOpacity(0.98),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(horizontalPad, 24, horizontalPad, 32),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Handle bar
                        Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),

                        // Profile Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF7FEFAC).withOpacity(0.1),
                                const Color(0xFF7FEFAC).withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF7FEFAC).withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: isSmall ? 52 : 60,
                                height: isSmall ? 52 : 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/profile.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFF7FEFAC),
                                    width: 2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Shaun Mistula',
                                      style: TextStyle(
                                        fontFamily: AppFonts.samsungSharp,
                                        fontWeight: AppFonts.bold,
                                        fontSize: fontSize + 2,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Creative Portfolio',
                                      style: TextStyle(
                                        fontFamily: AppFonts.samsungOne,
                                        fontWeight: AppFonts.medium,
                                        fontSize: fontSize - 2,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white.withOpacity(0.7)
                                            : Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Theme toggle
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    AppTheme.toggle();
                                  },
                                  icon: Icon(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Icons.light_mode
                                        : Icons.dark_mode,
                                    size: iconSize,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Navigation
                        _buildSectionHeader('Navigation', fontSize - 2),
                        const SizedBox(height: 20),
                        _wrapMenuButton(
                          _buildModernMenuButton('Home', MenuStyle.home, () {
                            _scrollToSection('home');
                          }, fontSize, iconSize),
                          maxButtonWidth,
                        ),
                        _wrapMenuButton(
                          _buildModernMenuButton('About', MenuStyle.about, () {
                            _scrollToSection('about');
                          }, fontSize, iconSize),
                          maxButtonWidth,
                        ),
                        _wrapMenuButton(
                          _buildModernMenuButton('Photography', MenuStyle.photography, () {
                            _scrollToSection('photography');
                          }, fontSize, iconSize),
                          maxButtonWidth,
                        ),
                        _wrapMenuButton(
                          _buildModernMenuButton('Videos', MenuStyle.videos,
                              () {
                            _scrollToSection('videos');
                          }, fontSize, iconSize),
                          maxButtonWidth,
                        ),

                        const SizedBox(height: 32),

                        // Resources
                        _buildSectionHeader('Resources', fontSize - 2),
                        const SizedBox(height: 20),
                        _wrapMenuButton(
                          _buildModernMenuButton('Download CV', MenuStyle.cv,
                              () {
                            _downloadCV();
                          }, fontSize, iconSize),
                          maxButtonWidth,
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: AppFonts.samsungSharp,
          fontWeight: AppFonts.bold,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.6)
              : Colors.black54,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildStyledMenuButton(String text, MenuStyle style,
      VoidCallback onTap, double fontSize, double iconSize) {
    Color baseBg;
    Color textColor;
    Color iconColor;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (style) {
      case MenuStyle.facebook:
        baseBg = const Color(0xFF1877F2).withOpacity(0.12);
        textColor = const Color(0xFF1877F2);
        iconColor = const Color(0xFF1877F2);
        break;
      case MenuStyle.instagram:
        baseBg = const Color(0xFFE4405F).withOpacity(0.12);
        textColor = const Color(0xFFE4405F);
        iconColor = const Color(0xFFE4405F);
        break;
      case MenuStyle.tiktok:
        baseBg = Colors.black.withOpacity(0.08);
        textColor = Colors.black;
        iconColor = Colors.black;
        break;
      case MenuStyle.youtube:
        baseBg = const Color(0xFFFF0000).withOpacity(0.12);
        textColor = const Color(0xFFFF0000);
        iconColor = const Color(0xFFFF0000);
        break;
      case MenuStyle.email:
        baseBg = const Color(0xFF2E7D32).withOpacity(0.12);
        textColor = const Color(0xFF2E7D32);
        iconColor = const Color(0xFF2E7D32);
        break;
      case MenuStyle.cv:
        baseBg = const Color(0xFFFF9800).withOpacity(0.12);
        textColor = const Color(0xFFFF9800);
        iconColor = const Color(0xFFFF9800);
        break;
      case MenuStyle.about:
        baseBg = Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withOpacity(0.08)
            : Colors.black.withOpacity(0.06);
        textColor = Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87;
        iconColor = textColor;
        break;
      case MenuStyle.videos:
        baseBg = const Color(0xFF7FEFAC).withOpacity(0.15);
        textColor = const Color(0xFF0E3B23);
        iconColor = const Color(0xFF0E3B23);
        break;
      case MenuStyle.home:
      default:
        baseBg = const Color(0xFF7FEFAC).withOpacity(0.2);
        textColor = const Color(0xFF0E3B23);
        iconColor = const Color(0xFF0E3B23);
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).maybePop();
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: baseBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _getIconForStyle(style, iconColor, iconSize),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: AppFonts.samsungSharp,
                  fontWeight: AppFonts.medium,
                  fontSize: fontSize + 2,
                  letterSpacing: 0.2,
                  color: textColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: iconSize - 4,
              color: isDark
                  ? Colors.white.withOpacity(0.4)
                  : Colors.black.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernMenuButton(String text, MenuStyle style,
      VoidCallback onTap, double fontSize, double iconSize) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor;
    Color backgroundColor;
    Color textColor;

    switch (style) {
      case MenuStyle.home:
        primaryColor = const Color(0xFF7FEFAC);
        backgroundColor =
            isDark ? const Color(0xFF1A2B1F) : const Color(0xFFF0FDF4);
        textColor = isDark ? const Color(0xFF7FEFAC) : const Color(0xFF0F5132);
        break;
      case MenuStyle.about:
        primaryColor =
            isDark ? const Color(0xFF60A5FA) : const Color(0xFF3B82F6);
        backgroundColor =
            isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);
        textColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A);
        break;
      case MenuStyle.photography:
        primaryColor = const Color(0xFF8B5CF6);
        backgroundColor = isDark ? const Color(0xFF2D1B3D) : const Color(0xFFFAF5FF);
        textColor = isDark ? const Color(0xFF8B5CF6) : const Color(0xFF7C3AED);
        break;
      case MenuStyle.videos:
        primaryColor = const Color(0xFFEC4899);
        backgroundColor =
            isDark ? const Color(0xFF2D1B2E) : const Color(0xFFFDF2F8);
        textColor = isDark ? const Color(0xFFEC4899) : const Color(0xFFBE185D);
        break;
      case MenuStyle.cv:
        primaryColor = const Color(0xFFFF9800);
        backgroundColor =
            isDark ? const Color(0xFF2D1F0A) : const Color(0xFFFFF7ED);
        textColor = isDark ? const Color(0xFFFF9800) : const Color(0xFFC2410C);
        break;
      default:
        primaryColor = const Color(0xFF7FEFAC);
        backgroundColor =
            isDark ? const Color(0xFF1A2B1F) : const Color(0xFFF0FDF4);
        textColor = isDark ? const Color(0xFF7FEFAC) : const Color(0xFF0F5132);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).maybePop();
            onTap();
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: primaryColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getIconDataForStyle(style),
                    size: iconSize,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: AppFonts.samsungSharp,
                      fontWeight: AppFonts.bold,
                      fontSize: fontSize + 3,
                      letterSpacing: 0.1,
                      color: textColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: iconSize + 2,
                  color: primaryColor.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconDataForStyle(MenuStyle style) {
    switch (style) {
      case MenuStyle.home:
        return Icons.home_outlined;
      case MenuStyle.about:
        return Icons.person_outline;
      case MenuStyle.photography:
        return Icons.camera_alt_outlined;
      case MenuStyle.videos:
        return Icons.play_circle_outline;
      case MenuStyle.cv:
        return Icons.download_outlined;
      default:
        return Icons.circle_outlined;
    }
  }

  Widget _getIconForStyle(MenuStyle style, Color iconColor, double iconSize) {
    IconData iconData;

    switch (style) {
      case MenuStyle.home:
        iconData = Icons.home_outlined;
        break;
      case MenuStyle.about:
        iconData = Icons.person_outline;
        break;
      case MenuStyle.photography:
        iconData = Icons.camera_alt_outlined;
        break;
      case MenuStyle.videos:
        iconData = Icons.play_circle_outline;
        break;
      case MenuStyle.facebook:
        iconData = Icons.facebook;
        break;
      case MenuStyle.instagram:
        iconData = Icons.camera_alt_outlined;
        break;
      case MenuStyle.tiktok:
        iconData = Icons.music_note;
        break;
      case MenuStyle.youtube:
        iconData = Icons.play_circle;
        break;
      case MenuStyle.email:
        iconData = Icons.email_outlined;
        break;
      case MenuStyle.cv:
        iconData = Icons.download_outlined;
        break;
    }

    return Icon(
      iconData,
      size: iconSize,
      color: iconColor,
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _scrollToSection(String section) {
    // Close menu then notify parent to navigate
    widget.onNavigate?.call(section);
  }

  void _downloadCV() {
    final anchor = html.AnchorElement(href: 'assets/pdf/MISTULA_CV.pdf');
    anchor.download = 'MISTULA_CV.pdf';
    anchor.click();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final double buttonSize = isSmall ? 48 : 60;

    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: buttonSize + 16,
        child: Stack(
          children: [
            Positioned(
              top: 8,
              right: isSmall ? 16 : 32,
              child: MouseRegion(
                onEnter: (_) => _menuController.forward(),
                onExit: (_) => _menuController.reverse(),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _openMenuSheet(context),
                  child: AnimatedBuilder(
                    animation:
                        Listenable.merge([_menuController, _pulseController]),
                    builder: (context, child) {
                      final elevation = 4 + 8 * _menuController.value;
                      final pulseScale = 1.0 + 0.05 * _pulseController.value;
                      final isDark =
                          Theme.of(context).brightness == Brightness.dark;
                      final bg = isDark
                          ? const Color(0xFF1A1A1A)
                          : const Color(0xFF000000).withOpacity(0.9);

                      return Transform.scale(
                        scale: pulseScale,
                        child: Container(
                          width: buttonSize,
                          height: buttonSize,
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(buttonSize * 0.5),
                              topRight: Radius.circular(buttonSize * 0.5),
                              bottomLeft: Radius.circular(buttonSize * 0.1),
                              bottomRight: Radius.circular(buttonSize * 0.1),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7FEFAC)
                                    .withOpacity(0.3 * _pulseController.value),
                                blurRadius: 20 + 10 * _pulseController.value,
                                spreadRadius: 2 + 2 * _pulseController.value,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: elevation,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: AnimatedRotation(
                              turns: _menuController.value * 0.125,
                              duration: const Duration(milliseconds: 180),
                              child: Icon(
                                Icons.menu,
                                size: isSmall ? 22 : 26,
                                color: const Color(0xFF7FEFAC),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wrapMenuButton(Widget child, double maxWidth) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    );
  }
}
