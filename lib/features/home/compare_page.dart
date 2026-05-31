import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05080D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('COMPARE BUILDS', style: TextStyle(fontFamily: 'Courier', letterSpacing: 1.6)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Expanded(
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('COMPARING', style: TextStyle(fontFamily: 'Courier', color: AppColors.neonCyan, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 12),
                          _CompareHeader(),
                          const SizedBox(height: 16),
                          _ProductCards(),
                          const SizedBox(height: 18),
                          _SpecsCard(
                            rows: const [
                              ['PROCESSOR (CPU)', 'Intel Core i9-14900K', 'Intel Core i7-14700K'],
                              ['GRAPHICS (GPU)', 'NVIDIA RTX 4090 24GB', 'NVIDIA RTX 4070 Ti 12GB'],
                              ['MEMORY (RAM)', '64GB DDR5-6400', '32GB DDR5-5600'],
                              ['STORAGE (NVME)', '4TB Gen4 (7300MB/s)', '2TB Gen4 (6600MB/s)'],
                              ['POWER SUPPLY (PSU)', '1200W 80+ Platinum', '850W 80+ Gold'],
                            ],
                          ),
                          const SizedBox(height: 18),
                          _PerformanceCard(
                            title: 'PERFORMANCE BENCHMARK: CYBERPUNK 2077 (4K ULTRA, RT ON)',
                            metrics: const [
                              {'label': 'TITAN RTX 4090', 'value': '112 FPS', 'progress': 0.88, 'color': AppColors.neonCyan},
                              {'label': 'PHANTOM I7 STREAMER', 'value': '68 FPS', 'progress': 0.46, 'color': AppColors.neonMagenta},
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xFF0D141A)),
                      child: const Center(child: Text('CANCEL', style: TextStyle(fontFamily: 'Courier', color: AppColors.textMuted))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: const LinearGradient(colors: [AppColors.neonCyan, AppColors.neonMagenta])),
                      child: const Center(child: Text('COMPARE', style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, color: Colors.black))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _ProductCard(title: 'TITAN RTX 4090 BUILD', price: '\$4,899.00', image: 'assets/images/buildofthemonth.webp', accent: AppColors.neonCyan)),
        const SizedBox(width: 12),
        Expanded(child: _ProductCard(title: 'PHANTOM I7 STREAMER', price: '\$2,499.00', image: 'assets/images/gaming-computer-case-isolated-png.webp', accent: AppColors.neonMagenta)),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.title, required this.price, required this.image, required this.accent});
  final String title;
  final String price;
  final String image;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF0C1114), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF1B2328))),
      child: Column(
        children: [
          Stack(
            children: [
              AspectRatio(aspectRatio: 1, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(image, fit: BoxFit.cover))),
              Positioned(top: 8, left: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF0A2110), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.green)), child: const Text('IN STOCK', style: TextStyle(fontFamily: 'Courier', color: Colors.green)))),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'Courier', color: AppColors.textPrimary, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(price, style: TextStyle(fontFamily: 'Courier', color: accent, fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Container(
            height: 44,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: accent)),
            child: Center(child: Text('SELECT FOR BUILD', style: TextStyle(fontFamily: 'Courier', color: accent, fontWeight: FontWeight.w900))),
          ),
        ],
      ),
    );
  }
}

class _SpecsCard extends StatelessWidget {
  const _SpecsCard({required this.rows});
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF0C1114), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF1B2328))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: const [
                Icon(Icons.settings, color: AppColors.neonCyan),
                SizedBox(width: 8),
                Text('HARDWARE SPECIFICATIONS', style: TextStyle(fontFamily: 'Courier', color: AppColors.textPrimary, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          const Divider(color: Color(0xFF1F2A2E)),
          ...rows.map((r) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(child: Text(r[1], style: const TextStyle(fontFamily: 'Courier'))),
                        Expanded(child: Text(r[0], textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'Courier', color: AppColors.textMuted))),
                        Expanded(child: Text(r[2], textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'Courier'))),
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xFF1F2A2E), height: 1),
                ],
              )),
        ],
      ),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  const _PerformanceCard({required this.title, required this.metrics});
  final String title;
  final List<Map<String, Object>> metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF0C1114), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF1B2328))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontFamily: 'Courier', color: AppColors.neonCyan, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          ...metrics.map((m) {
            final label = m['label'] as String;
            final value = m['value'] as String;
            final progress = m['progress'] as double;
            final color = m['color'] as Color;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(label, style: const TextStyle(fontFamily: 'Courier'))),
                      Text(value, style: TextStyle(fontFamily: 'Courier', color: color, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                      backgroundColor: const Color(0xFF0B1113),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _CompareHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: const [
              SizedBox(height: 8),
              Text('TITAN RTX 4090', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, color: AppColors.neonCyan)),
            ],
          ),
        ),
        Container(width: 1, height: 48, color: const Color(0xFF223247)),
        Expanded(
          child: Column(
            children: const [
              SizedBox(height: 8),
              Text('PHANTOM I7', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, color: AppColors.neonMagenta)),
            ],
          ),
        ),
      ],
    );
  }
}
