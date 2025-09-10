import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/samsung_one_ui_theme.dart';

class SamsungNavBar extends StatefulWidget {
  const SamsungNavBar({super.key, this.onNavigate, this.onMenuToggle});

  final ValueChanged<String>? onNavigate;
  final VoidCallback? onMenuToggle;

  @override
  State<SamsungNavBar> createState() => _SamsungNavBarState();
}

class _SamsungNavBarState extends State<SamsungNavBar> {

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile
              ? SamsungOneUITheme.spacingL
              : SamsungOneUITheme.spacingXXL,
          vertical: SamsungOneUITheme.spacingM,
        ),
        decoration: BoxDecoration(
          color: (isDark
                  ? SamsungOneUITheme.surfaceDark
                  : SamsungOneUITheme.surfaceLight)
              .withOpacity(0.95),
          border: Border(
            bottom: BorderSide(
              color: isDark
                  ? SamsungOneUITheme.borderDark
                  : SamsungOneUITheme.borderLight,
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Logo/Brand
            Text(
              'Shaun Mistula',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: SamsungOneUITheme.primaryBlue,
                  ),
            ),

            const Spacer(),

            // Desktop Navigation
            if (!isMobile) ...[
              _buildNavItem(context, 'Home', 'home'),
              _buildNavItem(context, 'About', 'about'),
              _buildNavItem(context, 'Projects', 'projects'),
              _buildNavItem(context, 'Photography', 'photography'),
              _buildNavItem(context, 'Videos', 'videos'),
              _buildCVButton(context),
            ],

            // Mobile Menu Button
            if (isMobile)
              IconButton(
                onPressed: () {
                  widget.onMenuToggle?.call();
                },
                icon: Icon(
                  Icons.menu,
                  color: SamsungOneUITheme.primaryBlue,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String label, String section) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: SamsungOneUITheme.spacingS),
      child: TextButton(
        onPressed: () {
          widget.onNavigate?.call(section);
        },
        style: TextButton.styleFrom(
          foregroundColor: SamsungOneUITheme.primaryBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: SamsungOneUITheme.spacingM,
            vertical: SamsungOneUITheme.spacingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  Widget _buildCVButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: SamsungOneUITheme.spacingM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SamsungOneUITheme.primaryGreen,
            SamsungOneUITheme.primaryGreen.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusM),
        boxShadow: [
          BoxShadow(
            color: SamsungOneUITheme.primaryGreen.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            const url = 'assets/pdf/MISTULA_CV.pdf';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
            }
          },
          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusM),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SamsungOneUITheme.spacingL,
              vertical: SamsungOneUITheme.spacingS,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download_outlined, color: Colors.white, size: 18),
                SizedBox(width: SamsungOneUITheme.spacingS),
                Text(
                  'Download CV',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Mobile Menu Overlay
class SamsungMobileMenu extends StatelessWidget {
  const SamsungMobileMenu({
    super.key,
    required this.isOpen,
    required this.onNavigate,
    required this.onClose,
  });

  final bool isOpen;
  final ValueChanged<String> onNavigate;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    if (!isOpen) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.only(top: 80),
        padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
        decoration: BoxDecoration(
          color: isDark
              ? SamsungOneUITheme.surfaceDark
              : SamsungOneUITheme.surfaceLight,
          border: Border.all(
            color: isDark
                ? SamsungOneUITheme.borderDark
                : SamsungOneUITheme.borderLight,
          ),
          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusM),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildMobileNavItem(context, 'Home', 'home', Icons.home_outlined),
            _buildMobileNavItem(
                context, 'About', 'about', Icons.person_outline),
            _buildMobileNavItem(
                context, 'Projects', 'projects', Icons.code_outlined),
            _buildMobileNavItem(context, 'Photography', 'photography',
                Icons.camera_alt_outlined),
            _buildMobileNavItem(
                context, 'Videos', 'videos', Icons.play_circle_outline),
            _buildMobileCVButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(
      BuildContext context, String label, String section, IconData icon) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: SamsungOneUITheme.spacingXS),
      child: TextButton.icon(
        onPressed: () {
          onNavigate(section);
          onClose();
        },
        icon: Icon(icon, color: SamsungOneUITheme.primaryBlue),
        label: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        style: TextButton.styleFrom(
          foregroundColor: SamsungOneUITheme.primaryBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: SamsungOneUITheme.spacingM,
            vertical: SamsungOneUITheme.spacingM,
          ),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileCVButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: SamsungOneUITheme.spacingXS),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SamsungOneUITheme.primaryGreen,
            SamsungOneUITheme.primaryGreen.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
        boxShadow: [
          BoxShadow(
            color: SamsungOneUITheme.primaryGreen.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            const url = 'assets/pdf/MISTULA_CV.pdf';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
            }
          },
          borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SamsungOneUITheme.spacingM,
              vertical: SamsungOneUITheme.spacingM,
            ),
            child: Row(
              children: [
                Icon(Icons.download_outlined, color: Colors.white),
                SizedBox(width: SamsungOneUITheme.spacingM),
                Text(
                  'Download CV',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
