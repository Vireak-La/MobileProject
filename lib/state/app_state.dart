import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../data/mock_repository.dart';
import '../features/checkout/checkout_models.dart';

class ChatMessage {
  final String sender; // 'user' or 'agent'
  final String text;
  final DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.text,
    required this.timestamp,
  });
}

enum AppScreen {
  home,
  pcBuilder,
  shop,
  gallery,
  profile,
  compare,
  cart,
  services,
  chat,
  aboutUs,
  helpSupport,
  dealsSales,
  community,
  savedBuilds,
}

class User {
  String name;
  String email;
  Uint8List? profileImageBytes;

  User({required this.name, required this.email, this.profileImageBytes});
}

class AppStateNotifier extends ChangeNotifier {
  // Navigation State
  AppScreen _currentScreen = AppScreen.home;
  AppScreen get currentScreen => _currentScreen;

  final List<AppScreen> _navigationHistory = [AppScreen.home];
  int get historyLength => _navigationHistory.length;

  void setScreen(AppScreen screen) {
    if (_currentScreen == screen) return;
    _currentScreen = screen;
    _navigationHistory.add(screen);
    notifyListeners();
  }

  bool goBack() {
    if (_navigationHistory.length > 1) {
      _navigationHistory.removeLast();
      _currentScreen = _navigationHistory.last;
      notifyListeners();
      return true;
    }
    return false;
  }

  // Repair tickets
  final List<RepairTicket> _tickets = MockRepository.getDefaultTickets();
  List<RepairTicket> get tickets => _tickets;

