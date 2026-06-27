import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Global Architectural Resources
import 'state/app_state.dart';
import 'theme/app_theme.dart';
import 'theme/app_colors.dart';
import 'components/cyber_drawer.dart';

// Authentication Feature Components
import 'features/auth/start_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/auth/verify_email_screen.dart';
import 'features/auth/forget_password_screen.dart';
import 'features/auth/new_password_screen.dart';

// Dashboard / Core Business Modules
import 'features/home/home_stub.dart';
import 'features/pc_builder/pc_builder_stub.dart';
import 'features/pc_builder/product_page.dart';
import 'features/gallery/gallery_screen.dart';

// Sub pages & flows
import 'features/home/product_detail.dart';
import 'features/home/search_screen.dart';
import 'features/home/compare_page.dart';
import 'features/home/about_us_page.dart';
import 'features/home/help_support_page.dart';
import 'features/home/deals_sales_page.dart';
import 'features/home/community_page.dart';
import 'features/home/saved_builds_page.dart';

import 'features/checkout/cart.dart';
import 'features/checkout/checkout.dart';
import 'features/checkout/order_success_page.dart';
import 'features/checkout/checkout_models.dart';

import 'features/services/service_screen.dart';
import 'features/booking/booking_screen.dart';
import 'features/booking/repair_tracker_screen.dart';
import 'features/chat/chat_screen.dart';
import 'features/map/map_screen.dart';

import 'features/user/profile_page.dart';
import 'features/user/edit_profile_page.dart';
import 'features/user/order_history_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CyberRigStartPage(),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const CyberRigLoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const CyberRigRegisterPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: '/verify-email',
      builder: (context, state) {
        final isRegister = state.extra as bool? ?? false;
        return CyberRigVerifyEmailPage(isRegister: isRegister);
      },
    ),
    GoRoute(
      path: '/forget-password',
      builder: (context, state) => const CyberRigForgetPasswordPage(),
    ),
    GoRoute(
      path: '/new-password',
      builder: (context, state) => const CyberRigNewPasswordPage(),
    ),
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const MainAppShell(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/cart',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const CartScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOutCubic)),
          ),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: '/checkout',
      pageBuilder: (context, state) {
        final items = state.extra as List<CheckoutCartItem>;
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: CheckoutScreen(items: items),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation.drive(
              Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOutCubic)),
            ),
            child: child,
          ),
        );
      },
    ),
    GoRoute(
      path: '/order-success',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: OrderSuccessScreen(
            orderNumber: extra['orderNumber'] as String,
            items: extra['items'] as List<CheckoutCartItem>,
            total: extra['total'] as double,
            paymentMethod: extra['paymentMethod'] as String,
            name: extra['name'] as String,
            address: extra['address'] as String,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      },
    ),
    GoRoute(
      path: '/product-detail',
      pageBuilder: (context, state) {
        final product = state.extra as Map<String, dynamic>?;
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: ProductDetailScreen(product: product),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation.drive(
              Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOutCubic)),
            ),
            child: child,
          ),
        );
      },
    ),
    GoRoute(
      path: '/search',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const SearchScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: '/compare',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const ComparePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOutCubic)),
          ),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: '/saved-builds',
      builder: (context, state) => const SavedBuildsPage(),
    ),
    GoRoute(
      path: '/services',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const ServiceScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOutCubic)),
          ),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: '/booking',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const BookingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOutCubic)),
          ),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: '/repair-tracker',
      pageBuilder: (context, state) {
        final ticket = state.extra as String?;
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: RepairTrackerScreen(initialTicketNumber: ticket),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation.drive(
              Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOutCubic)),
            ),
            child: child,
          ),
        );
      },
    ),
    GoRoute(
      path: '/chat',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const ChatScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOutCubic)),
          ),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: '/deals-sales',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const DealsSalesPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOutCubic)),
          ),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: '/community',
      builder: (context, state) => const CommunityPage(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => const MapScreen(),
    ),
    GoRoute(
      path: '/about-us',
      builder: (context, state) => const AboutUsPage(),
    ),
    GoRoute(
      path: '/help-support',
      builder: (context, state) => const HelpSupportPage(),
    ),
    GoRoute(
      path: '/edit-profile',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const EditProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOutCubic)),
          ),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: '/order-history',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const OrderHistoryScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOutCubic)),
          ),
          child: child,
        ),
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStateNotifier(),
      child: MaterialApp.router(
        title: 'Cyber-Rig Pro - Computer Shop',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
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
  int _getSelectedIndex(AppScreen screen) {
    switch (screen) {
      case AppScreen.home:
        return 0;
      case AppScreen.pcBuilder:
        return 1;
      case AppScreen.shop:
        return 2;
      case AppScreen.gallery:
        return 3;
      case AppScreen.profile:
        return 4;
      default:
        return 0;
    }
  }

  Widget _getActiveScreen(int index) {
    switch (index) {
      case 0:
        return const HomeStubScreen(); 
      case 1:
        return const PcBuilderStubScreen();
      case 2:
        return const ProductPage();
      case 3:
        return const GalleryScreen();
      case 4:
        return const ProfilePage();
      default:
        return const HomeStubScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateNotifier>(context);
    final selectedIndex = _getSelectedIndex(appState.currentScreen);

    return Scaffold(
      drawer: const CyberDrawer(),
      body: _getActiveScreen(selectedIndex),
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
            currentIndex: selectedIndex,
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
              _buildNavItem(Icons.photo_library_outlined, Icons.photo_library, 'GALLERY'),
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