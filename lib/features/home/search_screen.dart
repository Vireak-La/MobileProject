import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  // Use product categories matching the ProductPage
  final List<String> _categories = [
    'All',
    'CPU',
    'Motherboard',
    'RAM',
    'PSU',
    'GPU',
    'Storage',
    'Case'
  ];

  // Static product list sourced from the app catalog
  final List<Map<String, dynamic>> _catalog = [
    // CPUs
    {'name': 'AMD Ryzen 9 7950X', 'price': 699, 'category': 'CPU', 'rating': 5},
    {'name': 'AMD Ryzen 7 7800X3D', 'price': 380, 'category': 'CPU', 'rating': 5},
    {'name': 'AMD Ryzen 5 7600X', 'price': 229, 'category': 'CPU', 'rating': 4},
    {'name': 'Intel Core i9-13900K', 'price': 589, 'category': 'CPU', 'rating': 5},
    {'name': 'Intel Core i7-13700K', 'price': 420, 'category': 'CPU', 'rating': 4},
    // GPUs
    {'name': 'NVIDIA RTX 4090', 'price': 1599, 'category': 'GPU', 'rating': 5},
    {'name': 'NVIDIA RTX 4080', 'price': 1199, 'category': 'GPU', 'rating': 5},
    {'name': 'NVIDIA RTX 4070 Ti Super', 'price': 790, 'category': 'GPU', 'rating': 4},
    {'name': 'AMD Radeon RX 7900 XTX', 'price': 999, 'category': 'GPU', 'rating': 5},
    // Motherboards
    {'name': 'MSI MAG B650 Tomahawk', 'price': 190, 'category': 'Motherboard', 'rating': 4},
    {'name': 'ASUS ROG Strix B650E', 'price': 320, 'category': 'Motherboard', 'rating': 5},
    {'name': 'ASUS PRIME Z790-P', 'price': 210, 'category': 'Motherboard', 'rating': 4},
    // RAMs
    {'name': 'G.Skill Trident Z5 32GB DDR5', 'price': 90, 'category': 'RAM', 'rating': 5},
    {'name': 'Corsair Vengeance 32GB DDR4', 'price': 75, 'category': 'RAM', 'rating': 4},
    // Storages
    {'name': 'Samsung 990 Pro 2TB NVMe', 'price': 140, 'category': 'Storage', 'rating': 5},
    {'name': 'Crucial P3 1TB NVMe', 'price': 55, 'category': 'Storage', 'rating': 4},
    // PSUs
    {'name': 'Corsair RM1000x 1000W', 'price': 200, 'category': 'PSU', 'rating': 5},
    {'name': 'Seasonic PRIME 1000W', 'price': 220, 'category': 'PSU', 'rating': 5},
    // Cases
    {'name': 'NZXT H510', 'price': 70, 'category': 'Case', 'rating': 4},
    {'name': 'Fractal Design Meshify C', 'price': 100, 'category': 'Case', 'rating': 5},
  ];

  List<Map<String, dynamic>> get _searchResults {
    return _catalog.where((item) {
      final matchesQuery = item['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item['category'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || item['category'] == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _searchResults;

    return Scaffold(
      backgroundColor: const Color(0xFF0C0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white, fontFamily: 'Courier'),
          decoration: InputDecoration(
            hintText: 'SEARCH MATRIX...',
            hintStyle: const TextStyle(color: Colors.white38, fontFamily: 'Courier'),
            border: InputBorder.none,
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.neonCyan),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
          ),
          onChanged: (val) {
            setState(() {
              _searchQuery = val;
            });
          },
        ),
      ),
      body: Column(
        children: [
          // Horizontal Category filter chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.black : Colors.white,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.neonCyan,
                    backgroundColor: AppColors.surfaceElevated,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          
          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'RESULTS FOUND: ${results.length}',
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Results list
          Expanded(
            child: results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.search_off, size: 64, color: AppColors.neonMagenta),
                        SizedBox(height: 16),
                        Text(
                          'NO MATCHES IN DATABASE',
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final item = results[index];
                      return Card(
                        color: AppColors.surfaceCard,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: AppColors.surfaceElevated),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceElevated,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.computer,
                              color: AppColors.neonCyan,
                            ),
                          ),
                          title: Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'CATEGORY: ${item['category']}',
                              style: const TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          trailing: Text(
                            '\$${item['price']}',
                            style: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.neonGreen,
                            ),
                          ),
                          onTap: () {
                            context.push('/product-detail', extra: item);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
