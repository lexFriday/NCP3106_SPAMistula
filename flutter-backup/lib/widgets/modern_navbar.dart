import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/samsung_one_ui_theme.dart';

class ModernNavBar extends StatefulWidget {
  const ModernNavBar({super.key, this.onNavigate, this.onMenuToggle});

  final ValueChanged<String>? onNavigate;
  final VoidCallback? onMenuToggle;

  @override
  State<ModernNavBar> createState() => _ModernNavBarState();
}

class _ModernNavBarState extends State<ModernNavBar> with TickerProviderStateMixin {
  late AnimationController _menuController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
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
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.95),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: 24),
              child: Column(
                children: [
                  // Handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Menu Items
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildModernMenuButton(
                            context,
                            'Home',
                            'home',
                            Icons.home_outlined,
                            Colors.blue,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildModernMenuButton(
                            context,
                            'About',
                            'about',
                            Icons.person_outline,
                            Colors.green,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildModernMenuButton(
                            context,
                            'Projects',
                            'projects',
                            Icons.code_outlined,
                            Colors.purple,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildModernMenuButton(
                            context,
                            'Photography',
                            'photography',
                            Icons.camera_alt_outlined,
                            Colors.pink,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildModernMenuButton(
                            context,
                            'Videos',
                            'videos',
                            Icons.play_circle_outline,
                            Colors.red,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildModernMenuButton(
                            context,
                            'Email',
                            'email',
                            Icons.email_outlined,
                            Colors.orange,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                            onTap: () => _launchURL('mailto:shaunmistula@gmail.com'),
                          ),
                          _buildModernMenuButton(
                            context,
                            'Download CV',
                            'cv',
                            Icons.download_outlined,
                            Colors.teal,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                            onTap: () => _launchURL('https://drive.google.com/file/d/1YQZQZQZQZQZQZQZQZQZQZQZQZQZQZQZ/view'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernMenuButton(
    BuildContext context,
    String label,
    String section,
    IconData icon,
    Color color,
    double maxWidth,
    double fontSize,
    double iconSize, {
    VoidCallback? onTap,
  }) {
    return Container(
      width: maxWidth,
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {
            widget.onNavigate?.call(section);
            Navigator.of(context).pop();
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.2),
                  color.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: iconSize,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? SamsungOneUITheme.spacingL : SamsungOneUITheme.spacingXXL,
          vertical: SamsungOneUITheme.spacingM,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.6),
            ],
          ),
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Logo/Brand with Glass Effect
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    SamsungOneUITheme.primaryBlue.withOpacity(0.2),
                    SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: SamsungOneUITheme.primaryBlue.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'Shaun Mistula',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),

            const Spacer(),

            // Desktop Navigation
            if (!isMobile) ...[
              _buildDesktopNavItem(context, 'Home', 'home', Colors.blue),
              _buildDesktopNavItem(context, 'About', 'about', Colors.green),
              _buildDesktopNavItem(context, 'Projects', 'projects', Colors.purple),
              _buildDesktopNavItem(context, 'Photography', 'photography', Colors.pink),
              _buildDesktopNavItem(context, 'Videos', 'videos', Colors.red),
              _buildDesktopCVButton(context),
            ],

            // Mobile Menu Button
            if (isMobile)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      SamsungOneUITheme.primaryBlue.withOpacity(0.2),
                      SamsungOneUITheme.primaryBlue.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: SamsungOneUITheme.primaryBlue.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  onPressed: () => _openMenuSheet(context),
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopNavItem(BuildContext context, String label, String section, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onNavigate?.call(section),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.1),
                  color.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopCVButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchURL('https://drive.google.com/file/d/1YQZQZQZQZQZQZQZQZQZQZQZQZQZQZQZ/view'),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal.withOpacity(0.3),
                  Colors.teal.withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.teal.withOpacity(0.4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.download_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Download CV',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}


