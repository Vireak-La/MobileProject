import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';
import '../checkout/checkout_models.dart';
import '../../state/app_state.dart';
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
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ProductCard(item: item);
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
    final appState = Provider.of<AppStateNotifier>(context);
    final String name = item['name'] ?? '';
    final isFavorited = appState.favoriteProductIds.contains(name);

    return Card(
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
                  child: Image.network(
                    item['imageUrl'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.computer,
                      size: 48,
                      color: AppColors.neonCyan.withOpacity(0.5),
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Star Rating
                  Row(
                    children: List.generate(5, (index) {
                      int rating = item['rating'] ?? 5;
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        size: 14,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  
                  // Price
                  Text(
                    '\$${item['price']}',
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neonGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Add to cart
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            backgroundColor: AppColors.neonCyan,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(0, 32),
                          ),
                          onPressed: () {
                            appState.addToCart(CheckoutCartItem(
                              name: name,
                              category: item['category'] ?? 'Component',
                              price: (item['price'] as num).toDouble(),
                              quantity: 1,
                              imageAsset: '',
                              compatibilityTag: item['category'] == 'CPU' ? 'AM5' : 'PCIe',
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$name added to cart')),
                            );
                          },
                          child: const Text(
                            'ADD',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Favorite
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: AppColors.neonMagenta,
                          size: 20,
                        ),
                        onPressed: () {
                          appState.toggleFavorite(name);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isFavorited 
                                  ? 'REMOVED $name FROM FAVORITES' 
                                  : 'ADDED $name TO FAVORITES'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
