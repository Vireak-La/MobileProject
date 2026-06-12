import 'package:flutter/material.dart';
import '../../components/cyber_drawer.dart';
import '../../theme/app_colors.dart';
import '../booking/booking_screen.dart';
import '../booking/repair_tracker_screen.dart';
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
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _showingBooking = false;
                });
              },
            ),
            title: const Text('INTAKE WIZARD'),
          ),
          body: BookingScreen(
            onBookingComplete: (ticketNumber) {
              _navigateToTracker(ticketNumber);
            },
          ),
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
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _showingChat = false;
                });
              },
            ),
            title: const Text('SUPPORT CHAT'),
          ),
          body: const ChatScreen(),
        ),
      );
    }

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RepairTrackerScreen(
                      initialTicketNumber: _trackerTicketCode,
                    ),
                  ),
                );
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
