import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/fonts.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          // Logo
          Container(
            width: 120,
            height: 60,
            margin: const EdgeInsets.only(bottom: 24),
            child: Image.asset(
              'assets/images/logoBlk.png',
              fit: BoxFit.contain,
            ),
          ),

          // Contact buttons
          _contactButtons(context),

          const SizedBox(height: 32),

          // Copyright
          Text(
            '© 2024 Shaun Mistula. All rights reserved.',
            style: TextStyle(
              fontFamily: AppFonts.samsungOne,
              fontWeight: AppFonts.medium,
              fontSize: 12,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactButtons(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _contactButton('Email', Icons.email, const Color(0xFF2E7D32), () {
          _open('mailto:shaunmistula@gmail.com');
        }),
        _contactButton(
            'Instagram', Icons.camera_alt_outlined, const Color(0xFFE4405F),
            () {
          _open('https://www.instagram.com/shaun_mistula/');
        }),
        _contactButton('TikTok', Icons.music_note, Colors.white, () {
          _open(
              'https://www.tiktok.com/@swswswsw0?is_from_webapp=1&sender_device=pc');
        }),
        _contactButton('Facebook', Icons.facebook, const Color(0xFF1877F2), () {
          _open('https://www.facebook.com/SPAM.00l');
        }),
        _contactButton('YouTube', Icons.play_circle, const Color(0xFFFF0000),
            () {
          _open(
              'https://www.youtube.com/playlist?list=PLI8aViuBHNe0axG8uxk6-9A8DFABpHF6E');
        }),
      ],
    );
  }

  Widget _contactButton(
      String text, IconData icon, Color color, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppFonts.samsungSharp,
                  fontWeight: AppFonts.medium,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
