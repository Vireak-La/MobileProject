import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';
import '../../data/product_repository.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String selectedCategory = 'All';
  String sortBy = 'None';
  int minRating = 0;
  final List<String> categories = [
    'All',
    'CPU',
    'Motherboard',
    'RAM',
    'PSU',
    'GPU',
    'Storage',
    'Case'
  ];

  List<Map<String, dynamic>> get cpus => ProductRepository.cpus;
  List<Map<String, dynamic>> get motherboards => ProductRepository.motherboards;
  List<Map<String, dynamic>> get rams => ProductRepository.rams;
  List<Map<String, dynamic>> get gpus => ProductRepository.gpus;
  List<Map<String, dynamic>> get storages => ProductRepository.storages;
  List<Map<String, dynamic>> get psus => ProductRepository.psus;
  List<Map<String, dynamic>> get cases => ProductRepository.cases;

  @override
  void initState() {
    super.initState();
  }

  List<Map<String, dynamic>> get allItems {
    return [
      ...cpus,
      ...motherboards,
      ...rams,
      ...gpus,
      ...storages,
      ...psus,
      ...cases,
    ];
  }

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> result = allItems;
    if (selectedCategory != 'All') {
      result = result.where((item) => item['category'] == selectedCategory).toList();
    }
    if (minRating > 0) {
      result = result.where((item) => (item['rating'] ?? 0) == minRating).toList();
    }
    if (sortBy == 'Price: Low to High') {
      result.sort((a, b) => (a['price'] as int).compareTo(b['price'] as int));
    } else if (sortBy == 'Price: High to Low') {
      result.sort((a, b) => (b['price'] as int).compareTo(a['price'] as int));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredItems;

    return Scaffold(
      drawer: const CyberDrawer(),
      appBar: AppBar(
        title: const Text('PRODUCTS'),
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
      body: Column(
        children: [
          // Topbar Category Carousel
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        fontFamily: 'Courier',
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
                          selectedCategory = category;
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          
          // Filters Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: sortBy,
                  dropdownColor: AppColors.surfaceElevated,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  items: ['None', 'Price: Low to High', 'Price: High to Low']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => sortBy = val);
                  },
                ),
                DropdownButton<int>(
                  value: minRating,
                  dropdownColor: AppColors.surfaceElevated,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  items: [0, 1, 2, 3, 4, 5]
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e == 0 ? 'All Ratings' : '$e Stars')))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => minRating = val);
                  },
                ),
              ],
            ),
          ),

          // Products Grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                int crossAxisCount = 2;
                double childAspectRatio = 0.62;
                if (width > 1200) {
                  crossAxisCount = 5;
                  childAspectRatio = 0.65;
                } else if (width > 900) {
                  crossAxisCount = 4;
                  childAspectRatio = 0.65;
                } else if (width > 600) {
                  crossAxisCount = 3;
                  childAspectRatio = 0.63;
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ProductCard(item: item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final String name = item['name'] ?? '';

    return Semantics(
      label: 'Product card for $name',
      button: true,
      child: Card(
        color: AppColors.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.surfaceElevated),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.push('/product-detail', extra: item);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFF1E2B40),
                    child: Hero(
                      tag: 'product-image-${item['name']}',
                      child: Image.network(
                        item['imageUrl'] ?? '',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const ShimmerSkeleton(width: double.infinity, height: double.infinity);
                        },
                        errorBuilder: (_, _, _) => Icon(
                          Icons.computer,
                          size: 48,
                          color: AppColors.neonCyan.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    
                    // Category & Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['category']?.toString().toUpperCase() ?? '',
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 9,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '\$${item['price'] ?? 0}',
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neonGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    
                    // Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Star rating
                        Row(
                          children: List.generate(5, (starIndex) {
                            final rating = item['rating'] ?? 5;
                            return Icon(
                              starIndex < rating ? Icons.star : Icons.star_border,
                              color: Colors.orangeAccent,
                              size: 10,
                            );
                          }),
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
    );
  }
}

class ShimmerSkeleton extends StatefulWidget {
  const ShimmerSkeleton({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: 0.3 + 0.4 * _controller.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2B40),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
