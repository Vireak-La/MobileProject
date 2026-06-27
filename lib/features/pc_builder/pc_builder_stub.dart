import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../checkout/checkout_models.dart';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';
import '../../state/app_state.dart';
import '../../data/product_repository.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = Provider.of<AppStateNotifier>(context, listen: false);
    if (appState.loadedBuildComponents != null) {
      final build = appState.loadedBuildComponents!;
      setState(() {
        currentCpu = build['CPU'] ?? 'Awaiting selection...';
        currentMotherboard = build['Motherboard'] ?? 'Awaiting selection...';
        currentRam = build['RAM'] ?? 'Awaiting selection...';
        currentGpu = build['GPU'] ?? 'Awaiting selection...';
        currentStorage = build['Storage'] ?? 'Awaiting selection...';
        currentPsu = build['PSU'] ?? 'Awaiting selection...';
        currentCase = build['Case'] ?? 'Awaiting selection...';
        _computeTotal();
        _checkCompatibilitySilent();
      });
      appState.clearLoadedBuild();
    }
  }

  void _checkCompatibilitySilent() {
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

    final estimated = cpuTdp + gpuTdp + 150;

    int psuWatt = 0;
    if (currentPsu != 'Awaiting selection...') {
      final p = _find(psus, currentPsu);
      if (p != null) psuWatt = p['watt'] as int;
    }

    final psuOk = psuWatt >= estimated && psuWatt > 0;

    isCompatible = socketOk && psuOk;
  }

  List<Map<String, dynamic>> get cpus => ProductRepository.cpus;
  List<Map<String, dynamic>> get motherboards => ProductRepository.motherboards;
  List<Map<String, dynamic>> get rams => ProductRepository.rams;
  List<Map<String, dynamic>> get gpus => ProductRepository.gpus;
  List<Map<String, dynamic>> get storages => ProductRepository.storages;
  List<Map<String, dynamic>> get psus => ProductRepository.psus;
  List<Map<String, dynamic>> get cases => ProductRepository.cases;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CyberDrawer(),
      appBar: AppBar(
        title: const Text('CUSTOM RIG BUILDER'),
        actions: [
          IconButton(
            tooltip: 'Open cart',
            onPressed: () {
              context.push('/cart');
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
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: totalCost.toDouble()),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Text(
                            '\$${value.toStringAsFixed(0)}.00',
                            style: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.neonCyan,
                            ),
                          );
                        },
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
            const SizedBox(height: 10),
            Semantics(
              label: 'Add currently selected components to shopping cart',
              button: true,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 35),
                  backgroundColor: AppColors.surfaceElevated,
                ),
                onPressed: _atc,
                child: const Text('ADD TO CART'),
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

            const SizedBox(height: 10),
            Semantics(
              label: 'Verify CPU socket and PSU wattage compatibility rules',
              button: true,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 35),
                  backgroundColor: AppColors.surfaceElevated,
                ),
                onPressed: _checkCompatibility,
                child: const Text('CHECK COMPATIBILITY RULES'),
              ),
            ),

            const SizedBox(height: 10),
            Semantics(
              label: 'Open saved build configurations manager',
              button: true,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 35),
                  backgroundColor: AppColors.surfaceElevated,
                ),
                onPressed: _savedBuilds,
                child: const Text('SAVE BUILDS'),
              ),
            ),
            
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Live Total: ', 
                  style: TextStyle(
                    fontFamily: 'Courier', 
                    fontSize: 16, 
                    fontWeight: FontWeight.bold, 
                    color: AppColors.textPrimary,
                  ),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: totalCost.toDouble()),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Text(
                      '\$${value.toStringAsFixed(0)}.00', 
                      style: const TextStyle(
                        fontFamily: 'Courier', 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: AppColors.neonGreen,
                      ),
                    );
                  },
                ),
              ],
            ),
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
          '\$$price',
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
    for (var c in cpus) {
      if (c['name'] == name) return c['price'] as int;
    }
    for (var m in motherboards) {
      if (m['name'] == name) return m['price'] as int;
    }
    for (var r in rams) {
      if (r['name'] == name) return r['price'] as int;
    }
    for (var g in gpus) {
      if (g['name'] == name) return g['price'] as int;
    }
    for (var s in storages) {
      if (s['name'] == name) return s['price'] as int;
    }
    for (var p in psus) {
      if (p['name'] == name) return p['price'] as int;
    }
    for (var c in cases) {
      if (c['name'] == name) return c['price'] as int;
    }
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
  // 1. Create a controller to track the text input
final TextEditingController _buildNameController = TextEditingController();

void _savedBuilds() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Save Build'),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Keeps the lightbox compact
          children: [
            const Text('Enter build name:'),
            const SizedBox(height: 10),
            TextField(
              controller: _buildNameController,
              decoration: const InputDecoration(
                hintText: 'e.g., Ultimate Gaming Setup',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () {
              _buildNameController.clear(); // Clear input
              Navigator.of(context).pop();  // Close lightbox
            },
            child: const Text('CANCEL'),
          ),
          // Save Button
          ElevatedButton(
            onPressed: () {
              String enteredName = _buildNameController.text;
              
              if (enteredName.trim().isNotEmpty) {
                final Map<String, String> components = {
                  'CPU': currentCpu,
                  'Motherboard': currentMotherboard,
                  'RAM': currentRam,
                  'GPU': currentGpu,
                  'Storage': currentStorage,
                  'PSU': currentPsu,
                  'Case': currentCase,
                };
                
                Provider.of<AppStateNotifier>(context, listen: false).addSavedBuild(
                  enteredName,
                  components,
                  totalCost.toDouble(),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Build Added to Saved Builds')),
                );

                _buildNameController.clear(); // Clear input
                Navigator.of(context).pop();  // Close lightbox
              }
            },
            child: const Text('SAVE BUILD'),
          ),
        ],
      );
    },
  );
}

// 2. Remember to dispose of the controller when the widget is destroyed
@override
void dispose() {
  _buildNameController.dispose();
  super.dispose();
}

  void _atc() {
    final appState = Provider.of<AppStateNotifier>(context, listen: false);
    int addedCount = 0;

    void addIfSelected(String category, String name) {
      if (name != 'Awaiting selection...') {
        final price = _priceOf(name).toDouble();
        appState.addToCart(CheckoutCartItem(
          name: name,
          category: category,
          price: price,
          quantity: 1,
          imageAsset: '',
          compatibilityTag: category == 'CPU' ? 'AM5' : 'PCIe',
        ));
        addedCount++;
      }
    }

    addIfSelected('CPU', currentCpu);
    addIfSelected('Motherboard', currentMotherboard);
    addIfSelected('RAM', currentRam);
    addIfSelected('GPU', currentGpu);
    addIfSelected('Storage', currentStorage);
    addIfSelected('PSU', currentPsu);
    addIfSelected('Case', currentCase);

    if (addedCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added $addedCount components to cart!'),
          duration: const Duration(seconds: 1),
          action: SnackBarAction(
            label: 'VIEW CART',
            textColor: AppColors.neonCyan,
            onPressed: () {
              if (mounted) {
                context.push('/cart');
              }
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one component first.'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
