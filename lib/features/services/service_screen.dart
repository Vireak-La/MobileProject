import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/cyber_drawer.dart';
import '../../theme/app_colors.dart';
import '../../state/app_state.dart';
import '../booking/booking_screen.dart';
import '../chat/chat_screen.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String? _trackerTicketCode;
  bool _showingChat = false;
  bool _showingBooking = false;

  void _navigateToTracker(String ticketCode) {
    setState(() {
      _trackerTicketCode = ticketCode;
      _showingBooking = false; 
      _showingChat = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showingBooking) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          setState(() {
            _showingBooking = false;
          });
        },
        child: BookingScreen(
          onBack: () {
            setState(() {
              _showingBooking = false;
            });
          },
          onBookingComplete: (ticketNumber) {
            _navigateToTracker(ticketNumber);
          },
        ),
      );
    }

    if (_showingChat) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          setState(() {
            _showingChat = false;
          });
        },
        child: ChatScreen(
          onBack: () {
            setState(() {
              _showingChat = false;
            });
          },
        ),
      );
    }

    final appState = Provider.of<AppStateNotifier>(context);
    final tickets = appState.tickets;

    return Scaffold(
      drawer: const CyberDrawer(),
      appBar: AppBar(
        title: const Text('SERVICE HUBS'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SELECT A DIAGNOSTICS DEPT',
              style: TextStyle(
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                color: AppColors.neonCyan,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            _buildHubOptionCard(
              title: 'BOOK A REPAIR / INTAKE WIZARD',
              description: 'Thermal cleanup, RAM upgrades, GPU failures. Generate diagnostics ticket.',
              icon: Icons.assignment_outlined,
              color: AppColors.neonCyan,
              actionText: 'START INTAKE FORM',
              onTap: () {
                setState(() {
                  _showingBooking = true;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildHubOptionCard(
              title: 'TRACK CURRENT SERVICE TICKETS',
              description: 'Enter your 6-digit order tag code to track thermal states and pickup times.',
              icon: Icons.timeline,
              color: AppColors.neonMagenta,
              actionText: 'OPEN TRACKER PAGE',
              onTap: () {
                context.push('/repair-tracker', extra: _trackerTicketCode);
              },
            ),
            const SizedBox(height: 16),
            _buildHubOptionCard(
              title: 'CYBER FAQ & TECHNICAL HELP',
              description: 'Instant automated replies on component compatibilities and opening hours.',
              icon: Icons.chat_bubble_outline,
              color: AppColors.neonGreen,
              actionText: 'CONNECT TO SUPPORT',
              onTap: () {
                setState(() {
                  _showingChat = true;
                });
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'ACTIVE DIAGNOSTIC NODES',
              style: TextStyle(
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                color: AppColors.neonMagenta,
                fontSize: 14,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            if (tickets.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF1E2B40)),
                ),
                child: const Center(
                  child: Text(
                    'NO ACTIVE TRACKING NODES RECORDED',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tickets.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  return Card(
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      onTap: () {
                        context.push('/repair-tracker', extra: ticket.ticketNumber);
                      },
                      leading: CircleAvatar(
                        backgroundColor: AppColors.neonMagenta.withOpacity(0.12),
                        child: const Icon(Icons.terminal, color: AppColors.neonMagenta, size: 18),
                      ),
                      title: Text(
                        '${ticket.ticketNumber} // ${ticket.deviceName.toUpperCase()}',
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'STATUS: ${ticket.status.toUpperCase()}',
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 10,
                          color: AppColors.neonCyan,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHubOptionCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 44),
                side: BorderSide(color: color, width: 1),
                foregroundColor: color,
              ),
              onPressed: onTap,
              child: Text(
                actionText,
                style: const TextStyle(fontFamily: 'Courier', fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
