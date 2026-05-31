import 'package:flutter/material.dart';
import '../checkout/cart.dart';
import '../../theme/app_colors.dart';

class PcBuilderStubScreen extends StatefulWidget {
  const PcBuilderStubScreen({super.key});

  @override
  State<PcBuilderStubScreen> createState() => _PcBuilderStubScreenState();
}

class _PcBuilderStubScreenState extends State<PcBuilderStubScreen> {
  int totalCost = 0;
  String currentCpu = 'Awaiting selection...';
  String currentMotherboard = 'Awaiting selection...';
  String currentRam = 'Awaiting selection...';
  String currentGpu = 'Awaiting selection...';
  String currentStorage = 'Awaiting selection...';
  String currentPsu = 'Awaiting selection...';
  String currentCase = 'Awaiting selection...';
  bool isCompatible = false;

  // Simple catalogs with minimal attributes for demo purposes
  final List<Map<String, dynamic>> cpus = [
    {'name': 'AMD Ryzen 9 7950X', 'price': 699, 'socket': 'AM5', 'tdp': 170},
    {'name': 'AMD Ryzen 7 7800X3D', 'price': 380, 'socket': 'AM5', 'tdp': 120},
    {'name': 'AMD Ryzen 5 7600X', 'price': 229, 'socket': 'AM5', 'tdp': 105},
    {'name': 'AMD Ryzen 5 7600', 'price': 220, 'socket': 'AM5', 'tdp': 65},
    {'name': 'Intel Core i9-13900K', 'price': 589, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'Intel Core i7-13700K', 'price': 420, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'Intel Core i5-13600K', 'price': 319, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'Intel Core i5-12400F', 'price': 179, 'socket': 'LGA1700', 'tdp': 65},
    {'name': 'AMD Ryzen 7 7700X', 'price': 349, 'socket': 'AM5', 'tdp': 105},
    {'name': 'Intel Core i3-13100', 'price': 119, 'socket': 'LGA1700', 'tdp': 60},
  ];

  final List<Map<String, dynamic>> motherboards = [
    {'name': 'MSI MAG B650 Tomahawk', 'price': 190, 'socket': 'AM5'},
    {'name': 'ASUS ROG Strix B650E', 'price': 320, 'socket': 'AM5'},
    {'name': 'ASUS PRIME X670-P', 'price': 240, 'socket': 'AM5'},
    {'name': 'Gigabyte X670 AORUS Elite', 'price': 260, 'socket': 'AM5'},
    {'name': 'ASRock B650M Steel Legend', 'price': 150, 'socket': 'AM5'},
    {'name': 'ASUS PRIME Z790-P', 'price': 210, 'socket': 'LGA1700'},
    {'name': 'MSI PRO Z790-A', 'price': 200, 'socket': 'LGA1700'},
    {'name': 'Gigabyte Z790 UD AX', 'price': 190, 'socket': 'LGA1700'},
    {'name': 'ASRock Z790 Phantom Gaming', 'price': 280, 'socket': 'LGA1700'},
    {'name': 'MSI MAG B660 Tomahawk', 'price': 160, 'socket': 'LGA1700'},
  ];

  final List<Map<String, dynamic>> rams = [
    {'name': 'G.Skill Trident Z5 32GB DDR5', 'price': 90, 'type': 'DDR5'},
    {'name': 'Corsair Vengeance 32GB DDR4', 'price': 75, 'type': 'DDR4'},
    {'name': 'Kingston Fury Beast 32GB DDR5', 'price': 95, 'type': 'DDR5'},
    {'name': 'Crucial Ballistix 16GB DDR4', 'price': 45, 'type': 'DDR4'},
    {'name': 'Corsair Dominator Platinum 32GB DDR5', 'price': 150, 'type': 'DDR5'},
    {'name': 'Team T-Force Delta 32GB DDR5', 'price': 85, 'type': 'DDR5'},
    {'name': 'Patriot Viper 32GB DDR4', 'price': 70, 'type': 'DDR4'},
    {'name': 'Samsung 32GB DDR5 RDIMM', 'price': 130, 'type': 'DDR5'},
    {'name': 'ADATA XPG Lancer 16GB DDR5', 'price': 50, 'type': 'DDR5'},
    {'name': 'Thermaltake TOUGHRAM 32GB DDR4', 'price': 80, 'type': 'DDR4'},
  ];

