import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../theme/app_colors.dart';
import '../../state/app_state.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateNotifier>(context);
    final orders = appState.orderHistory;
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return Scaffold(
      backgroundColor: const Color(0xFF0C0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'ORDER_HISTORY',
          style: TextStyle(fontFamily: 'Courier', letterSpacing: 1.5, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.history, size: 64, color: AppColors.textMuted),
                  SizedBox(height: 16),
                  Text(
                    'NO PAST ORDERS FOUND',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                
                Color getStatusColor(String status) {
                  switch (status.toUpperCase()) {
                    case 'DELIVERED':
                      return AppColors.neonGreen;
                    case 'PROCESSING':
                      return AppColors.neonCyan;
                    default:
                      return Colors.orangeAccent;
                  }
                }

                return Card(
                  color: AppColors.surfaceCard,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: getStatusColor(order.status).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: ExpansionTile(
                    iconColor: AppColors.neonCyan,
                    collapsedIconColor: AppColors.textMuted,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.orderId,
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: getStatusColor(order.status).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: getStatusColor(order.status), width: 1),
                          ),
                          child: Text(
                            order.status,
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: getStatusColor(order.status),
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatter.format(order.date),
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Text(
                            '\$${order.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.neonGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: [
                      const Divider(color: Color(0xFF213146), height: 1),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ORDERED COMPONENTS:',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.neonCyan,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...order.items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${item.name} x${item.quantity}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$${item.lineTotal.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontFamily: 'Courier',
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
