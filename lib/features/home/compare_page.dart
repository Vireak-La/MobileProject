import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({super.key});

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // The categories to compare
  final List<String> _categories = [
    'CPU',
    'GPU',
    'Motherboard',
    'RAM',
    'Storage',
    'PSU',
    'Case',
  ];

  // Component dataset mapped by category
  final Map<String, List<Map<String, dynamic>>> _componentData = {
    'CPU': [
      {'name': 'AMD Ryzen 9 7950X', 'price': 699, 'socket': 'AM5', 'tdp': 170, 'cores': '16 Cores / 32 Threads'},
      {'name': 'AMD Ryzen 7 7800X3D', 'price': 380, 'socket': 'AM5', 'tdp': 120, 'cores': '8 Cores / 16 Threads'},
      {'name': 'AMD Ryzen 5 7600X', 'price': 229, 'socket': 'AM5', 'tdp': 105, 'cores': '6 Cores / 12 Threads'},
      {'name': 'AMD Ryzen 5 7600', 'price': 220, 'socket': 'AM5', 'tdp': 65, 'cores': '6 Cores / 12 Threads'},
      {'name': 'Intel Core i9-13900K', 'price': 589, 'socket': 'LGA1700', 'tdp': 125, 'cores': '24 Cores / 32 Threads'},
      {'name': 'Intel Core i7-13700K', 'price': 420, 'socket': 'LGA1700', 'tdp': 125, 'cores': '16 Cores / 24 Threads'},
      {'name': 'Intel Core i5-13600K', 'price': 319, 'socket': 'LGA1700', 'tdp': 125, 'cores': '14 Cores / 20 Threads'},
      {'name': 'Intel Core i5-12400F', 'price': 179, 'socket': 'LGA1700', 'tdp': 65, 'cores': '6 Cores / 12 Threads'},
    ],
    'GPU': [
      {'name': 'NVIDIA RTX 4090', 'price': 1599, 'tdp': 450, 'vram': '24GB GDDR6X'},
      {'name': 'NVIDIA RTX 4080', 'price': 1199, 'tdp': 320, 'vram': '16GB GDDR6X'},
      {'name': 'NVIDIA RTX 4070 Ti Super', 'price': 790, 'tdp': 285, 'vram': '16GB GDDR6X'},
      {'name': 'NVIDIA RTX 4070', 'price': 599, 'tdp': 200, 'vram': '12GB GDDR6X'},
      {'name': 'NVIDIA RTX 4060 Ti', 'price': 399, 'tdp': 160, 'vram': '8GB GDDR6'},
      {'name': 'AMD Radeon RX 7900 XTX', 'price': 999, 'tdp': 355, 'vram': '24GB GDDR6'},
      {'name': 'AMD Radeon RX 7800 XT', 'price': 499, 'tdp': 300, 'vram': '16GB GDDR6'},
    ],
    'Motherboard': [
      {'name': 'ASUS ROG Strix B650E', 'price': 320, 'socket': 'AM5', 'chipset': 'B650E', 'formFactor': 'ATX'},
      {'name': 'MSI MAG B650 Tomahawk', 'price': 190, 'socket': 'AM5', 'chipset': 'B650', 'formFactor': 'ATX'},
      {'name': 'ASUS PRIME X670-P', 'price': 240, 'socket': 'AM5', 'chipset': 'X670', 'formFactor': 'ATX'},
      {'name': 'Gigabyte X670 AORUS Elite', 'price': 260, 'socket': 'AM5', 'chipset': 'X670', 'formFactor': 'ATX'},
      {'name': 'ASRock B650M Steel Legend', 'price': 150, 'socket': 'AM5', 'chipset': 'B650', 'formFactor': 'Micro-ATX'},
      {'name': 'ASUS PRIME Z790-P', 'price': 210, 'socket': 'LGA1700', 'chipset': 'Z790', 'formFactor': 'ATX'},
      {'name': 'MSI PRO Z790-A', 'price': 200, 'socket': 'LGA1700', 'chipset': 'Z790', 'formFactor': 'ATX'},
    ],
    'RAM': [
      {'name': 'Corsair Dominator Plat DDR5 32GB', 'price': 150, 'type': 'DDR5', 'speed': '6000 MHz', 'latency': 'CL30'},
      {'name': 'G.Skill Trident Z5 DDR5 32GB', 'price': 90, 'type': 'DDR5', 'speed': '5600 MHz', 'latency': 'CL36'},
      {'name': 'Kingston Fury Beast DDR5 32GB', 'price': 95, 'type': 'DDR5', 'speed': '6000 MHz', 'latency': 'CL40'},
      {'name': 'Corsair Vengeance DDR4 32GB', 'price': 75, 'type': 'DDR4', 'speed': '3200 MHz', 'latency': 'CL16'},
      {'name': 'Crucial Ballistix DDR4 16GB', 'price': 45, 'type': 'DDR4', 'speed': '3200 MHz', 'latency': 'CL16'},
    ],
    'Storage': [
      {'name': 'Sabrent Rocket 4 Plus 2TB', 'price': 230, 'type': 'NVMe Gen4', 'readSpeed': '7100 MB/s'},
      {'name': 'Samsung 990 Pro 2TB NVMe', 'price': 140, 'type': 'NVMe Gen4', 'readSpeed': '7450 MB/s'},
      {'name': 'Western Digital SN850 1TB', 'price': 120, 'type': 'NVMe Gen4', 'readSpeed': '7000 MB/s'},
      {'name': 'Crucial P3 1TB NVMe', 'price': 55, 'type': 'NVMe Gen3', 'readSpeed': '3500 MB/s'},
      {'name': 'Crucial MX500 2TB SATA', 'price': 150, 'type': 'SATA 2.5"', 'readSpeed': '560 MB/s'},
    ],
    'PSU': [
      {'name': 'Seasonic PRIME 1000W', 'price': 220, 'watt': 1000, 'efficiency': '80+ Titanium'},
      {'name': 'Corsair RM1000x 1000W', 'price': 200, 'watt': 1000, 'efficiency': '80+ Gold'},
      {'name': 'Corsair RM850x 850W', 'price': 150, 'watt': 850, 'efficiency': '80+ Gold'},
      {'name': 'Corsair RM750x 750W', 'price': 120, 'watt': 750, 'efficiency': '80+ Gold'},
      {'name': 'EVGA 750W Gold', 'price': 110, 'watt': 750, 'efficiency': '80+ Gold'},
    ],
    'Case': [
      {'name': 'Lian Li Lancool II', 'price': 120, 'color': 'RGB Black', 'size': 'Mid Tower'},
      {'name': 'BeQuiet! Pure Base 500DX', 'price': 110, 'color': 'ARGB White', 'size': 'Mid Tower'},
      {'name': 'Fractal Design Meshify C', 'price': 100, 'color': 'Dark Tint Black', 'size': 'Mid Tower'},
      {'name': 'Corsair 4000D Airflow', 'price': 95, 'color': 'Black', 'size': 'Mid Tower'},
      {'name': 'NZXT H510', 'price': 70, 'color': 'Matte White', 'size': 'Mid Tower'},
    ],
  };

  // Currently selected items for comparison per category
  // Keyed by category name
  late Map<String, int> _selectedIndicesA;
  late Map<String, int> _selectedIndicesB;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    
    // Default select first item for A, and second item for B (if it exists)
    _selectedIndicesA = {};
    _selectedIndicesB = {};
    
    for (var cat in _categories) {
      _selectedIndicesA[cat] = 0;
      final items = _componentData[cat] ?? [];
      _selectedIndicesB[cat] = items.length > 1 ? 1 : 0;
    }

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentCategory = _categories[_tabController.index];
    final List<Map<String, dynamic>> items = _componentData[currentCategory] ?? [];
    
    final int indexA = _selectedIndicesA[currentCategory] ?? 0;
    final int indexB = _selectedIndicesB[currentCategory] ?? 0;

    final Map<String, dynamic> itemA = items.isNotEmpty ? items[indexA] : {};
    final Map<String, dynamic> itemB = items.isNotEmpty ? items[indexB] : {};

    return Scaffold(
      backgroundColor: const Color(0xFF05080D),
      drawer: const CyberDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'COMPARE COMPONENTS',
          style: TextStyle(fontFamily: 'Courier', letterSpacing: 1.6, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Styled neon category selector tabs
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF1E2B40), width: 1.5),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: AppColors.neonCyan,
                labelColor: AppColors.neonCyan,
                unselectedLabelColor: AppColors.textMuted,
                labelStyle: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13),
                unselectedLabelStyle: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13),
                tabs: _categories.map((cat) => Tab(text: cat.toUpperCase())).toList(),
              ),
            ),
            
            // Selector dropdown and side-by-side spec comparison view
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dropdown Dropdown selectors side-by-side or stacked responsively
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isNarrow = constraints.maxWidth < 500;
                        final selectorA = _buildSelectorCard(
                          title: 'COMPONENT A',
                          accentColor: AppColors.neonCyan,
                          items: items,
                          selectedIndex: indexA,
                          onChanged: (newVal) {
                            if (newVal != null) {
                              setState(() {
                                _selectedIndicesA[currentCategory] = newVal;
                              });
                            }
                          },
                        );
                        final selectorB = _buildSelectorCard(
                          title: 'COMPONENT B',
                          accentColor: AppColors.neonMagenta,
                          items: items,
                          selectedIndex: indexB,
                          onChanged: (newVal) {
                            if (newVal != null) {
                              setState(() {
                                _selectedIndicesB[currentCategory] = newVal;
                              });
                            }
                          },
                        );

                        if (isNarrow) {
                          return Column(
                            children: [
                              selectorA,
                              const SizedBox(height: 12),
                              selectorB,
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              Expanded(child: selectorA),
                              const SizedBox(width: 12),
                              Expanded(child: selectorB),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    // Main Side-by-Side Specs Card
                    if (itemA.isNotEmpty && itemB.isNotEmpty) ...[
                      _buildMainSpecsComparisonCard(currentCategory, itemA, itemB),
                      const SizedBox(height: 18),
                      _buildVisualBarsCard(currentCategory, itemA, itemB),
                    ] else ...[
                      const Center(
                        child: Text(
                          'Select components to begin comparison.',
                          style: TextStyle(fontFamily: 'Courier', color: AppColors.textMuted),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dropdown card builder with neon border accent
  Widget _buildSelectorCard({
    required String title,
    required Color accentColor,
    required List<Map<String, dynamic>> items,
    required int selectedIndex,
    required ValueChanged<int?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1114),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: accentColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: selectedIndex,
              isExpanded: true,
              dropdownColor: const Color(0xFF0F1622),
              icon: Icon(Icons.arrow_drop_down, color: accentColor),
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
              onChanged: onChanged,
              items: List.generate(items.length, (idx) {
                return DropdownMenuItem<int>(
                  value: idx,
                  child: Text(
                    items[idx]['name'],
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Build the specifications table comparison
  Widget _buildMainSpecsComparisonCard(String category, Map<String, dynamic> itemA, Map<String, dynamic> itemB) {
    // Generate comparison rows dynamically based on the category
    List<List<String>> specRows = [];

    // Common Price row
    specRows.add([
      'PRICE',
      '\$${itemA['price']}',
      '\$${itemB['price']}',
    ]);

    // Custom rows per component category
    if (category == 'CPU') {
      specRows.add(['SOCKET', itemA['socket']?.toString() ?? 'N/A', itemB['socket']?.toString() ?? 'N/A']);
      specRows.add(['CORES / THREADS', itemA['cores']?.toString() ?? 'N/A', itemB['cores']?.toString() ?? 'N/A']);
      specRows.add(['TDP (POWER)', '${itemA['tdp']}W', '${itemB['tdp']}W']);
    } else if (category == 'GPU') {
      specRows.add(['VRAM / MEMORY', itemA['vram']?.toString() ?? 'N/A', itemB['vram']?.toString() ?? 'N/A']);
      specRows.add(['TDP (POWER)', '${itemA['tdp']}W', '${itemB['tdp']}W']);
    } else if (category == 'Motherboard') {
      specRows.add(['SOCKET', itemA['socket']?.toString() ?? 'N/A', itemB['socket']?.toString() ?? 'N/A']);
      specRows.add(['CHIPSET', itemA['chipset']?.toString() ?? 'N/A', itemB['chipset']?.toString() ?? 'N/A']);
      specRows.add(['FORM FACTOR', itemA['formFactor']?.toString() ?? 'N/A', itemB['formFactor']?.toString() ?? 'N/A']);
    } else if (category == 'RAM') {
      specRows.add(['TYPE', itemA['type']?.toString() ?? 'N/A', itemB['type']?.toString() ?? 'N/A']);
      specRows.add(['SPEED', itemA['speed']?.toString() ?? 'N/A', itemB['speed']?.toString() ?? 'N/A']);
      specRows.add(['LATENCY', itemA['latency']?.toString() ?? 'N/A', itemB['latency']?.toString() ?? 'N/A']);
    } else if (category == 'Storage') {
      specRows.add(['INTERFACE', itemA['type']?.toString() ?? 'N/A', itemB['type']?.toString() ?? 'N/A']);
      specRows.add(['READ SPEED', itemA['readSpeed']?.toString() ?? 'N/A', itemB['readSpeed']?.toString() ?? 'N/A']);
    } else if (category == 'PSU') {
      specRows.add(['WATTAGE', '${itemA['watt']}W', '${itemB['watt']}W']);
      specRows.add(['EFFICIENCY', itemA['efficiency']?.toString() ?? 'N/A', itemB['efficiency']?.toString() ?? 'N/A']);
    } else if (category == 'Case') {
      specRows.add(['COLORWAY', itemA['color']?.toString() ?? 'N/A', itemB['color']?.toString() ?? 'N/A']);
      specRows.add(['FORM FACTOR', itemA['size']?.toString() ?? 'N/A', itemB['size']?.toString() ?? 'N/A']);
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0C1114),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1B2328)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: const [
                Icon(Icons.tune, color: AppColors.neonCyan, size: 20),
                SizedBox(width: 8),
                Text(
                  'TECHNICAL SPECIFICATIONS',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF1F2A2E), height: 1),

          // Side-by-side Item Title Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    itemA['name'],
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      color: AppColors.neonCyan,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2328),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'VS',
                    style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    itemB['name'],
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      color: AppColors.neonMagenta,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF1F2A2E), height: 1),

          // Specs Rows
          ...specRows.map((row) {
            final isPrice = row[0] == 'PRICE';
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  color: isPrice ? const Color(0xFF11171A) : Colors.transparent,
                  child: Row(
                    children: [
                      // Component A Spec
                      Expanded(
                        child: Text(
                          row[1],
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: isPrice ? 15 : 12,
                            fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
                            color: isPrice ? AppColors.neonCyan : Colors.white,
                          ),
                        ),
                      ),
                      // Spec Name (Middle Label)
                      Expanded(
                        child: Text(
                          row[0],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isPrice ? AppColors.neonGreen : AppColors.textMuted,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      // Component B Spec
                      Expanded(
                        child: Text(
                          row[2],
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: isPrice ? 15 : 12,
                            fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
                            color: isPrice ? AppColors.neonMagenta : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFF1F2A2E), height: 1),
              ],
            );
          }),
        ],
      ),
    );
  }

  // Visual Bars comparison for numeric attributes like Price or TDP
  Widget _buildVisualBarsCard(String category, Map<String, dynamic> itemA, Map<String, dynamic> itemB) {
    final int priceA = itemA['price'] as int;
    final int priceB = itemB['price'] as int;
    final double maxPrice = (priceA > priceB ? priceA : priceB).toDouble();

    // Check if we have other numeric spec fields
    int? valA;
    int? valB;
    String barLabel = '';
    
    if (category == 'CPU' || category == 'GPU') {
      valA = itemA['tdp'] as int?;
      valB = itemB['tdp'] as int?;
      barLabel = 'THERMAL POWER DESIGN (TDP)';
    } else if (category == 'PSU') {
      valA = itemA['watt'] as int?;
      valB = itemB['watt'] as int?;
      barLabel = 'RATED WATTAGE';
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1114),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1B2328)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VISUAL SPECS CHECK',
            style: TextStyle(
              fontFamily: 'Courier',
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 11,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),

          // Price Comparison Bar
          const Text(
            'PRICE (LOWER IS BETTER)',
            style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: AppColors.textMuted),
          ),
          const SizedBox(height: 8),
          _buildBarChartRow(
            labelA: itemA['name'],
            valA: priceA.toDouble(),
            labelB: itemB['name'],
            valB: priceB.toDouble(),
            maxVal: maxPrice,
            suffix: '\$',
            invertPreference: true, // Lower price is better
          ),
          
          if (valA != null && valB != null) ...[
            const SizedBox(height: 16),
            Text(
              barLabel,
              style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            _buildBarChartRow(
              labelA: itemA['name'],
              valA: valA.toDouble(),
              labelB: itemB['name'],
              valB: valB.toDouble(),
              maxVal: (valA > valB ? valA : valB).toDouble(),
              suffix: category == 'PSU' ? 'W' : 'W TDP',
              invertPreference: category == 'CPU' || category == 'GPU', // Lower TDP is better for efficiency
            ),
          ],
        ],
      ),
    );
  }

  // Row builder containing bars comparing both items
  Widget _buildBarChartRow({
    required String labelA,
    required double valA,
    required String labelB,
    required double valB,
    required double maxVal,
    required String suffix,
    bool invertPreference = false,
  }) {
    // Calculate fractional ratios
    final double ratioA = maxVal > 0 ? (valA / maxVal) : 0;
    final double ratioB = maxVal > 0 ? (valB / maxVal) : 0;

    // Determine color highlighting based on choice preference
    bool itemAIsBetter = invertPreference ? valA < valB : valA > valB;
    bool draw = valA == valB;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Component A bar
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                labelA,
                style: const TextStyle(fontSize: 11, color: Colors.white70, overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: ratioA,
                      minHeight: 8,
                      backgroundColor: const Color(0xFF1B2328),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        draw ? AppColors.neonCyan.withOpacity(0.7) : (itemAIsBetter ? AppColors.neonGreen : AppColors.neonCyan.withOpacity(0.3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 55,
              child: Text(
                '${suffix == '\$' ? '\$' : ''}${valA.toInt()}${suffix == '\$' ? '' : suffix}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: draw ? Colors.white : (itemAIsBetter ? AppColors.neonGreen : AppColors.textMuted),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Component B bar
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                labelB,
                style: const TextStyle(fontSize: 11, color: Colors.white70, overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: ratioB,
                      minHeight: 8,
                      backgroundColor: const Color(0xFF1B2328),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        draw ? AppColors.neonMagenta.withOpacity(0.7) : (!itemAIsBetter ? AppColors.neonGreen : AppColors.neonMagenta.withOpacity(0.3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 55,
              child: Text(
                '${suffix == '\$' ? '\$' : ''}${valB.toInt()}${suffix == '\$' ? '' : suffix}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: draw ? Colors.white : (!itemAIsBetter ? AppColors.neonGreen : AppColors.textMuted),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
