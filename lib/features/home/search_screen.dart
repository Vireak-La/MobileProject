import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../data/product_repository.dart';

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

  List<Map<String, dynamic>> get _catalog => ProductRepository.allProducts;

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
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 48,
                              height: 48,
                              color: AppColors.surfaceElevated,
                              child: Image.network(
                                item['imageUrl'] ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => const Icon(
                                  Icons.computer,
                                  color: AppColors.neonCyan,
                                ),
                              ),
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