  final List<Map<String, dynamic>> gpus = [
    {'name': 'NVIDIA RTX 4090', 'price': 1599, 'tdp': 450},
    {'name': 'NVIDIA RTX 4080', 'price': 1199, 'tdp': 320},
    {'name': 'NVIDIA RTX 4070 Ti Super', 'price': 790, 'tdp': 285},
    {'name': 'NVIDIA RTX 4070', 'price': 599, 'tdp': 200},
    {'name': 'NVIDIA RTX 4060 Ti', 'price': 399, 'tdp': 160},
    {'name': 'NVIDIA RTX 3060', 'price': 330, 'tdp': 170},
    {'name': 'AMD Radeon RX 7900 XTX', 'price': 999, 'tdp': 355},
    {'name': 'AMD Radeon RX 7800 XT', 'price': 499, 'tdp': 300},
    {'name': 'AMD Radeon RX 7600', 'price': 249, 'tdp': 165},
    {'name': 'NVIDIA GTX 1660 Super', 'price': 219, 'tdp': 125},
  ];

  final List<Map<String, dynamic>> storages = [
    {'name': 'Samsung 990 Pro 2TB NVMe', 'price': 140},
    {'name': 'Crucial P3 1TB NVMe', 'price': 55},
    {'name': 'Western Digital Black SN850 1TB', 'price': 120},
    {'name': 'Sabrent Rocket 4 Plus 2TB', 'price': 230},
    {'name': 'Kingston KC3000 1TB', 'price': 110},
    {'name': 'Samsung 870 EVO 1TB SATA', 'price': 80},
    {'name': 'Crucial MX500 2TB SATA', 'price': 150},
    {'name': 'Seagate Barracuda 2TB HDD', 'price': 60},
    {'name': 'WD Blue SN570 1TB', 'price': 65},
    {'name': 'ADATA XPG SX8200 1TB', 'price': 70},
  ];

  final List<Map<String, dynamic>> psus = [
    {'name': 'Corsair RM1000x 1000W', 'price': 200, 'watt': 1000},
    {'name': 'Seasonic PRIME 1000W', 'price': 220, 'watt': 1000},
    {'name': 'Corsair RM850x 850W', 'price': 150, 'watt': 850},
    {'name': 'Corsair RM750x 750W', 'price': 120, 'watt': 750},
    {'name': 'EVGA 750W Gold', 'price': 110, 'watt': 750},
    {'name': 'EVGA 650W Gold', 'price': 90, 'watt': 650},
    {'name': 'Cooler Master 850W Gold', 'price': 130, 'watt': 850},
    {'name': 'Thermaltake 750W', 'price': 95, 'watt': 750},
    {'name': 'BeQuiet! 650W', 'price': 105, 'watt': 650},
    {'name': 'Antec NE750 750W', 'price': 85, 'watt': 750},
  ];

