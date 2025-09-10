import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/apple_ui_theme.dart';

class AppleNavBar extends StatefulWidget {
  const AppleNavBar({super.key, this.onNavigate, this.onMenuToggle});

  final ValueChanged<String>? onNavigate;
  final VoidCallback? onMenuToggle;

  @override
  State<AppleNavBar> createState() => _AppleNavBarState();
}

class _AppleNavBarState extends State<AppleNavBar>
    with TickerProviderStateMixin {
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
            color: Theme.of(context).brightness == Brightness.dark
                ? AppleUITheme.surfaceDark
                : AppleUITheme.surfaceLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: AppleUITheme.heavyShadow,
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: horizontalPad, vertical: 24),
              child: Column(
                children: [
                  // Handle
                  Container(
                    width: 36,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.3)
                          : Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Menu Items
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildAppleMenuButton(
                            context,
                            'Home',
                            'home',
                            Icons.home_outlined,
                            AppleUITheme.primaryGreen,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildAppleMenuButton(
                            context,
                            'About',
                            'about',
                            Icons.person_outline,
                            AppleUITheme.accentBlue,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildAppleMenuButton(
                            context,
                            'Projects',
                            'projects',
                            Icons.code_outlined,
                            AppleUITheme.accentPurple,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildAppleMenuButton(
                            context,
                            'Photography',
                            'photography',
                            Icons.camera_alt_outlined,
                            AppleUITheme.accentPink,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildAppleMenuButton(
                            context,
                            'Videos',
                            'videos',
                            Icons.play_circle_outline,
                            AppleUITheme.accentRed,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                          ),
                          _buildAppleMenuButton(
                            context,
                            'Email',
                            'email',
                            Icons.email_outlined,
                            AppleUITheme.accentOrange,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                            onTap: () =>
                                _launchURL('mailto:shaunmistula@gmail.com'),
                          ),
                          _buildAppleMenuButton(
                            context,
                            'Download CV',
                            'cv',
                            Icons.download_outlined,
                            AppleUITheme.secondaryGreen,
                            maxButtonWidth,
                            fontSize,
                            iconSize,
                            onTap: () => _launchURL(
                                'https://drive.google.com/file/d/1YQZQZQZQZQZQZQZQZQZQZQZQZQZQZQZ/view'),
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

  Widget _buildAppleMenuButton(
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
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ??
              () {
                widget.onNavigate?.call(section);
                Navigator.of(context).pop();
              },
          borderRadius: BorderRadius.circular(AppleUITheme.radiusM),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppleUITheme.surfaceSecondaryDark
                  : AppleUITheme.surfaceSecondaryLight,
              borderRadius: BorderRadius.circular(AppleUITheme.radiusM),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppleUITheme.borderDark
                    : AppleUITheme.borderLight,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppleUITheme.radiusS),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: iconSize,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppleUITheme.textPrimaryDark
                          : AppleUITheme.textPrimaryLight,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppleUITheme.textSecondaryDark
                      : AppleUITheme.textSecondaryLight,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal:
              isMobile ? AppleUITheme.spacingL : AppleUITheme.spacingXXL,
          vertical: AppleUITheme.spacingM,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? AppleUITheme.surfaceDark.withOpacity(0.8)
              : AppleUITheme.surfaceLight.withOpacity(0.8),
          border: Border(
            bottom: BorderSide(
              color:
                  isDark ? AppleUITheme.borderDark : AppleUITheme.borderLight,
              width: 0.5,
            ),
          ),
          boxShadow: AppleUITheme.lightShadow,
        ),
        child: Row(
          children: [
            // Logo/Brand
            Text(
              'Shaun Mistula',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppleUITheme.primaryGreen,
                  ),
            ),

            const Spacer(),

            // Desktop Navigation
            if (!isMobile) ...[
              _buildDesktopNavItem(context, 'Home', 'home'),
              _buildDesktopNavItem(context, 'About', 'about'),
              _buildDesktopNavItem(context, 'Projects', 'projects'),
              _buildDesktopNavItem(context, 'Photography', 'photography'),
              _buildDesktopNavItem(context, 'Videos', 'videos'),
              _buildDesktopCVButton(context),
            ],

            // Mobile Menu Button
            if (isMobile)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _openMenuSheet(context),
                  borderRadius: BorderRadius.circular(AppleUITheme.radiusM),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppleUITheme.surfaceSecondaryDark
                          : AppleUITheme.surfaceSecondaryLight,
                      borderRadius: BorderRadius.circular(AppleUITheme.radiusM),
                      border: Border.all(
                        color: isDark
                            ? AppleUITheme.borderDark
                            : AppleUITheme.borderLight,
                        width: 0.5,
                      ),
                    ),
                    child: Icon(
                      Icons.menu,
                      color: isDark
                          ? AppleUITheme.textPrimaryDark
                          : AppleUITheme.textPrimaryLight,
                      size: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopNavItem(
      BuildContext context, String label, String section) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onNavigate?.call(section),
          borderRadius: BorderRadius.circular(AppleUITheme.radiusM),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              label,
              style: TextStyle(
                color: isDark
                    ? AppleUITheme.textPrimaryDark
                    : AppleUITheme.textPrimaryLight,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopCVButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchURL(
              'https://drive.google.com/file/d/1YQZQZQZQZQZQZQZQZQZQZQZQZQZQZQZ/view'),
          borderRadius: BorderRadius.circular(AppleUITheme.radiusM),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppleUITheme.primaryGreen,
              borderRadius: BorderRadius.circular(AppleUITheme.radiusM),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.download_outlined,
                  color: Colors.white,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  'Download CV',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
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
