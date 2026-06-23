import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final teamMembers = [
      {
        'name': 'La Vireak',
        'role': 'LEAD ARCHITECT',
        'avatar': 'LV',
        'color': AppColors.neonCyan,
        'bio': 'System Architecture, Routing, Navigation Engines & State Integration.',
      },
      {
        'name': 'Leong Pheaktra',
        'role': 'UI/UX LEAD',
        'avatar': 'LP',
        'color': AppColors.neonMagenta,
        'bio': 'Design Systems, Cyberpunk Themes, Responsive Layouts & Animations.',
      },
      {
        'name': 'Im Chheangngim',
        'role': 'LOGLOG & DATA LEAD',
        'avatar': 'IC',
        'color': AppColors.neonGreen,
        'bio': 'Data Repositories, Checkout Systems, Interactive Wizards & Diagnostics.',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF05080D),
      drawer: const CyberDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'ABOUT THE MATRIX',
          style: TextStyle(
            fontFamily: 'Courier',
            letterSpacing: 1.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop/Rig Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1114),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E2B40)),
                  gradient: LinearGradient(
                    colors: [const Color(0xFF0C1114), AppColors.surfaceCard.withOpacity(0.4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.neonCyan,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'RGB NEXUS PROJECT',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            color: AppColors.neonCyan,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'DOMINANCE BY DESIGN',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'RGB Nexus is an elite hardware portal. Engineered for enthusiast gamers, streamers, and deep-learning engineers. Sourcing premium PC parts, compatibility checkers, and intake repair tracking.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Team Header
              Row(
                children: [
                  Transform.rotate(
                    angle: 0.785,
                    child: Container(width: 10, height: 10, color: AppColors.neonMagenta),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'DEVELOPMENT CORE TEAM',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: 1.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Team Profiles Grid/List
              ...teamMembers.map((member) {
                final Color accentColor = member['color'] as Color;
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1114),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF1B2328)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Glow Avatar
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: accentColor, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            member['avatar'] as String,
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: accentColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Profile Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  member['name'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: accentColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: accentColor.withOpacity(0.3)),
                                  ),
                                  child: Text(
                                    member['role'] as String,
                                    style: TextStyle(
                                      fontFamily: 'Courier',
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: accentColor,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              member['bio'] as String,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),

              // System Version / Footer
              Center(
                child: Column(
                  children: [
                    const Text(
                      'SYSTEM_NODE: RGB_NEXUS_ALPHA',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 10,
                        color: AppColors.textMuted,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.neonGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'VERSION 3.5.0-VIREAK_BRANCH',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 10,
                            color: AppColors.neonGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
