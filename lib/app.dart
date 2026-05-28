import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';
import 'features/home/home_stub.dart';
import 'features/pc_builder/pc_builder_stub.dart';
import 'features/booking/booking_screen.dart';
import 'features/booking/repair_tracker_screen.dart';
import 'features/map/map_screen.dart';
import 'features/chat/chat_screen.dart';
import 'features/gallery/gallery_screen.dart';
import 'theme/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStateNotifier(),
      child: MaterialApp(
        title: 'RGB Nexus - Computer Shop',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const MainAppShell(),
      ),
    );
  }
}

class MainAppShell extends StatefulWidget {
  const MainAppShell({super.key});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _currentIndex = 0;
  String? _trackerTicketCode;

  // We handle nested views inside Services and Gallery tabs
  bool _showingChat = false;
  bool _showingBooking = false;

  void _navigateToTracker(String ticketCode) {
    setState(() {
      _trackerTicketCode = ticketCode;
      _currentIndex = 2; // Jump to Services tab
      _showingBooking = false; // Close booking wizard
      _showingChat = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of tab root views
    final List<Widget> rootScreens = [
      const HomeStubScreen(),
      const PcBuilderStubScreen(),
      // Services tab: contains choice between Tracker, Booking, and Chat
      _buildServicesTab(),
      const GalleryScreen(),
      const MapScreen(),
    ];

    return Scaffold(
      body: rootScreens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF1E2B40), width: 1.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              // Reset nested view flags on navigation tab changes
              if (index != 2) {
                _showingChat = false;
                _showingBooking = false;
              }
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.neonCyan,
          unselectedItemColor: AppColors.textMuted,
          selectedLabelStyle: const TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Courier', fontSize: 9),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home, color: AppColors.neonCyan),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build_circle_outlined),
              activeIcon: Icon(Icons.build_circle, color: AppColors.neonCyan),
              label: 'BUILDER',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings, color: AppColors.neonCyan),
              label: 'SERVICES',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_library_outlined),
              activeIcon: Icon(Icons.photo_library, color: AppColors.neonCyan),
              label: 'SHOWROOM',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              activeIcon: Icon(Icons.map, color: AppColors.neonCyan),
              label: 'LOCATIONS',
            ),
          ],
        ),
      ),
    );
  }

  // Nested Navigation flow for Services and Support Tab
  Widget _buildServicesTab() {
    if (_showingBooking) {
      return BookingScreen(
        onBookingComplete: (ticketNumber) {
          _navigateToTracker(ticketNumber);
        },
      );
    }

    if (_showingChat) {
      return WillPopScope(
        onWillPop: () async {
          setState(() {
            _showingChat = false;
          });
          return false;
        },
        child: Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => Scaffold(
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
          ),
        ),
      );
    }

    // Default Services hub selection dashboard
    return Scaffold(
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

            // 1. Repair intake booking wizard
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

            // 2. Status tracker (with dynamic prefill)
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

            // 3. Technical support chat
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
