import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';
import '../../data/mock_repository.dart';
import '../../state/app_state.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = MockRepository.getFaqs();
    final appState = Provider.of<AppStateNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF05080D),
      drawer: const CyberDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'HELP & SUPPORT',
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
              // FAQ Header
              Row(
                children: [
                  Transform.rotate(
                    angle: 0.785,
                    child: Container(width: 10, height: 10, color: AppColors.neonCyan),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'FREQUENTLY ASKED QUESTIONS',
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

              // FAQ List
              ...faqs.map((faq) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1114),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF1B2328)),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      iconColor: AppColors.neonCyan,
                      collapsedIconColor: AppColors.textMuted,
                      title: Text(
                        faq.question,
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(
                            faq.answer,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 28),

              // Support Channels Header
              Row(
                children: [
                  Transform.rotate(
                    angle: 0.785,
                    child: Container(width: 10, height: 10, color: AppColors.neonMagenta),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'DIRECT SUPPORT CHANNELS',
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

              // Quick Contact Options (Horizontal Actions)
              Row(
                children: [
                  // Live Chat Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        appState.setScreen(AppScreen.chat);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C1114),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.neonCyan.withOpacity(0.4), width: 1.5),
                        ),
                        child: Column(
                          children: const [
                            Icon(Icons.chat_bubble_outline, color: AppColors.neonCyan, size: 28),
                            SizedBox(height: 10),
                            Text(
                              'LIVE CHAT',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                                color: AppColors.neonCyan,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Instant AI assistant',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Book Repair Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        appState.setScreen(AppScreen.services);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C1114),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.neonMagenta.withOpacity(0.4), width: 1.5),
                        ),
                        child: Column(
                          children: const [
                            Icon(Icons.build_circle_outlined, color: AppColors.neonMagenta, size: 28),
                            SizedBox(height: 10),
                            Text(
                              'BOOK REPAIR',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                                color: AppColors.neonMagenta,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Diagnostics Intake',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Contact Info / Core details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1114),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF1B2328)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'RGB NEXUS CONTACT INDEX',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildContactItem(Icons.phone_outlined, 'SUPPORT HOTLINE', '+1 (555) 010-3337', AppColors.neonGreen),
                    _buildContactItem(Icons.email_outlined, 'SUPPORT EMAIL', 'support@rgbnexus.tech', AppColors.neonCyan),
                    _buildContactItem(Icons.access_time_outlined, 'OPERATING HOURS', 'Mon-Sun: 9:00 AM - 10:00 PM', AppColors.neonMagenta),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String val, Color highlight) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: highlight, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  val,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
