import 'package:flutter/material.dart';
import '../constants/samsung_one_ui_theme.dart';

class SamsungProjectsSection extends StatefulWidget {
  const SamsungProjectsSection({super.key});

  @override
  State<SamsungProjectsSection> createState() => _SamsungProjectsSectionState();
}

class _SamsungProjectsSectionState extends State<SamsungProjectsSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    final projects = [
      {
        'title': 'ESP32/Arduino Sensors',
        'description': 'Real-time sensors for temperature, humidity, pressure, and altitude monitoring',
        'icon': Icons.sensors_outlined,
        'color': SamsungOneUITheme.primaryBlue,
        'category': 'IoT & Hardware',
        'tech': ['ESP32', 'Arduino', 'C++', 'IoT'],
      },
      {
        'title': 'Raspberry Pi Automation',
        'description': 'Orange Pi automation and monitoring systems for smart environments',
        'icon': Icons.smart_toy_outlined,
        'color': SamsungOneUITheme.primaryGreen,
        'category': 'Automation',
        'tech': ['Raspberry Pi', 'Python', 'Linux', 'Automation'],
      },
      {
        'title': 'Smart Glasses',
        'description': 'AI-powered smart glasses with YOLO, Vosk, eSpeak, and Tinallmaa AI integration',
        'icon': Icons.visibility_outlined,
        'color': const Color(0xFF9C27B0),
        'category': 'AI & Wearables',
        'tech': ['AI', 'YOLO', 'Python', 'Computer Vision'],
      },
      {
        'title': 'Personal Storage Server',
        'description': 'Self-hosted storage server for personal data management and backup',
        'icon': Icons.storage_outlined,
        'color': const Color(0xFFFF9800),
        'category': 'Infrastructure',
        'tech': ['Linux', 'Docker', 'Networking', 'Storage'],
      },
      {
        'title': 'Photoshoot Website',
        'description': 'Website with templates and camera integration for photography services',
        'icon': Icons.camera_alt_outlined,
        'color': const Color(0xFFE91E63),
        'category': 'Web Development',
        'tech': ['Flutter', 'Web', 'Photography', 'UI/UX'],
      },
      {
        'title': 'Circuit Design',
        'description': 'LTspice circuits, RC filters, and PCB design via UV printing',
        'icon': Icons.electrical_services_outlined,
        'color': const Color(0xFF607D8B),
        'category': 'Electronics',
        'tech': ['LTspice', 'PCB Design', 'Electronics', 'Hardware'],
      },
    ];
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? SamsungOneUITheme.spacingL : SamsungOneUITheme.spacingXXL,
        vertical: SamsungOneUITheme.spacingXXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header with Dynamic Design
          Container(
            padding: EdgeInsets.all(SamsungOneUITheme.spacingXL),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  SamsungOneUITheme.primaryGreen.withOpacity(0.1),
                  SamsungOneUITheme.primaryGreen.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusXL),
              border: Border.all(
                color: SamsungOneUITheme.primaryGreen.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(SamsungOneUITheme.spacingM),
                      decoration: BoxDecoration(
                        color: SamsungOneUITheme.primaryGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                      ),
                      child: Icon(
                        Icons.code_outlined,
                        color: SamsungOneUITheme.primaryGreen,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: SamsungOneUITheme.spacingL),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Projects & Technical Work',
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: SamsungOneUITheme.primaryGreen,
                            ),
                          ),
                          SizedBox(height: SamsungOneUITheme.spacingS),
                          Text(
                            'Explore my technical projects spanning IoT, AI, web development, and hardware design',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: SamsungOneUITheme.spacingXXL),
          
          // Projects Dropdown - Compact Design
          Container(
            decoration: BoxDecoration(
              color: SamsungOneUITheme.primaryGreen.withOpacity(0.05),
              borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
              border: Border.all(
                color: SamsungOneUITheme.primaryGreen.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Dropdown Header
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusL),
                    child: Padding(
                      padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
                      child: Row(
                        children: [
                          Icon(
                            Icons.code_outlined,
                            color: SamsungOneUITheme.primaryGreen,
                            size: 24,
                          ),
                          SizedBox(width: SamsungOneUITheme.spacingM),
                          Expanded(
                            child: Text(
                              'Technical Projects (${projects.length})',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: SamsungOneUITheme.primaryGreen,
                              ),
                            ),
                          ),
                          Icon(
                            _isExpanded ? Icons.expand_less : Icons.expand_more,
                            color: SamsungOneUITheme.primaryGreen,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Dropdown Content
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _isExpanded ? null : 0,
                  child: _isExpanded
                      ? Column(
                          children: [
                            Divider(
                              color: SamsungOneUITheme.primaryGreen.withOpacity(0.2),
                              height: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.all(SamsungOneUITheme.spacingL),
                              child: Column(
                                children: projects.map((project) {
                                  return _buildCompactProjectItem(context, project);
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactProjectItem(BuildContext context, Map<String, dynamic> project) {
    final techStack = project['tech'] as List<String>;
    
    return Container(
      margin: EdgeInsets.only(bottom: SamsungOneUITheme.spacingS),
      padding: EdgeInsets.symmetric(
        horizontal: SamsungOneUITheme.spacingM,
        vertical: SamsungOneUITheme.spacingS,
      ),
      decoration: BoxDecoration(
        color: (project['color'] as Color).withOpacity(0.02),
        borderRadius: BorderRadius.circular(SamsungOneUITheme.radiusS),
        border: Border.all(
          color: (project['color'] as Color).withOpacity(0.08),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Icon(
            project['icon'] as IconData,
            color: project['color'] as Color,
            size: 16,
          ),
          
          SizedBox(width: SamsungOneUITheme.spacingS),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      project['title'] as String,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: SamsungOneUITheme.spacingXS),
                    Text(
                      '• ${project['category']}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: (project['color'] as Color),
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  project['description'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  techStack.take(3).join(' • '),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: (project['color'] as Color).withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}