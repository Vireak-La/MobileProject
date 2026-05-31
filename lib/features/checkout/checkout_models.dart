import 'package:intl/intl.dart';

final NumberFormat moneyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

class CheckoutCartItem {
  const CheckoutCartItem({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.imageAsset,
    required this.compatibilityTag,
  });

  final String name;
  final String category;
  final double price;
  final int quantity;
  final String imageAsset;
  final String compatibilityTag;

  double get lineTotal => price * quantity;

  CheckoutCartItem copyWith({
    String? name,
    String? category,
    double? price,
    int? quantity,
    String? imageAsset,
    String? compatibilityTag,
  }) {
    return CheckoutCartItem(
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageAsset: imageAsset ?? this.imageAsset,
      compatibilityTag: compatibilityTag ?? this.compatibilityTag,
    );
  }
}

class CheckoutPricing {
  static const double taxRate = 0.08;
  static const double shippingThreshold = 1200.0;
  static const double standardShipping = 24.99;

  static double subtotal(List<CheckoutCartItem> items) => items.fold<double>(0, (sum, item) => sum + item.lineTotal);
  static double tax(double subtotal) => subtotal * taxRate;
  static double shipping(double subtotal) => subtotal >= shippingThreshold ? 0.0 : standardShipping;
  static double total(List<CheckoutCartItem> items) {
    final sub = subtotal(items);
    return sub + tax(sub) + shipping(sub);
  }
}

List<CheckoutCartItem> samplePcBuildItems() {
  return const [
    CheckoutCartItem(
      name: 'AMD Ryzen 7 7800X3D',
      category: 'CPU',
      price: 380.0,
      quantity: 1,
      imageAsset: 'assets/images/buildofthemonth.webp',
      compatibilityTag: 'AM5 SOCKET',
    ),
    CheckoutCartItem(
      name: 'MSI MAG B650 Tomahawk',
      category: 'Motherboard',
      price: 190.0,
      quantity: 1,
      imageAsset: 'assets/images/buildofthemonth.webp',
      compatibilityTag: 'AM5 READY',
    ),
    CheckoutCartItem(
      name: 'G.Skill Trident Z5 32GB DDR5',
      category: 'RAM',
      price: 90.0,
      quantity: 1,
      imageAsset: 'assets/images/buildofthemonth.webp',
      compatibilityTag: 'DDR5 6000',
    ),
    CheckoutCartItem(
      name: 'NVIDIA RTX 4070 Ti Super',
      category: 'GPU',
      price: 790.0,
      quantity: 1,
      imageAsset: 'assets/images/buildofthemonth.webp',
      compatibilityTag: '1440P ULTRA',
    ),
    CheckoutCartItem(
      name: 'Samsung 990 Pro 2TB NVMe',
      category: 'Storage',
      price: 140.0,
      quantity: 1,
      imageAsset: 'assets/images/buildofthemonth.webp',
      compatibilityTag: 'PCIe 4.0',
    ),
    CheckoutCartItem(
      name: 'Corsair RM750x 750W',
      category: 'PSU',
      price: 120.0,
      quantity: 1,
      imageAsset: 'assets/images/buildofthemonth.webp',
      compatibilityTag: '750W GOLD',
    ),
    CheckoutCartItem(
      name: 'Fractal Design Meshify C',
      category: 'Case',
      price: 100.0,
      quantity: 1,
      imageAsset: 'assets/images/gaming-computer-case-isolated-png.webp',
      compatibilityTag: 'MID-TOWER',
    ),
  ];
}
