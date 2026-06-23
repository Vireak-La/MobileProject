import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';
import '../../state/app_state.dart';

class SavedBuildsPage extends StatelessWidget {
  const SavedBuildsPage({super.key});

  void _addRigToCart(BuildContext context, SavedBuild build) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF0F1622),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.neonMagenta, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.shopping_cart_checkout, color: AppColors.neonMagenta),
                SizedBox(width: 10),
                Text(
                  'CART ENTRY SUCCESSFUL',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontWeight: FontWeight.bold,
                    color: AppColors.neonMagenta,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Added ${build.components.length} components from "${build.name}" to shopping cart database.',
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  void _loadInBuilder(BuildContext context, SavedBuild build) {
    Provider.of<AppStateNotifier>(context, listen: false).loadBuildIntoBuilder(build.components);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF0F1622),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.neonCyan, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        content: Text(
          'LOADED: "${build.name}" IMPORTED INTO ACTIVE BUILDER BUFFER',
          style: const TextStyle(fontFamily: 'Courier', color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateNotifier>(context);
    final builds = appState.savedBuilds;
    final DateFormat formatter = DateFormat('MM/dd/yyyy');

    return Scaffold(
      backgroundColor: const Color(0xFF05080D),
      drawer: const CyberDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SAVED RIGS ARCHIVE',
          style: TextStyle(
            fontFamily: 'Courier',
            letterSpacing: 1.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: builds.isEmpty
            ? _buildEmptyState(context, appState)
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                itemCount: builds.length,
                itemBuilder: (context, index) {
                  final build = builds[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1114),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.neonCyan.withOpacity(0.4),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Header
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  build.name,
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.neonCyan,
                                    fontSize: 14,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                onPressed: () {
                                  appState.deleteSavedBuild(build.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: const Color(0xFF0F1622),
                                      content: Text(
                                        'SYSTEM DELETED: ${build.name} PURGED FROM STORAGE',
                                        style: const TextStyle(fontFamily: 'Courier', fontSize: 10),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        // Subtitle date + total price
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'REGISTERED: ${formatter.format(build.date)}',
                                style: const TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 10,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              Text(
                                '\$${build.totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.neonGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: Color(0xFF1E2B40), height: 1),

                        // Specs listing
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SPECIFICATION DATABANK:',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildSpecRow('CPU', build.components['CPU']),
                              _buildSpecRow('GPU', build.components['GPU']),
                              _buildSpecRow('RAM', build.components['RAM']),
                              _buildSpecRow('MOBO', build.components['Motherboard']),
                              _buildSpecRow('DISK', build.components['Storage']),
                              _buildSpecRow('PSU', build.components['PSU']),
                              _buildSpecRow('CASE', build.components['Case']),
                            ],
                          ),
                        ),
                        const Divider(color: Color(0xFF1E2B40), height: 1),

                        // Bottom Actions
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: AppColors.neonCyan,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: AppColors.neonCyan, width: 1.2),
                                  ),
                                ).button(
                                  onPressed: () => _loadInBuilder(context, build),
                                  child: const Text(
                                    'LOAD IN BUILDER',
                                    style: TextStyle(
                                      fontFamily: 'Courier',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.neonMagenta.withOpacity(0.15),
                                    foregroundColor: AppColors.neonMagenta,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(color: AppColors.neonMagenta, width: 1.2),
                                    ),
                                  ),
                                  onPressed: () => _addRigToCart(context, build),
                                  child: const Text(
                                    'ADD RIG TO CART',
                                    style: TextStyle(
                                      fontFamily: 'Courier',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String? value) {
    final displayValue = value ?? 'Not selected';
    final hasValue = displayValue != 'Awaiting selection...' && displayValue != 'Not selected';
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              displayValue,
              style: TextStyle(
                fontSize: 11,
                color: hasValue ? Colors.white : AppColors.textMuted,
                fontWeight: hasValue ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppStateNotifier appState) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.bookmark_outline,
              size: 64,
              color: AppColors.neonMagenta,
            ),
            const SizedBox(height: 16),
            const Text(
              'SAVED ARCHIVES INACTIVE',
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'No custom gaming configurations registered in quantum memory blocks. Create your custom system in the builder.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonMagenta,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                appState.setScreen(AppScreen.pcBuilder);
              },
              child: const Text(
                'LAUNCH PC BUILDER',
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Extension to support styleFrom configuration clean compilation
extension on ButtonStyle {
  Widget button({required VoidCallback onPressed, required Widget child}) {
    return ElevatedButton(
      style: this,
      onPressed: onPressed,
      child: child,
    );
  }
}