  // Chat message thread
  final List<ChatMessage> _chatMessages = [
    ChatMessage(
      sender: 'agent',
      text: 'Welcome to RGB Nexus Support! I am Cyber-Assistant V3. How can I help upgrade or repair your battle station today?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];
  List<ChatMessage> get chatMessages => _chatMessages;
  
  bool _isTyping = false;
  bool get isTyping => _isTyping;



  // Booking a new service
  String bookRepair({
    required String deviceName,
    required String issue,
    required String details,
    required DateTime date,
    required String timeSlot,
    required String name,
    required String email,
    required String phone,
  }) {
    final randomSuffix = Random().nextInt(900) + 100; // 100-999
    final ticketCode = 'RGB$randomSuffix';

    final newTicket = RepairTicket(
      ticketNumber: ticketCode,
      deviceName: deviceName,
      issueDescription: '$issue - $details',
      dateSubmitted: DateTime.now(),
      status: 'Received',
      notes: 'Customer scheduled drop-off for $timeSlot on ${date.month}/${date.day}/${date.year}. Contact: $phone',
      timeline: [
        TicketTimelineEvent(
          title: 'Request Received',
          description: 'Appointment booked online for drop-off.',
          timestamp: DateTime.now(),
        ),
        TicketTimelineEvent(
          title: 'Diagnostics',
          description: 'Awaiting device drop-off at store.',
          timestamp: date,
          isCompleted: false,
        ),
        TicketTimelineEvent(
          title: 'Parts Sourcing',
          description: 'Pending evaluation.',
          timestamp: date,
          isCompleted: false,
        ),
        TicketTimelineEvent(
          title: 'Repairing',
          description: 'Pending evaluation.',
          timestamp: date,
          isCompleted: false,
        ),
        TicketTimelineEvent(
          title: 'Testing',
          description: 'Pending evaluation.',
          timestamp: date,
          isCompleted: false,
        ),
        TicketTimelineEvent(
          title: 'Ready for Pickup',
          description: 'Pending evaluation.',
          timestamp: date,
          isCompleted: false,
        ),
      ],
    );

    _tickets.insert(0, newTicket);
    notifyListeners();
    return ticketCode;
  }

  // Support chat interaction
  void sendChatMessage(String messageText) {
    _chatMessages.add(
      ChatMessage(sender: 'user', text: messageText, timestamp: DateTime.now()),
    );
    notifyListeners();

    // Trigger typing auto reply
    _isTyping = true;
    notifyListeners();

    Timer(const Duration(milliseconds: 1200), () {
      _isTyping = false;
      String responseText = "Thanks for asking! That's a good question. Let me connect you to our hardware experts, or you can search under the Tracker tab.";
      
      final query = messageText.toLowerCase();
      if (query.contains('repair') || query.contains('track') || query.contains('status')) {
        responseText = "To track a repair, navigate to the Services tab, enter your 6-digit ticket code (e.g. RGB123) in the search field, and view the timeline status.";
      } else if (query.contains('hour') || query.contains('time') || query.contains('open')) {
        responseText = "Our flagship branch is open 9:00 AM - 10:00 PM daily. Check our 'Locations' map tab for exact hours and stocks of other service locations.";
      } else if (query.contains('compatible') || query.contains('build') || query.contains('parts')) {
        responseText = "Our intelligent PC Builder tool highlights any potential incompatibilities (such as DDR4 memory with a DDR5 motherboard) as you design your rig.";
      } else if (query.contains('price') || query.contains('cost') || query.contains('repaste')) {
        responseText = "Thermal repasting and cleanup starts at just \$29. Full component upgrades are \$49 flat labor rate if parts are purchased from us.";
      }

      _chatMessages.add(
        ChatMessage(sender: 'agent', text: responseText, timestamp: DateTime.now()),
      );
      notifyListeners();
    });
  }



  // Saved Builds State
  final List<SavedBuild> _savedBuilds = [
    SavedBuild(
      id: 'build-1',
      name: 'PROJECT VORTEX // RTX 4090',
      date: DateTime.now().subtract(const Duration(days: 3)),
      totalPrice: 2859.00,
      components: {
        'CPU': 'AMD Ryzen 9 7950X',
        'Motherboard': 'ASUS ROG Strix B650E',
        'RAM': 'G.Skill Trident Z5 32GB DDR5',
        'GPU': 'NVIDIA RTX 4090',
        'Storage': 'Samsung 990 Pro 2TB NVMe',
        'PSU': 'Corsair RM1000x 1000W',
        'Case': 'Fractal Design Meshify C',
      },
    ),
    SavedBuild(
      id: 'build-2',
      name: 'CYBER-PULSE CORES // DDR5',
      date: DateTime.now().subtract(const Duration(days: 10)),
      totalPrice: 1534.00,
      components: {
        'CPU': 'Intel Core i7-13700K',
        'Motherboard': 'MSI PRO Z790-A',
        'RAM': 'Corsair Dominator Platinum 32GB DDR5',
        'GPU': 'NVIDIA RTX 4070 Ti Super',
        'Storage': 'Crucial P3 1TB NVMe',
        'PSU': 'Corsair RM750x 750W',
        'Case': 'Fractal Design Meshify C',
      },
    ),
  ];
  List<SavedBuild> get savedBuilds => _savedBuilds;

  Map<String, String>? _loadedBuildComponents;
  Map<String, String>? get loadedBuildComponents => _loadedBuildComponents;

  void deleteSavedBuild(String id) {
    _savedBuilds.removeWhere((build) => build.id == id);
    notifyListeners();
  }

  void addSavedBuild(String name, Map<String, String> components, double totalPrice) {
    _savedBuilds.insert(
      0,
      SavedBuild(
        id: 'build-${DateTime.now().millisecondsSinceEpoch}',
        name: name.toUpperCase(),
        date: DateTime.now(),
        components: components,
        totalPrice: totalPrice,
      ),
    );
    notifyListeners();
  }

  void loadBuildIntoBuilder(Map<String, String> components) {
    _loadedBuildComponents = components;
    _currentScreen = AppScreen.pcBuilder;
    notifyListeners();
  }

  void clearLoadedBuild() {
    _loadedBuildComponents = null;
  }

  // 2. Define the private variables
  User? _currentUser = User(name: "Im Chheangngim", email: "ngim@gmail.com");
  bool _notificationsEnabled = true;

  // 3. Define the public getters
  User? get currentUser => _currentUser;
  bool get notificationsEnabled => _notificationsEnabled;

  // 4. Define the methods used in your UI
  void toggleNotifications(bool val) {
    _notificationsEnabled = val;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void updateName(String newName) {
    if (_currentUser != null) {
      _currentUser = User(name: newName, email: _currentUser!.email);
      notifyListeners();
    }
  }

  void updateProfile(String newName, Uint8List? newImageBytes) {
    if (_currentUser != null) { 
      _currentUser!.name = newName;
      if (newImageBytes != null) _currentUser!.profileImageBytes = newImageBytes;
      notifyListeners();
    }
  }

  // --- Cart & Order History State Management ---
  final List<CheckoutCartItem> _cartItems = List<CheckoutCartItem>.from(samplePcBuildItems());
  List<CheckoutCartItem> get cartItems => _cartItems;

  final List<MockOrder> _orderHistory = [
    MockOrder(
      orderId: 'NEXUS-8812',
      date: DateTime.now().subtract(const Duration(days: 12)),
      total: 1079.00,
      status: 'DELIVERED',
      items: [
        const CheckoutCartItem(
          name: 'Intel Core i7-13700K',
          category: 'CPU',
          price: 420.00,
          quantity: 1,
          imageAsset: '',
          compatibilityTag: 'LGA1700',
        ),
        const CheckoutCartItem(
          name: 'NVIDIA RTX 4070',
          category: 'GPU',
          price: 599.00,
          quantity: 1,
          imageAsset: '',
          compatibilityTag: 'PCIe',
        ),
        const CheckoutCartItem(
          name: 'Crucial P3 1TB NVMe',
          category: 'Storage',
          price: 55.00,
          quantity: 1,
          imageAsset: '',
          compatibilityTag: 'M.2',
        ),
      ],
    ),
  ];
  List<MockOrder> get orderHistory => _orderHistory;

  void addToCart(CheckoutCartItem item) {
    final existingIndex = _cartItems.indexWhere((i) => i.name == item.name);
    if (existingIndex >= 0) {
      final existing = _cartItems[existingIndex];
      _cartItems[existingIndex] = existing.copyWith(quantity: existing.quantity + item.quantity);
    } else {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(String name) {
    _cartItems.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  void updateCartItemQuantity(String name, int newQty) {
    final idx = _cartItems.indexWhere((item) => item.name == name);
    if (idx >= 0) {
      if (newQty <= 0) {
        _cartItems.removeAt(idx);
      } else {
        _cartItems[idx] = _cartItems[idx].copyWith(quantity: newQty);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  String placeOrder() {
    if (_cartItems.isEmpty) return '';
    final orderId = 'NEXUS-${Random().nextInt(9000) + 1000}';
    final total = CheckoutPricing.total(_cartItems);
    
    _orderHistory.insert(
      0,
      MockOrder(
        orderId: orderId,
        date: DateTime.now(),
        total: total,
        status: 'PROCESSING',
        items: List<CheckoutCartItem>.from(_cartItems),
      ),
    );
    
    _cartItems.clear();
    notifyListeners();
    return orderId;
  }

  void loadComponentIntoBuilder(String category, String name) {
    _loadedBuildComponents ??= {};
    _loadedBuildComponents![category] = name;
    _currentScreen = AppScreen.pcBuilder;
    notifyListeners();
  }
}

class MockOrder {
  final String orderId;
  final DateTime date;
  final double total;
  final String status;
  final List<CheckoutCartItem> items;

  MockOrder({
    required this.orderId,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
  });
}

class SavedBuild {
  final String id;
  final String name;
  final DateTime date;
  final Map<String, String> components;
  final double totalPrice;

  SavedBuild({
    required this.id,
    required this.name,
    required this.date,
    required this.components,
    required this.totalPrice,
  });
}