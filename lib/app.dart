import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Authentication Feature Components
import 'package:mobileproject/features/auth/start_screen.dart';
import 'package:mobileproject/features/auth/login_screen.dart';
import 'package:mobileproject/features/auth/register_screen.dart';
import 'package:mobileproject/features/auth/verify_email_screen.dart';
import 'package:mobileproject/features/auth/forget_password_screen.dart';
import 'package:mobileproject/features/auth/new_password_screen.dart';

// Dashboard / Core Business Modules
import 'features/home/home_stub.dart';
import 'features/pc_builder/pc_builder_stub.dart';
import 'features/map/map_screen.dart';
import 'features/gallery/gallery_screen.dart';
import 'features/home/product_detail.dart';

// Global Architectural Resources
import 'state/app_state.dart';
import 'theme/app_theme.dart';
import 'theme/app_colors.dart';
import 'components/cyber_drawer.dart';

void main() {
  runApp(const MyApp());
}

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
        initialRoute: AppRoutes.start,
        routes: AppRoutes.define(),
      ),
    );
  }
}

class AppRoutes {
  static const String start = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify-email';
  static const String forgetPassword = '/forget-password';
  static const String newPassword = '/new-password';
  static const String mainDashboard = '/dashboard';

  static Map<String, WidgetBuilder> define() {
    return {
      start: (context) => const CyberRigStartPage(),
      login: (context) => const CyberRigLoginPage(),
      register: (context) => const CyberRigRegisterPage(),
      verifyEmail: (context) => const CyberRigVerifyEmailPage(),
      forgetPassword: (context) => const CyberRigForgetPasswordPage(),
      newPassword: (context) => const CyberRigNewPasswordPage(),
      mainDashboard: (context) => const MainAppShell(), 
    };
  }
}

class MainAppShell extends StatefulWidget {
  const MainAppShell({super.key});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _currentIndex = 0;

  Widget _getActiveScreen() {
    switch (_currentIndex) {
      case 0:
        return const HomeStubScreen(); 
      case 1:
        return const PcBuilderStubScreen();
      case 2:
        return const ProductDetailScreen();
      case 3:
        return const GalleryScreen();
      case 4:
        return const MapScreen();
      default:
        return const HomeStubScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getActiveScreen(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          border: const Border(
            top: BorderSide(color: Color(0xFF1E2B40), width: 1.5),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF1E1E1E),
            elevation: 0,
            selectedItemColor: AppColors.neonCyan,
            unselectedItemColor: AppColors.textMuted,
            selectedLabelStyle: const TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
            items: [
              _buildNavItem(Icons.home_outlined, Icons.home, 'HOME'),
              _buildNavItem(Icons.memory_outlined, Icons.memory, 'BUILD'),
              _buildNavItem(Icons.shopping_cart_outlined, Icons.shopping_cart, 'SHOP'),
              _buildNavItem(Icons.photo_library_outlined, Icons.photo_library, 'Show Room'),
              _buildNavItem(Icons.person_outline, Icons.person, 'PROFILE'),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, IconData activeIcon, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4, top: 8),
        child: Icon(icon),
      ),
      activeIcon: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.neonCyan, width: 2)),
        ),
        padding: const EdgeInsets.only(top: 6, bottom: 4),
        child: Icon(activeIcon, color: AppColors.neonCyan),
      ),
      label: label,
    );
  }
}