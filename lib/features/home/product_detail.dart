import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../state/app_state.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? product;
  const ProductDetailScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateNotifier>(context);
    
    // Check if showing custom product or flagship rig
    final isCustom = product != null;
    final String title = isCustom ? (product!['name'] ?? '') : 'TITAN RTX 4090';
    final String category = isCustom ? (product!['category'] ?? '') : 'BUILD';
    final double price = isCustom 
        ? ((product!['price'] as num?)?.toDouble() ?? 0.0) 
        : 4899.00;
    final int rating = isCustom ? (product!['rating'] ?? 5) : 5;

    // Pick a matching icon for custom products
    IconData getProductIcon() {
      switch (category.toUpperCase()) {
        case 'CPU':
          return Icons.memory;
        case 'MOTHERBOARD':
          return Icons.developer_board;
        case 'RAM':
          return Icons.layers;
        case 'GPU':
          return Icons.electrical_services;
        case 'STORAGE':
          return Icons.save_alt;
        case 'PSU':
          return Icons.power;
        case 'CASE':
          return Icons.settings_input_component;
        default:
          return Icons.computer;
      }
    }

    final isFavorited = appState.favoriteProductIds.contains(title);

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
        title: Text(
          category.toUpperCase(),
          style: const TextStyle(fontFamily: 'Courier', letterSpacing: 1.6),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            onPressed: () => context.push('/compare'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => context.push('/cart'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 96),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 300,
                color: AppColors.surfaceCard,
                child: Hero(
                  tag: 'product-image-$title',
                  child: (product?['imageUrl'] != null && (product!['imageUrl'] as String).isNotEmpty)
                      ? Image.network(
                          product!['imageUrl'],
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Center(
                            child: Icon(
                              getProductIcon(),
                              size: 120,
                              color: AppColors.neonCyan,
                            ),
                          ),
                        )
                      : Center(
                          child: Icon(
                            getProductIcon(),
                            size: 120,
                            color: AppColors.neonCyan,
                          ),
                        ),
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
                    children: [
                      Text(
                        title, 
                        style: const TextStyle(
                          fontFamily: 'Courier', 
                          fontSize: 20, 
                          color: Colors.white, 
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category.toUpperCase(), 
                        style: TextStyle(
                          fontFamily: 'Courier', 
                          fontSize: 14, 
                          color: AppColors.neonCyan.withOpacity(0.8), 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}', 
                      style: const TextStyle(
                        fontFamily: 'Courier', 
                        fontSize: 20, 
                        color: AppColors.neonGreen, 
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        ...List.generate(5, (idx) => Icon(
                          idx < rating ? Icons.star : Icons.star_border,
                          color: AppColors.neonMagenta,
                          size: 16,
                        )),
                        const SizedBox(width: 6),
                        const Text(
                          '(VERIFIED)', 
                          style: TextStyle(
                            color: AppColors.textMuted, 
                            fontFamily: 'Courier', 
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Specifications display
            if (!isCustom) ...[
              // Performance metrics card for Flagship build
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
              // Core architecture card for Flagship build
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
            ] else ...[
              // Custom Spec cards based on Category type
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(14)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('SPECIFICATION_MATRIX', style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, color: AppColors.neonCyan)),
                    const SizedBox(height: 12),
                    if (category.toUpperCase() == 'CPU') ...[
                      _KeyValueRow(label: 'SOCKET', value: 'AM5 / LGA1700'),
                      _KeyValueRow(label: 'CORES / THREADS', value: '8C / 16T'),
                      _KeyValueRow(label: 'BASE CLOCK', value: '4.2 GHz'),
                      _KeyValueRow(label: 'BOOST CLOCK', value: '5.0 GHz'),
                      _KeyValueRow(label: 'TDP', value: '120W'),
                    ] else if (category.toUpperCase() == 'GPU') ...[
                      _KeyValueRow(label: 'MEMORY size', value: '16GB GDDR6X'),
                      _KeyValueRow(label: 'BUS WIDTH', value: '256-bit'),
                      _KeyValueRow(label: 'CHIP TYPE', value: 'NVIDIA Ada Lovelace'),
                      _KeyValueRow(label: 'PORTS', value: '3x DP 1.4a, 1x HDMI 2.1a'),
                    ] else if (category.toUpperCase() == 'MOTHERBOARD') ...[
                      _KeyValueRow(label: 'FORM FACTOR', value: 'ATX / Micro-ATX'),
                      _KeyValueRow(label: 'MEMORY SLOTS', value: '4x DDR5 Dual Channel'),
                      _KeyValueRow(label: 'PCIe SUPPORT', value: 'PCIe 5.0 x16'),
                      _KeyValueRow(label: 'ONBOARD Wi-Fi', value: 'Wi-Fi 6E GigE'),
                    ] else ...[
                      _KeyValueRow(label: 'COMPATIBILITY', value: 'UNIVERSAL MATRIX OK'),
                      _KeyValueRow(label: 'WARRANTY', value: '3 YEAR REPLACEMENT'),
                      _KeyValueRow(label: 'SYS STATUS', value: 'CERTIFIED SECURE'),
                    ],
                  ],
                ),
              ),
            ],

            const SizedBox(height: 14),

            // System overview
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('NODE_OVERVIEW', style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, color: AppColors.neonCyan)),
                  const SizedBox(height: 8),
                  Text(
                    isCustom 
                        ? 'Certified premium tier hardware component, factory-tested to maintain peak clock performance and stable thermals under rigorous gaming and production workloads.'
                        : 'The Titan RTX 4090 Build represents the pinnacle of uncompromising computational power. Engineered for 8K gaming and intensive 3D rendering workloads, it features a bespoke dual-loop liquid cooling system.',
                    style: const TextStyle(fontFamily: 'Courier', color: AppColors.textMuted, height: 1.5),
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
            GestureDetector(
              onTap: () {
                appState.toggleFavorite(title);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isFavorited 
                        ? 'REMOVED $title FROM FAVORITES' 
                        : 'ADDED $title TO FAVORITES'),
                    backgroundColor: AppColors.surfaceElevated,
                  ),
                );
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D141A), 
                  borderRadius: BorderRadius.circular(12), 
                  border: Border.all(color: const Color(0xFF243447)),
                ),
                child: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border, 
                  color: AppColors.neonMagenta,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isCustom) {
                    appState.loadComponentIntoBuilder(category, title);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Loaded $title into $category Slot')),
                    );
                  } else {
                    final titanComponents = {
                      'CPU': 'Intel Core i9-14900K',
                      'Motherboard': 'MSI PRO Z790-A',
                      'RAM': 'Corsair Dominator Platinum 32GB DDR5',
                      'GPU': 'NVIDIA RTX 4090',
                      'Storage': 'Crucial P3 1TB NVMe',
                      'PSU': 'Corsair RM1000x 1000W',
                      'Case': 'Fractal Design Meshify C',
                    };
                    appState.loadBuildIntoBuilder(titanComponents);
                  }
                  Navigator.of(context).pop(); // Go back from details page
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), 
                    gradient: const LinearGradient(colors: [AppColors.neonCyan, AppColors.neonMagenta]),
                  ),
                  child: Center(
                    child: Text(
                      isCustom ? 'LOAD IN PC BUILDER' : 'CONFIGURE NOW', 
                      style: const TextStyle(
                        fontFamily: 'Courier', 
                        fontWeight: FontWeight.w900, 
                        color: Colors.black, 
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
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