  final List<Map<String, dynamic>> cases = [
    {'name': 'NZXT H510', 'price': 70},
    {'name': 'Fractal Design Meshify C', 'price': 100},
    {'name': 'Corsair 4000D', 'price': 95},
    {'name': 'Lian Li Lancool II', 'price': 120},
    {'name': 'Cooler Master NR600', 'price': 60},
    {'name': 'Phanteks Eclipse P400A', 'price': 80},
    {'name': 'BeQuiet! Pure Base 500DX', 'price': 110},
    {'name': 'Thermaltake Divider 300', 'price': 85},
    {'name': 'SilverStone RL06', 'price': 65},
    {'name': 'DeepCool Matrexx 55', 'price': 55},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CUSTOM RIG BUILDER'),
        actions: [
          IconButton(
            tooltip: 'Open cart',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
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
            _buildSelectableRow('Processor (CPU)', currentCpu, _priceOf(currentCpu), () => _selectCpu()),
            _buildSelectableRow('Motherboard (MB)', currentMotherboard, _priceOf(currentMotherboard), () => _selectMotherboard()),
            _buildSelectableRow('System Memory (RAM)', currentRam, _priceOf(currentRam), () => _selectRam()),
            _buildSelectableRow('Graphics Card (GPU)', currentGpu, _priceOf(currentGpu), () => _selectGpu()),
            _buildSelectableRow('Storage SSD', currentStorage, _priceOf(currentStorage), () => _selectStorage()),
            _buildSelectableRow('Power Supply (PSU)', currentPsu, _priceOf(currentPsu), () => _selectPsu()),
            _buildSelectableRow('PC Chassis (Case)', currentCase, _priceOf(currentCase), () => _selectCase()),

            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.surfaceElevated,
              ),
              onPressed: _checkCompatibility,
              child: const Text('CHECK COMPATIBILITY RULES'),
            ),
            const SizedBox(height: 12),
            Text('Live Total: \$$totalCost.00', style: const TextStyle(fontFamily: 'Courier', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.neonGreen)),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableRow(String title, String name, int price, VoidCallback onTap) {
    final bool selected = name != 'Awaiting selection...';
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          selected ? Icons.check_circle : Icons.circle_outlined,
          color: selected ? AppColors.neonCyan : AppColors.textMuted,
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
            color: selected ? Colors.white : AppColors.textMuted,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Text(
          '\$${price}',
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

  int _priceOf(String name) {
    if (name == 'Awaiting selection...' || name.isEmpty) return 0;
    for (var c in cpus) if (c['name'] == name) return c['price'] as int;
    for (var m in motherboards) if (m['name'] == name) return m['price'] as int;
    for (var r in rams) if (r['name'] == name) return r['price'] as int;
    for (var g in gpus) if (g['name'] == name) return g['price'] as int;
    for (var s in storages) if (s['name'] == name) return s['price'] as int;
    for (var p in psus) if (p['name'] == name) return p['price'] as int;
    for (var c in cases) if (c['name'] == name) return c['price'] as int;
    return 0;
  }

  Future<void> _selectCpu() async {
    final selection = await showModalBottomSheet<String>(context: context, builder: (_) {
      return ListView(
        children: cpus.map((c) {
          return ListTile(
            title: Text(c['name']),
            subtitle: Text('${c['socket']} • \$${c['price']}'),
            onTap: () => Navigator.pop(context, c['name'] as String),
          );
        }).toList(),
      );
    });
    if (selection != null) {
      setState(() {
        currentCpu = selection;
        // auto-filter motherboard: pick first compatible if previous incompatible
        final cpu = _find(cpus, selection);
        final socket = cpu?['socket'];
        Map<String, dynamic>? firstCompat;
        if (socket != null) {
          try {
            firstCompat = motherboards.firstWhere((m) => m['socket'] == socket);
          } catch (e) {
            firstCompat = null;
          }
        }
        if (firstCompat != null) {
          currentMotherboard = firstCompat['name'] as String;
        } else {
          currentMotherboard = 'Awaiting selection...';
        }
        _computeTotal();
        isCompatible = false;
      });
    }
  }

  Future<void> _selectMotherboard() async {
    // filter by CPU socket if CPU selected
    String? cpuSocket;
    if (currentCpu != 'Awaiting selection...') {
      final cpu = _find(cpus, currentCpu);
      if (cpu != null) cpuSocket = cpu['socket'] as String;
    }
    final options = cpuSocket == null ? motherboards : motherboards.where((m) => m['socket'] == cpuSocket).toList();
    final selection = await showModalBottomSheet<String>(context: context, builder: (_) {
      return ListView(
        children: options.map((m) {
          return ListTile(
            title: Text(m['name']),
            subtitle: Text('${m['socket']} • \$${m['price']}'),
            onTap: () => Navigator.pop(context, m['name'] as String),
          );
        }).toList(),
      );
    });
    if (selection != null) {
      setState(() {
        currentMotherboard = selection;
        _computeTotal();
        isCompatible = false;
      });
    }
  }

  Future<void> _selectRam() async {
    final selection = await showModalBottomSheet<String>(context: context, builder: (_) {
      return ListView(children: rams.map((r) {
        return ListTile(
          title: Text(r['name']),
          subtitle: Text('${r['type']} • \$${r['price']}'),
          onTap: () => Navigator.pop(context, r['name'] as String),
        );
      }).toList());
    });
    if (selection != null) {
      setState(() {
        currentRam = selection;
        _computeTotal();
        isCompatible = false;
      });
    }
  }

  Future<void> _selectGpu() async {
    final selection = await showModalBottomSheet<String>(context: context, builder: (_) {
      return ListView(children: gpus.map((g) {
        return ListTile(
          title: Text(g['name']),
          subtitle: Text('TDP ${g['tdp']}W • \$${g['price']}'),
          onTap: () => Navigator.pop(context, g['name'] as String),
        );
      }).toList());
    });
    if (selection != null) {
      setState(() {
        currentGpu = selection;
        _computeTotal();
        isCompatible = false;
      });
    }
  }

  Future<void> _selectStorage() async {
    final selection = await showModalBottomSheet<String>(context: context, builder: (_) {
      return ListView(children: storages.map((s) {
        return ListTile(
          title: Text(s['name']),
          subtitle: Text('\$${s['price']}'),
          onTap: () => Navigator.pop(context, s['name'] as String),
        );
      }).toList());
    });
    if (selection != null) {
      setState(() {
        currentStorage = selection;
        _computeTotal();
        isCompatible = false;
      });
    }
  }

  Future<void> _selectPsu() async {
    final selection = await showModalBottomSheet<String>(context: context, builder: (_) {
      return ListView(children: psus.map((p) {
        return ListTile(
          title: Text(p['name']),
          subtitle: Text('${p['watt']}W • \$${p['price']}'),
          onTap: () => Navigator.pop(context, p['name'] as String),
        );
      }).toList());
    });
    if (selection != null) {
      setState(() {
        currentPsu = selection;
        _computeTotal();
        isCompatible = false;
      });
    }
  }

  Future<void> _selectCase() async {
    final selection = await showModalBottomSheet<String>(context: context, builder: (_) {
      return ListView(children: cases.map((c) {
        return ListTile(
          title: Text(c['name']),
          subtitle: Text('\$${c['price']}'),
          onTap: () => Navigator.pop(context, c['name'] as String),
        );
      }).toList());
    });
    if (selection != null) {
      setState(() {
        currentCase = selection;
        _computeTotal();
        isCompatible = false;
      });
    }
  }

  void _computeTotal() {
    totalCost = _priceOf(currentCpu) + _priceOf(currentMotherboard) + _priceOf(currentRam) + _priceOf(currentGpu) + _priceOf(currentStorage) + _priceOf(currentPsu) + _priceOf(currentCase);
  }

  Map<String, dynamic>? _find(List<Map<String, dynamic>> list, String name) {
    try {
      return list.firstWhere((e) => e['name'] == name);
    } catch (e) {
      return null;
    }
  }

  void _checkCompatibility() {
    // Basic rules:
    // - CPU socket must match motherboard socket
    // - PSU wattage must be >= estimated power (CPU tdp + GPU tdp + 150 other)
    bool socketOk = false;
    if (currentCpu != 'Awaiting selection...' && currentMotherboard != 'Awaiting selection...') {
      final cpu = _find(cpus, currentCpu);
      final mb = _find(motherboards, currentMotherboard);
      if (cpu != null && mb != null) socketOk = cpu['socket'] == mb['socket'];
    }

    int cpuTdp = 0;
    int gpuTdp = 0;
    if (currentCpu != 'Awaiting selection...') {
      final cpu = _find(cpus, currentCpu);
      if (cpu != null) cpuTdp = cpu['tdp'] as int;
    }
    if (currentGpu != 'Awaiting selection...') {
      final gpu = _find(gpus, currentGpu);
      if (gpu != null) gpuTdp = gpu['tdp'] as int;
    }

    final estimated = cpuTdp + gpuTdp + 150; // 150W for rest of system

    int psuWatt = 0;
    if (currentPsu != 'Awaiting selection...') {
      final p = _find(psus, currentPsu);
      if (p != null) psuWatt = p['watt'] as int;
    }

    final psuOk = psuWatt >= estimated && psuWatt > 0;

    setState(() {
      isCompatible = socketOk && psuOk;
    });
    final snack = isCompatible ? 'Build looks compatible!' : 'Incompatible: check socket or PSU wattage.';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snack)));
  }
}
