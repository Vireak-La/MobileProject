import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileproject/features/user/EditProfilePage.dart';
import 'package:mobileproject/features/user/order_history_page.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart'; // Adjust path to your app_state.dart

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Listen to state changes
    final appState = Provider.of<AppStateNotifier>(context);
    final user = appState.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("CYBER-RIG PRO", style: TextStyle(color: Colors.cyanAccent, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(user),
          const SizedBox(height: 30),
          _buildSection("ACCOUNT", [
            _buildListTile(Icons.person_outline, "Edit Profile", () {
              // Navigate to Edit Profile
              Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage()));
            }),
            _buildListTile(Icons.lock_outline, "Security/Password", () {}),
          ]),
          _buildSection("PURCHASES", [
            _buildListTile(Icons.history, "Order History", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderHistoryScreen()));
            }),
          ]),
          _buildSection("SYSTEM", [
            _buildToggleTile(Icons.notifications_none, "Notifications", appState.notificationsEnabled, (val) {
              appState.toggleNotifications(val);
            }),
          ]),
          _buildSection("SUPPORT", [
            _buildListTile(Icons.logout, "Log Out", () {
              appState.logout();
              context.go('/login');
            }, isLogout: true),
          ]),
        ],
      ),
    );
  }

  // --- Helper Methods ---
  Widget _buildHeader(User? user) {
    return Column(children: [
      CircleAvatar(
        radius: 50,
        // Use MemoryImage for Uint8List, fallback to Asset for default
        backgroundImage: user?.profileImageBytes != null 
            ? MemoryImage(user!.profileImageBytes!) 
            : const AssetImage('images/profile.png') as ImageProvider,
      ),
      const SizedBox(height: 15),
      Text(user?.name ?? "Guest", 
           style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _buildSection(String title, List<Widget> children) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(color: Colors.cyanAccent, letterSpacing: 1.5, fontSize: 12, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Material(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), child: Column(children: children)),
      const SizedBox(height: 24),
    ],
  );

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) => ListTile(
    leading: Icon(icon, color: isLogout ? Colors.redAccent : Colors.white70),
    title: Text(title, style: TextStyle(color: isLogout ? Colors.redAccent : Colors.white)),
    trailing: isLogout ? null : const Icon(Icons.chevron_right, color: Colors.white70),
    onTap: onTap,
  );

  Widget _buildToggleTile(IconData icon, String title, bool value, Function(bool) onChanged) => ListTile(
    leading: Icon(icon, color: Colors.white70),
    title: Text(title, style: const TextStyle(color: Colors.white)),
    trailing: Switch(value: value, onChanged: onChanged, activeColor: Colors.cyanAccent),
  );
}