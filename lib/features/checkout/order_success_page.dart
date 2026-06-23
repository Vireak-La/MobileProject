import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'checkout_models.dart';
import '../../theme/app_colors.dart';
import '../../state/app_state.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({
    super.key,
    required this.orderNumber,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.name,
    required this.address,
  });

  final String orderNumber;
  final List<CheckoutCartItem> items;
  final double total;
  final String paymentMethod;
  final String name;
  final String address;

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final appState = Provider.of<AppStateNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'SECURE_NODE // SECURED',
          style: TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        automaticallyImplyLeading: false, // Prevent backing into checkout
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Glowing Cyber Shield/Check Icon
            AnimatedBuilder(
              animation: _glowAnimation,
              builder: (context, child) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surface,
                      border: Border.all(
                        color: AppColors.neonGreen.withOpacity(0.3 * _glowAnimation.value),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonGreen.withOpacity(0.25 * _glowAnimation.value),
                          blurRadius: 20.0 * _glowAnimation.value,
                          spreadRadius: 2.0 * _glowAnimation.value,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.gpp_good_outlined,
                      size: 64,
                      color: AppColors.neonGreen.withOpacity(0.9),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'ORDER CONFIRMED',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.neonGreen,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'TRANSACTION HASH: ${widget.orderNumber.hashCode.toRadixString(16).toUpperCase()}',
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 24),

            // Terminal style invoice printout
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.neonCyan.withOpacity(0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonCyan.withOpacity(0.08),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Terminal Header
                    Container(
                      color: const Color(0xFF0F1622),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.redAccent,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amberAccent,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.neonGreen,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'nexus_invoice.sys',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontFamily: 'Courier',
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Terminal Content
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '// === RGB NEXUS DIGITAL INVOICE ===',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              color: AppColors.neonCyan,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildTerminalRow('ORDER ID:', widget.orderNumber),
                          _buildTerminalRow('DATE:', formattedDate),
                          _buildTerminalRow('PAYMENT:', widget.paymentMethod.toUpperCase()),
                          _buildTerminalRow('CLIENT:', widget.name.toUpperCase()),
                          _buildTerminalRow('DEST:', widget.address.toUpperCase()),
                          const SizedBox(height: 10),
                          const Text(
                            '----------------------------------',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              color: AppColors.textMuted,
                            ),
                          ),
                          const Text(
                            'ITEMS SECURED:',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              color: AppColors.neonMagenta,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...widget.items.map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '• ${item.name}',
                                      style: const TextStyle(
                                        fontFamily: 'Courier',
                                        color: AppColors.textPrimary,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '  Qty ${item.quantity} x ${moneyFormat.format(item.price)}',
                                          style: const TextStyle(
                                            fontFamily: 'Courier',
                                            color: AppColors.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          moneyFormat.format(item.lineTotal),
                                          style: const TextStyle(
                                            fontFamily: 'Courier',
                                            color: AppColors.neonGreen,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                          const Text(
                            '----------------------------------',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              color: AppColors.textMuted,
                            ),
                          ),
                          _buildTerminalRow('TOTAL CHARGED:', moneyFormat.format(widget.total), isHighlight: true),
                          const SizedBox(height: 8),
                          const Text(
                            '// STATUS: SECURELY PROCESSED //',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              color: AppColors.neonGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Dispatch Tracker Progress Checklist
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.surfaceElevated,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DISPATCH TRACKER',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.w900,
                      color: AppColors.neonMagenta,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTrackerStep(
                    label: 'TRANSACTION APPROVED',
                    desc: 'Hash signature validated successfully.',
                    isDone: true,
                    isCurrent: false,
                  ),
                  _buildTrackerStep(
                    label: 'RIG ASSEMBLY & BURN-IN TEST',
                    desc: 'Expert technician setup & thermal validation.',
                    isDone: false,
                    isCurrent: true,
                  ),
                  _buildTrackerStep(
                    label: 'INVENTORY DISPATCHED',
                    desc: 'Handed over to high-speed secure courier.',
                    isDone: false,
                    isCurrent: false,
                  ),
                  _buildTrackerStep(
                    label: 'DELIVERED TO SHIELD BUFFER',
                    desc: 'Stored in safe locker at destination.',
                    isDone: false,
                    isCurrent: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Navigation Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.neonCyan, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      appState.setScreen(AppScreen.home);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'CONTINUE SHOPPING',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        color: AppColors.neonCyan,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonMagenta,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      appState.setScreen(AppScreen.chat);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'CONNECT TO SUPPORT',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTerminalRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.padRight(15),
            style: const TextStyle(
              fontFamily: 'Courier',
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Courier',
                color: isHighlight ? AppColors.neonCyan : AppColors.textPrimary,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerStep({
    required String label,
    required String desc,
    required bool isDone,
    required bool isCurrent,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone
                    ? AppColors.neonGreen.withOpacity(0.1)
                    : isCurrent
                        ? AppColors.neonCyan.withOpacity(0.1)
                        : Colors.transparent,
                border: Border.all(
                  color: isDone
                      ? AppColors.neonGreen
                      : isCurrent
                          ? AppColors.neonCyan
                          : AppColors.textMuted,
                  width: 2,
                ),
              ),
              child: Center(
                child: isDone
                    ? const Icon(Icons.check, size: 14, color: AppColors.neonGreen)
                    : isCurrent
                        ? Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.neonCyan,
                            ),
                          )
                        : null,
              ),
            ),
            // Vertical connector line
            Container(
              width: 2,
              height: 36,
              color: isDone ? AppColors.neonGreen.withOpacity(0.5) : AppColors.surfaceElevated,
            ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: isDone
                      ? AppColors.neonGreen
                      : isCurrent
                          ? AppColors.neonCyan
                          : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12,
                  color: isCurrent ? AppColors.textPrimary : AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
