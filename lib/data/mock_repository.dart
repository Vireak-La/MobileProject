import 'package:latlong2/latlong.dart';

class Branch {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String hours;
  final LatLng location;
  final double distance; // in km
  final int availableStock;
  final bool hasServiceCenter;
  final double rating;

  Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.hours,
    required this.location,
    required this.distance,
    required this.availableStock,
    required this.hasServiceCenter,
    required this.rating,
  });
}

class RepairTicket {
  final String ticketNumber;
  final String deviceName;
  final String issueDescription;
  final DateTime dateSubmitted;
  final String status; // 'Received', 'Diagnostics', 'Parts Sourcing', 'Repairing', 'Testing', 'Ready'
  final List<TicketTimelineEvent> timeline;
  final String notes;

  RepairTicket({
    required this.ticketNumber,
    required this.deviceName,
    required this.issueDescription,
    required this.dateSubmitted,
    required this.status,
    required this.timeline,
    required this.notes,
  });

  RepairTicket copyWith({
    String? status,
    List<TicketTimelineEvent>? timeline,
  }) {
    return RepairTicket(
      ticketNumber: ticketNumber,
      deviceName: deviceName,
      issueDescription: issueDescription,
      dateSubmitted: dateSubmitted,
      status: status ?? this.status,
      timeline: timeline ?? this.timeline,
      notes: notes,
    );
  }
}

class TicketTimelineEvent {
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isCompleted;

  TicketTimelineEvent({
    required this.title,
    required this.description,
    required this.timestamp,
    this.isCompleted = true,
  });
}

class GalleryItem {
  final String id;
  final String title;
  final String author;
  final String description;
  final String thumbnailUrl;
  final String? videoUrl; // Null if it's only an image
  final bool isVideo;
  final List<String> tags;
  final int likes;
  final int views;

  GalleryItem({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.thumbnailUrl,
    this.videoUrl,
    required this.isVideo,
    required this.tags,
    required this.likes,
    required this.views,
  });
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

class MockRepository {
  // 1. Store Branches & Locations (mocked coordinate offsets relative to center)
  static List<Branch> getBranches() {
    return [
      Branch(
        id: 'branch-1',
        name: 'RGB Nexus - Flagship Store',
        address: '1337 Cyberpunk Way, Suite Neo, Tech City',
        phone: '+1 (555) 010-3337',
        hours: 'Mon-Sun: 9:00 AM - 10:00 PM',
        location: const LatLng(11.5564, 104.9282), // Phnom Penh main
        distance: 1.2,
        availableStock: 42,
        hasServiceCenter: true,
        rating: 4.9,
      ),
      Branch(
        id: 'branch-2',
        name: 'Pro Systems - Financial District',
        address: '88 Quartz Boulevard, Downtown Center',
        phone: '+1 (555) 010-8800',
        hours: 'Mon-Fri: 8:00 AM - 6:00 PM',
        location: const LatLng(11.5658, 104.9125),
        distance: 3.5,
        availableStock: 18,
        hasServiceCenter: true,
        rating: 4.7,
      ),
      Branch(
        id: 'branch-3',
        name: 'Gamer Haven - East Cyber Hub',
        address: '404 Latency Lane, Sector 9',
        phone: '+1 (555) 010-0404',
        hours: 'Mon-Sat: 10:00 AM - Midnight',
        location: const LatLng(11.5721, 104.9360),
        distance: 4.8,
        availableStock: 25,
        hasServiceCenter: false,
        rating: 4.5,
      ),
      Branch(
        id: 'branch-4',
        name: 'Airport Service & Upgrade Center',
        address: '10 Terminal Road, Concourse B',
        phone: '+1 (555) 010-9999',
        hours: 'Mon-Sun: 6:00 AM - 9:00 PM',
        location: const LatLng(11.5501, 104.8812),
        distance: 8.9,
        availableStock: 8,
        hasServiceCenter: true,
        rating: 4.6,
      ),
    ];
  }

  // 2. Pre-defined FAQs for Chat screen suggestions
  static List<FaqItem> getFaqs() {
    return [
      FaqItem(
        question: 'How do I check my repair status?',
        answer: 'You can search for your 6-digit ticket code (e.g. RGB999) under the Service tab -> Repair Tracker. It displays timeline updates in real-time!',
      ),
      FaqItem(
        question: 'Are custom PC components compatible?',
        answer: 'Yes! Use our signature PC Builder tool which automatically filters motherboard sockets, RAM generations, and minimum power supply guidelines.',
      ),
      FaqItem(
        question: 'What is your warranty policy?',
        answer: 'All Custom Build rigs have a 3-year warranty covering labor and components. Individual parts have standard manufacturer warranty coverage.',
      ),
      FaqItem(
        question: 'Do you offer clean & thermal repaste services?',
        answer: 'Yes, we offer professional thermal repasting and deep dust removal. Usually completed within 2 hours of drop-off!',
      ),
    ];
  }

