import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'compare_page.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05080D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'CYBER-RIG PRO',
          style: TextStyle(fontFamily: 'Courier', letterSpacing: 1.6),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ComparePage())),
          ),
          const Padding(padding: EdgeInsets.only(right: 8), child: Icon(Icons.search)),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 96),
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 340,
                child: Image.asset(
                  'assets/images/gaming-computer-case-isolated-png.webp',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Title, price, rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('TITAN RTX 4090', style: TextStyle(fontFamily: 'Courier', fontSize: 22, color: Colors.white, fontWeight: FontWeight.w900)),
                      SizedBox(height: 4),
                      Text('BUILD', style: TextStyle(fontFamily: 'Courier', fontSize: 22, color: Colors.white, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('\$4,899.00', style: TextStyle(fontFamily: 'Courier', fontSize: 20, color: AppColors.neonCyan, fontWeight: FontWeight.w900)),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.pinkAccent, size: 18),
                        Icon(Icons.star, color: Colors.pinkAccent, size: 18),
                        Icon(Icons.star, color: Colors.pinkAccent, size: 18),
                        Icon(Icons.star, color: Colors.pinkAccent, size: 18),
                        Icon(Icons.star_border, color: Colors.pinkAccent, size: 18),
                        SizedBox(width: 6),
                        Text('(128 VERIFIED)', style: TextStyle(color: AppColors.textMuted, fontFamily: 'Courier', fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Performance metrics card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PERFORMANCE_METRICS', style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, color: AppColors.neonCyan)),
                  const SizedBox(height: 12),
                  _MetricRow(label: '4K GAMING (CYBERPUNK 2077)', value: '145 FPS', color: AppColors.neonCyan, progress: 0.9),
                  const SizedBox(height: 8),
                  _MetricRow(label: 'RAY TRACING OVERDRIVE', value: '110 FPS', color: AppColors.neonMagenta, progress: 0.66),
                  const SizedBox(height: 8),
                  _MetricRow(label: 'BLENDER RENDER (CLASSROOM)', value: '12 SEC', color: AppColors.neonGreen, progress: 0.22),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Core architecture
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CORE_ARCHITECTURE', style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, color: AppColors.neonCyan)),
                  const SizedBox(height: 12),
                  _KeyValueRow(label: 'CPU', value: 'INTEL CORE i9-14900K'),
                  _KeyValueRow(label: 'GPU', value: 'NVIDIA RTX 4090 24GB'),
                  _KeyValueRow(label: 'RAM', value: '64GB DDR5-6400 CL32'),
                  _KeyValueRow(label: 'STORAGE', value: '2TB NVMe PCIe 5.0'),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Memory config
            const Text('MEMORY_CONFIG', style: TextStyle(fontFamily: 'Courier', fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xFF072027)),
                    child: Column(
                      children: const [
                        Text('64GB DDR5', style: TextStyle(fontFamily: 'Courier', color: AppColors.neonCyan, fontWeight: FontWeight.w900)),
                        SizedBox(height: 6),
                        Text('INCLUDED', style: TextStyle(fontFamily: 'Courier', color: AppColors.textMuted, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF334455))),
                    child: Column(
                      children: const [
                        Text('128GB DDR5', style: TextStyle(fontFamily: 'Courier', color: AppColors.textPrimary, fontWeight: FontWeight.w900)),
                        SizedBox(height: 6),
                        Text('+ \$300.00', style: TextStyle(fontFamily: 'Courier', color: AppColors.textMuted, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // System overview
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('SYSTEM_OVERVIEW', style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, color: AppColors.neonCyan)),
                  SizedBox(height: 8),
                  Text(
                    'The Titan RTX 4090 Build represents the pinnacle of uncompromising computational power. Engineered for 8K gaming and intensive 3D rendering workloads, it features a bespoke dual-loop liquid cooling system.',
                    style: TextStyle(fontFamily: 'Courier', color: AppColors.textMuted, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: const Color(0xFF0D141A), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF243447))),
              child: const Icon(Icons.favorite_border, color: AppColors.textMuted),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: const LinearGradient(colors: [AppColors.neonCyan, AppColors.neonMagenta])),
                child: const Center(
                  child: Text('CONFIGURE NOW', style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, color: Colors.black, letterSpacing: 1.8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value, required this.color, required this.progress});

  final String label;
  final String value;
  final Color color;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(label, style: const TextStyle(fontFamily: 'Courier', color: AppColors.textMuted, fontSize: 12))),
            const SizedBox(width: 8),
            Text(value, style: const TextStyle(fontFamily: 'Courier', color: AppColors.textPrimary, fontWeight: FontWeight.w900)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: const Color(0xFF111419),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontFamily: 'Courier', color: AppColors.textMuted))),
          Text(value, style: const TextStyle(fontFamily: 'Courier', color: AppColors.textPrimary, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
