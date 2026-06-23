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
import 'features/pc_builder/product_page.dart';
import 'features/map/map_screen.dart';
import 'features/gallery/gallery_screen.dart';
import 'features/home/product_detail.dart';
import 'features/services/service_screen.dart';
import 'features/chat/chat_screen.dart';
import 'features/checkout/cart.dart';
import 'features/home/compare_page.dart';
import 'features/home/about_us_page.dart';
import 'features/home/help_support_page.dart';

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
  Widget _getActiveScreen(AppScreen screen) {
    switch (screen) {
      case AppScreen.home:
        return const HomeStubScreen(); 
      case AppScreen.pcBuilder:
        return const PcBuilderStubScreen();
      case AppScreen.shop:
        return const ProductPage();
      case AppScreen.gallery:
        return const GalleryScreen();
      case AppScreen.profile:
        return const MapScreen();
      case AppScreen.compare:
        return const ComparePage();
      case AppScreen.cart:
        return const CartScreen();
      case AppScreen.services:
        return const ServiceScreen();
      case AppScreen.chat:
        return const ChatScreen();
      case AppScreen.aboutUs:
        return const AboutUsPage();
      case AppScreen.helpSupport:
        return const HelpSupportPage();
    }
  }

  int _getBottomNavIndex(AppScreen screen) {
    switch (screen) {
      case AppScreen.home:
      case AppScreen.aboutUs:
      case AppScreen.helpSupport:
        return 0;
      case AppScreen.pcBuilder:
        return 1;
      case AppScreen.shop:
      case AppScreen.compare:
      case AppScreen.cart:
        return 2;
      case AppScreen.gallery:
        return 3;
      case AppScreen.profile:
      case AppScreen.services:
      case AppScreen.chat:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateNotifier>(context);
    return PopScope(
      canPop: appState.historyLength <= 1,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        appState.goBack();
      },
      child: Scaffold(
        body: _getActiveScreen(appState.currentScreen),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            border: Border(
              top: BorderSide(color: Color(0xFF1E2B40), width: 1.5),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: BottomNavigationBar(
              currentIndex: _getBottomNavIndex(appState.currentScreen),
              onTap: (index) {
                switch (index) {
                  case 0:
                    appState.setScreen(AppScreen.home);
                    break;
                  case 1:
                    appState.setScreen(AppScreen.pcBuilder);
                    break;
                  case 2:
                    appState.setScreen(AppScreen.shop);
                    break;
                  case 3:
                    appState.setScreen(AppScreen.gallery);
                    break;
                  case 4:
                    appState.setScreen(AppScreen.profile);
                    break;
                }
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