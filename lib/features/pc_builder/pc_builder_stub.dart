import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class PcBuilderStubScreen extends StatefulWidget {
  const PcBuilderStubScreen({super.key});

  @override
  State<PcBuilderStubScreen> createState() => _PcBuilderStubScreenState();
}

class _PcBuilderStubScreenState extends State<PcBuilderStubScreen> {
  int totalCost = 1450;
  String currentCpu = 'AMD Ryzen 7 7800X3D';
  String currentGpu = 'NVIDIA RTX 4070 Ti Super';
  bool isCompatible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CUSTOM RIG BUILDER'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Price and Compatibility Badge
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.neonCyan),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ESTIMATED BUILD PRICE',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$$totalCost.00',
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.neonCyan,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isCompatible ? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: isCompatible ? Colors.green : Colors.red),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isCompatible ? Icons.check_circle_outline : Icons.error_outline,
                          color: isCompatible ? Colors.green : Colors.red,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isCompatible ? 'COMPATIBLE' : 'INCOMPATIBLE',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isCompatible ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Build stages checklist
            const Text(
              'CONFIGURATION WIZARD',
              style: TextStyle(
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                color: AppColors.neonMagenta,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            _buildComponentRow('Processor (CPU)', currentCpu, '\$380', true),
            _buildComponentRow('Graphics Card (GPU)', currentGpu, '\$790', true),
            _buildComponentRow('Motherboard (MB)', 'MSI MAG B650 Tomahawk', '\$190', true),
            _buildComponentRow('System Memory (RAM)', 'G.Skill Trident Z5 32GB DDR5', '\$90', true),
            _buildComponentRow('Storage SSD', 'Samsung 990 Pro 2TB NVMe', '\$140', true),
            _buildComponentRow('Power Supply (PSU)', 'Awaiting selection...', '\$0', false),
            _buildComponentRow('PC Chassis (Case)', 'Awaiting selection...', '\$0', false),

            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.surfaceElevated,
              ),
              onPressed: () {},
              child: const Text('CHECK COMPATIBILITY RULES'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentRow(String title, String name, String price, bool isSelected) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          isSelected ? Icons.check_circle : Icons.circle_outlined,
          color: isSelected ? AppColors.neonCyan : AppColors.textMuted,
        ),
        title: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 10,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : AppColors.textMuted,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Text(
          price,
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.neonGreen,
          ),
        ),
      ),
    );
  }
}