  // 3. User Builds & Video Tutorials Grid Gallery
  static List<GalleryItem> getGalleryItems() {
    return [
      GalleryItem(
        id: 'gal-1',
        title: 'Project Supernova: RTX 5090 Liquid Cooled Dual Loop',
        author: 'L33tBuilder',
        description: 'Hardline tubing with custom neon magenta and cyan dye. System temperatures remain under 50°C under full benchmark load.',
        thumbnailUrl: 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=600&auto=format&fit=crop&q=60',
        isVideo: false,
        tags: ['Gaming', 'Watercooled', 'Dual Loop'],
        likes: 1240,
        views: 8900,
      ),
      GalleryItem(
        id: 'gal-2',
        title: 'Tutorial: How to apply thermal paste correctly',
        author: 'TechPro_Steve',
        description: 'Testing Pea method vs Cross method vs Spread method. Which one gives the lowest delta-T? Find out in this 2-minute masterclass.',
        thumbnailUrl: 'https://images.unsplash.com/photo-1591488320449-011701bb6704?w=600&auto=format&fit=crop&q=60',
        videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4', // Demo video file
        isVideo: true,
        tags: ['Tutorial', 'Cooling', 'CPU'],
        likes: 852,
        views: 12500,
      ),
      GalleryItem(
        id: 'gal-3',
        title: 'Minimalist Clean Walnut Desk Setup',
        author: 'DeskAesthetic',
        description: 'Clean wireless gaming build hidden behind custom drawer panels. Features custom sleeve cables and warm ambient backlighting.',
        thumbnailUrl: 'https://images.unsplash.com/photo-1618424181497-157f25b6ddd5?w=600&auto=format&fit=crop&q=60',
        isVideo: false,
        tags: ['Pro', 'Setup', 'Minimalist'],
        likes: 955,
        views: 4500,
      ),
      GalleryItem(
        id: 'gal-4',
        title: 'Tutorial: Sourcing compatible RAM for Ryzen CPUs',
        author: 'RyzenMaster',
        description: 'Quick walkthrough on understanding DDR5 profiles, AMD EXPO, and selecting the optimal speed spot (6000MHz CL30).',
        thumbnailUrl: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600&auto=format&fit=crop&q=60',
        videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        isVideo: true,
        tags: ['Tutorial', 'RAM', 'AMD'],
        likes: 412,
        views: 3100,
      ),
      GalleryItem(
        id: 'gal-5',
        title: 'Cyberpunk 2077 Custom Case Scratch-Build',
        author: 'NightCityModder',
        description: 'Constructed entirely from acrylic panels and recycled computer case panels, painted in bright yellow and detailed with warning stripe vinyls.',
        thumbnailUrl: 'https://images.unsplash.com/photo-1563089145-599997674d42?w=600&auto=format&fit=crop&q=60',
        isVideo: false,
        tags: ['Case Mod', 'Gaming', 'Art'],
        likes: 1890,
        views: 15300,
      ),
    ];
  }

  // 4. Default baseline tickets
  static List<RepairTicket> getDefaultTickets() {
    return [
      RepairTicket(
        ticketNumber: 'RGB123',
        deviceName: 'ASUS ROG Zephyrus G14',
        issueDescription: 'Fan making loud buzzing noise and high temps under load.',
        dateSubmitted: DateTime.now().subtract(const Duration(days: 3)),
        status: 'Repairing',
        notes: 'Replacing primary blower fan assembly. Sourced OEM replacement part.',
        timeline: [
          TicketTimelineEvent(
            title: 'Request Received',
            description: 'Ticket generated. Intake checklist completed.',
            timestamp: DateTime.now().subtract(const Duration(days: 3)),
          ),
          TicketTimelineEvent(
            title: 'Diagnostics',
            description: 'Confirmed CPU fan bearing failure. Thermal paste dry.',
            timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 18)),
          ),
          TicketTimelineEvent(
            title: 'Parts Sourcing',
            description: 'Fan replacement ordered from local distributor hub.',
            timestamp: DateTime.now().subtract(const Duration(days: 2)),
          ),
          TicketTimelineEvent(
            title: 'Repairing',
            description: 'Cleaning dust buildup. OEM replacement fan installed.',
            timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          ),
          TicketTimelineEvent(
            title: 'Testing',
            description: 'Awaiting benchmark thermal profiling.',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
          TicketTimelineEvent(
            title: 'Ready for Pickup',
            description: 'Customer notification pending.',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
        ],
      ),
      RepairTicket(
        ticketNumber: 'PRO999',
        deviceName: 'Custom Builder Rig - MSI Z790',
        issueDescription: 'System turns on but displays no signal on monitor.',
        dateSubmitted: DateTime.now().subtract(const Duration(days: 1)),
        status: 'Diagnostics',
        notes: 'Testing individual RAM channels and testing power delivery output rails.',
        timeline: [
          TicketTimelineEvent(
            title: 'Request Received',
            description: 'Consultation intake done. Drop-off complete.',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
          ),
          TicketTimelineEvent(
            title: 'Diagnostics',
            description: 'Testing motherboard post codes. Current code is C5 (RAM issue).',
            timestamp: DateTime.now().subtract(const Duration(hours: 12)),
          ),
          TicketTimelineEvent(
            title: 'Parts Sourcing',
            description: 'No external parts required yet.',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
          TicketTimelineEvent(
            title: 'Repairing',
            description: 'Pending Diagnostics results.',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
          TicketTimelineEvent(
            title: 'Testing',
            description: 'Pending Repair.',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
          TicketTimelineEvent(
            title: 'Ready for Pickup',
            description: 'Pending completion.',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
        ],
      )
    ];
  }
}
