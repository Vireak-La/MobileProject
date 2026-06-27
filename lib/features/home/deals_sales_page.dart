import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';

class DealsSalesPage extends StatefulWidget {
  const DealsSalesPage({super.key});

  @override
  State<DealsSalesPage> createState() => _DealsSalesPageState();
}

class _DealsSalesPageState extends State<DealsSalesPage> {
  late Timer _timer;
  Duration _timeLeft = const Duration(hours: 4, minutes: 22, seconds: 15);
  String _selectedCategory = 'ALL';

  final List<Map<String, dynamic>> _deals = [
    {
      'id': 'deal-1',
      'name': 'AMD Ryzen 7 7800X3D CPU',
      'category': 'CPU',
      'originalPrice': 380.00,
      'salePrice': 319.99,
      'discount': '15% OFF',
      'stockLeft': 4,
      'color': AppColors.neonCyan,
      'spec': '8 Cores / 16 Threads / 3D V-Cache',
      'image': 'assets/images/buildofthemonth.webp',
    },
    {
      'id': 'deal-2',
      'name': 'Samsung 990 Pro 2TB NVMe SSD',
      'category': 'STORAGE',
      'originalPrice': 199.99,
      'salePrice': 149.99,
      'discount': '25% OFF',
      'stockLeft': 2,
      'color': AppColors.neonMagenta,
      'spec': 'PCIe Gen 4.0 / Up to 7450 MB/s',
      'image': 'assets/images/buildofthemonth.webp',
    },
    {
      'id': 'deal-3',
      'name': 'Logitech G Pro X Superlight Wireless',
      'category': 'PERIPHERALS',
      'originalPrice': 149.99,
      'salePrice': 104.99,
      'discount': '30% OFF',
      'stockLeft': 5,
      'color': AppColors.neonGreen,
      'spec': 'Hero 25K Sensor / <63g Ultra Lightweight',
      'image': 'assets/images/Logitech.webp',
    },
    {
      'id': 'deal-4',
      'name': 'SteelSeries Arctis Nova Pro Wireless',
      'category': 'PERIPHERALS',
      'originalPrice': 349.99,
      'salePrice': 279.99,
      'discount': '20% OFF',
      'stockLeft': 3,
      'color': AppColors.neonOrange,
      'spec': 'Active Noise Cancellation / Dual Audio Streams',
      'image': 'assets/images/SteelSeries.webp',
    },
    {
      'id': 'deal-5',
      'name': 'Corsair Dominator Titanium 32GB DDR5',
      'category': 'RAM',
      'originalPrice': 179.99,
      'salePrice': 143.99,
      'discount': '20% OFF',
      'stockLeft': 7,
      'color': AppColors.neonCyan,
      'spec': 'DDR5 6000MHz CL30 Intel XMP 3.0',
      'image': 'assets/images/buildofthemonth.webp',
    },
    {
      'id': 'deal-6',
      'name': 'ASUS ROG Swift 32" 4K OLED Monitor',
      'category': 'MONITORS',
      'originalPrice': 1299.99,
      'salePrice': 999.99,
      'discount': '23% OFF',
      'stockLeft': 1,
      'color': AppColors.neonMagenta,
      'spec': '240Hz Refresh / 0.03ms Response / G-Sync',
      'image': 'assets/images/gaming-computer-case-isolated-png.webp',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeLeft.inSeconds > 0) {
            _timeLeft = _timeLeft - const Duration(seconds: 1);
          } else {
            _timeLeft = const Duration(hours: 6);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$hours : $minutes : $seconds";
  }

  void _claimDeal(String name) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF0F1622),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.neonCyan, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: AppColors.neonCyan),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'DEAL REGISTERED: $name ADDED TO CART',
                style: const TextStyle(
                  fontFamily: 'Courier',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDealImage(Map<String, dynamic> deal) {
    final name = deal['name'] as String? ?? '';
    final category = deal['category'] as String? ?? '';

    String imgUrl = '';
    if (category == 'CPU') {
      if (name.toLowerCase().contains('ryzen') || name.toLowerCase().contains('amd')) {
        imgUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHMNZjbSIorUX9H14KO8GRrbvsI4797sKllmSfPI_hevDgcPISpVuZ5BM&s=10';
      } else {
        imgUrl = 'https://preview.redd.it/does-anybody-else-miss-the-design-of-the-cpu-boxes-we-got-v0-bo1qrpa271i81.jpg?width=800&format=pjpg&auto=webp&s=b12e05b3ee668d9dba44d1e6fda0f5aed76bcada';
      }
    } else if (category == 'STORAGE') {
      imgUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU274yVum1QqcAortlmLHIO6EWcELFa3vx9iayO3f8uQ&s=10';
    } else if (category == 'RAM') {
      imgUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEF9Dit6kQkhucb8R-eQ2qWmZ_aOItm2LR6yBYRVpTsx77yRCHFB540k1N&s=10';
    } else if (category == 'GPU') {
      imgUrl = 'https://i.ebayimg.com/images/g/VmsAAOSwfrlnx8pF/s-l400.jpg';
    } else if (category == 'MOTHERBOARD') {
      imgUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRg5f9eaLD6-RiZUuOFTsXoIE1hdM2Tb04UOkdNPX6VgVBf1Z7Hzxw41o16&s=10';
    } else if (category == 'PSU') {
      imgUrl = 'https://c8.alamy.com/comp/G29229/pc-power-supply-isolated-G29229.jpg';
    } else if (category == 'CASE') {
      imgUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1658EwibLcEZYgNBeY5OoVW1-hyDyDifVz4r3IMCTNlqaTumyqazJbe43&s=10';
    } else {
      final fallback = deal['image'] as String? ?? 'assets/images/buildofthemonth.webp';
      return Image.asset(fallback, fit: BoxFit.cover);
    }

    return Image.network(
      imgUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => Image.asset('assets/images/buildofthemonth.webp', fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['ALL', 'GPU', 'CPU', 'STORAGE', 'RAM', 'PERIPHERALS', 'MONITORS'];

    // Filter deals based on active selection
    final filteredDeals = _selectedCategory == 'ALL'
        ? _deals
        : _deals.where((d) => d['category'] == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF05080D),
      drawer: const CyberDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'CYBER DEALS & SALES',
          style: TextStyle(
            fontFamily: 'Courier',
            letterSpacing: 1.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flash Sale Banner
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF16081E),
                      AppColors.surfaceCard,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.neonMagenta.withOpacity(0.5), width: 1.5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.flash_on, color: AppColors.neonMagenta, size: 20),
                            const SizedBox(width: 6),
                            const Text(
                              'FLASH SALE ACTIVE',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'LIVE NOW',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _formatDuration(_timeLeft),
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppColors.neonMagenta,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'GLOBAL INVENTORY REDUCING',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 9,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '78% CLAIMED',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 9,
                            color: AppColors.neonMagenta,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.78,
                        backgroundColor: const Color(0xFF1A1F29),
                        color: AppColors.neonMagenta,
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),

              // Mega Deal Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: AppColors.neonGreen, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'TODAY\'S MEGA DEALS',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textPrimary,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Mega Featured Deal Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.neonCyan.withOpacity(0.5), width: 1.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      // Backdrop glowing decoration
                      Positioned(
                        right: -50,
                        bottom: -50,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.neonCyan.withOpacity(0.2),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    '-25% OFF',
                                    style: TextStyle(
                                      fontFamily: 'Courier',
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'GPU SPECIALIST',
                                  style: TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 10,
                                    color: AppColors.neonCyan,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'NVIDIA RTX 4080 Super',
                                        style: TextStyle(
                                          fontFamily: 'Courier',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        'Founders Edition 16GB GDDR6X',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          const Text(
                                            '\$1,199.99',
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              fontSize: 13,
                                              color: AppColors.textMuted,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            '\$899.99',
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              fontSize: 20,
                                              color: AppColors.neonGreen,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://i.ebayimg.com/images/g/VmsAAOSwfrlnx8pF/s-l400.jpg',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Image.asset(
                                      'assets/images/buildofthemonth.webp',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(color: Color(0xFF1E2B40), height: 1),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.inventory_2_outlined, color: Colors.orangeAccent, size: 14),
                                    SizedBox(width: 6),
                                    Text(
                                      'ONLY 3 UNITS REMAINING',
                                      style: TextStyle(
                                        fontFamily: 'Courier',
                                        fontSize: 9,
                                        color: Colors.orangeAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.neonCyan,
                                    foregroundColor: Colors.black,
                                    minimumSize: const Size(120, 36),
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () => _claimDeal('NVIDIA RTX 4080 Super'),
                                  child: const Text(
                                    'CLAIM DEAL',
                                    style: TextStyle(
                                      fontFamily: 'Courier',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Categories Header
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 8.0),
                child: Row(
                  children: [
                    Icon(Icons.category_outlined, color: AppColors.neonCyan, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'FILTER BY COMPONENT',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textPrimary,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Categories scroll list
              SizedBox(
                height: 48,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = _selectedCategory == cat;
                    return ChoiceChip(
                      label: Text(
                        cat,
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.black : AppColors.textSecondary,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: AppColors.neonCyan,
                      backgroundColor: const Color(0xFF0F1622),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: isSelected ? AppColors.neonCyan : const Color(0xFF1E2B40),
                          width: 1,
                        ),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = cat;
                          });
                        }
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Deals list/grid
              if (filteredDeals.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: const [
                      Icon(Icons.inventory_2_outlined, color: AppColors.textMuted, size: 48),
                      SizedBox(height: 12),
                      Text(
                        'NO ACTIVE DEALS IN THIS ARCHIVE',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: filteredDeals.length,
                  itemBuilder: (context, index) {
                    final deal = filteredDeals[index];
                    final tone = deal['color'] as Color;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0C1114),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: tone.withOpacity(0.35), width: 1.2),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail/graphic
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Container(
                                  width: 76,
                                  height: 76,
                                  color: const Color(0xFF101722),
                                ),
                                Positioned.fill(
                                  child: _getDealImage(deal),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: tone.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        deal['category'],
                                        style: TextStyle(
                                          fontFamily: 'Courier',
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: tone,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      deal['discount'],
                                      style: const TextStyle(
                                        fontFamily: 'Courier',
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  deal['name'],
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  deal['spec'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '\$${deal['originalPrice'].toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontFamily: 'Courier',
                                            fontSize: 11,
                                            color: AppColors.textMuted,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '\$${deal['salePrice'].toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontFamily: 'Courier',
                                            fontSize: 15,
                                            color: AppColors.neonGreen,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF1E2B40),
                                        foregroundColor: tone,
                                        elevation: 0,
                                        minimumSize: const Size(90, 28),
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          side: BorderSide(color: tone.withOpacity(0.5)),
                                        ),
                                      ),
                                      onPressed: () => _claimDeal(deal['name']),
                                      child: const Text(
                                        'ADD TO CART',
                                        style: TextStyle(
                                          fontFamily: 'Courier',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
