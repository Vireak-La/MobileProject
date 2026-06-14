import 'package:flutter/material.dart';
import 'dart:math';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';
import '../checkout/cart.dart';

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

  // Data copied from pc_builder_stub.dart
  final List<Map<String, dynamic>> cpus = [
    {'name': 'AMD Ryzen 9 7950X', 'price': 699, 'category': 'CPU'},
    {'name': 'AMD Ryzen 7 7800X3D', 'price': 380, 'category': 'CPU'},
    {'name': 'AMD Ryzen 5 7600X', 'price': 229, 'category': 'CPU'},
    {'name': 'AMD Ryzen 5 7600', 'price': 220, 'category': 'CPU'},
    {'name': 'Intel Core i9-13900K', 'price': 589, 'category': 'CPU'},
    {'name': 'Intel Core i7-13700K', 'price': 420, 'category': 'CPU'},
    {'name': 'Intel Core i5-13600K', 'price': 319, 'category': 'CPU'},
    {'name': 'Intel Core i5-12400F', 'price': 179, 'category': 'CPU'},
    {'name': 'AMD Ryzen 7 7700X', 'price': 349, 'category': 'CPU'},
    {'name': 'Intel Core i3-13100', 'price': 119, 'category': 'CPU'},
  ];

  final List<Map<String, dynamic>> motherboards = [
    {'name': 'MSI MAG B650 Tomahawk', 'price': 190, 'category': 'Motherboard'},
    {'name': 'ASUS ROG Strix B650E', 'price': 320, 'category': 'Motherboard'},
    {'name': 'ASUS PRIME X670-P', 'price': 240, 'category': 'Motherboard'},
    {'name': 'Gigabyte X670 AORUS Elite', 'price': 260, 'category': 'Motherboard'},
    {'name': 'ASRock B650M Steel Legend', 'price': 150, 'category': 'Motherboard'},
    {'name': 'ASUS PRIME Z790-P', 'price': 210, 'category': 'Motherboard'},
    {'name': 'MSI PRO Z790-A', 'price': 200, 'category': 'Motherboard'},
    {'name': 'Gigabyte Z790 UD AX', 'price': 190, 'category': 'Motherboard'},
    {'name': 'ASRock Z790 Phantom Gaming', 'price': 280, 'category': 'Motherboard'},
    {'name': 'MSI MAG B660 Tomahawk', 'price': 160, 'category': 'Motherboard'},
  ];

  final List<Map<String, dynamic>> rams = [
    {'name': 'G.Skill Trident Z5 32GB DDR5', 'price': 90, 'category': 'RAM'},
    {'name': 'Corsair Vengeance 32GB DDR4', 'price': 75, 'category': 'RAM'},
    {'name': 'Kingston Fury Beast 32GB DDR5', 'price': 95, 'category': 'RAM'},
    {'name': 'Crucial Ballistix 16GB DDR4', 'price': 45, 'category': 'RAM'},
    {'name': 'Corsair Dominator Platinum 32GB DDR5', 'price': 150, 'category': 'RAM'},
    {'name': 'Team T-Force Delta 32GB DDR5', 'price': 85, 'category': 'RAM'},
    {'name': 'Patriot Viper 32GB DDR4', 'price': 70, 'category': 'RAM'},
    {'name': 'Samsung 32GB DDR5 RDIMM', 'price': 130, 'category': 'RAM'},
    {'name': 'ADATA XPG Lancer 16GB DDR5', 'price': 50, 'category': 'RAM'},
    {'name': 'Thermaltake TOUGHRAM 32GB DDR4', 'price': 80, 'category': 'RAM'},
  ];

  final List<Map<String, dynamic>> gpus = [
    {'name': 'NVIDIA RTX 4090', 'price': 1599, 'category': 'GPU'},
    {'name': 'NVIDIA RTX 4080', 'price': 1199, 'category': 'GPU'},
    {'name': 'NVIDIA RTX 4070 Ti Super', 'price': 790, 'category': 'GPU'},
    {'name': 'NVIDIA RTX 4070', 'price': 599, 'category': 'GPU'},
    {'name': 'NVIDIA RTX 4060 Ti', 'price': 399, 'category': 'GPU'},
    {'name': 'NVIDIA RTX 3060', 'price': 330, 'category': 'GPU'},
    {'name': 'AMD Radeon RX 7900 XTX', 'price': 999, 'category': 'GPU'},
    {'name': 'AMD Radeon RX 7800 XT', 'price': 499, 'category': 'GPU'},
    {'name': 'AMD Radeon RX 7600', 'price': 249, 'category': 'GPU'},
    {'name': 'NVIDIA GTX 1660 Super', 'price': 219, 'category': 'GPU'},
  ];

  final List<Map<String, dynamic>> storages = [
    {'name': 'Samsung 990 Pro 2TB NVMe', 'price': 140, 'category': 'Storage'},
    {'name': 'Crucial P3 1TB NVMe', 'price': 55, 'category': 'Storage'},
    {'name': 'Western Digital Black SN850 1TB', 'price': 120, 'category': 'Storage'},
    {'name': 'Sabrent Rocket 4 Plus 2TB', 'price': 230, 'category': 'Storage'},
    {'name': 'Kingston KC3000 1TB', 'price': 110, 'category': 'Storage'},
    {'name': 'Samsung 870 EVO 1TB SATA', 'price': 80, 'category': 'Storage'},
    {'name': 'Crucial MX500 2TB SATA', 'price': 150, 'category': 'Storage'},
    {'name': 'Seagate Barracuda 2TB HDD', 'price': 60, 'category': 'Storage'},
    {'name': 'WD Blue SN570 1TB', 'price': 65, 'category': 'Storage'},
    {'name': 'ADATA XPG SX8200 1TB', 'price': 70, 'category': 'Storage'},
  ];

  final List<Map<String, dynamic>> psus = [
    {'name': 'Corsair RM1000x 1000W', 'price': 200, 'category': 'PSU'},
    {'name': 'Seasonic PRIME 1000W', 'price': 220, 'category': 'PSU'},
    {'name': 'Corsair RM850x 850W', 'price': 150, 'category': 'PSU'},
    {'name': 'Corsair RM750x 750W', 'price': 120, 'category': 'PSU'},
    {'name': 'EVGA 750W Gold', 'price': 110, 'category': 'PSU'},
    {'name': 'EVGA 650W Gold', 'price': 90, 'category': 'PSU'},
    {'name': 'Cooler Master 850W Gold', 'price': 130, 'category': 'PSU'},
    {'name': 'Thermaltake 750W', 'price': 95, 'category': 'PSU'},
    {'name': 'BeQuiet! 650W', 'price': 105, 'category': 'PSU'},
    {'name': 'Antec NE750 750W', 'price': 85, 'category': 'PSU'},
  ];

  final List<Map<String, dynamic>> cases = [
    {'name': 'NZXT H510', 'price': 70, 'category': 'Case'},
    {'name': 'Fractal Design Meshify C', 'price': 100, 'category': 'Case'},
    {'name': 'Corsair 4000D', 'price': 95, 'category': 'Case'},
    {'name': 'Lian Li Lancool II', 'price': 120, 'category': 'Case'},
    {'name': 'Cooler Master NR600', 'price': 60, 'category': 'Case'},
    {'name': 'Phanteks Eclipse P400A', 'price': 80, 'category': 'Case'},
    {'name': 'BeQuiet! Pure Base 500DX', 'price': 110, 'category': 'Case'},
    {'name': 'Thermaltake Divider 300', 'price': 85, 'category': 'Case'},
    {'name': 'SilverStone RL06', 'price': 65, 'category': 'Case'},
    {'name': 'DeepCool Matrexx 55', 'price': 55, 'category': 'Case'},
  ];

  @override
  void initState() {
    super.initState();
    final random = Random();
    for (var item in allItems) {
      if (!item.containsKey('rating')) {
        item['rating'] = random.nextInt(5) + 1;
      }
    }
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
    return Card(
      color: AppColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.surfaceElevated),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Icon(
                Icons.computer,
                size: 60,
                color: AppColors.neonMagenta,
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
                  item['name'],
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${item['name']} added to cart')),
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
                      icon: const Icon(
                        Icons.favorite_border,
                        color: AppColors.neonMagenta,
                        size: 20,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item['name']} favorited')),
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
    );
  }
}
