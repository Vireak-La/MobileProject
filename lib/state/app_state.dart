import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../data/mock_repository.dart';

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

  // Favorites
  final List<String> _favoriteProductIds = [];
  List<String> get favoriteProductIds => _favoriteProductIds;

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

  // Handle Favorites toggle
  void toggleFavorite(String productId) {
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
    notifyListeners();
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