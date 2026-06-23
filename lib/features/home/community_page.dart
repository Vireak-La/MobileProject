import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../components/cyber_drawer.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _commentController = TextEditingController();

  // Local state for setup posts
  final List<Map<String, dynamic>> _setups = [
    {
      'id': 'setup-1',
      'user': 'HyperDrive_88',
      'avatar': 'H',
      'title': 'PROJECT NEON SHADOW // WALL MOUNTED',
      'specs': 'AMD Ryzen 9 7950X3D | RTX 4090 FE | 64GB Trident Z5',
      'image': 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=600&auto=format&fit=crop&q=60',
      'likes': 245,
      'isLiked': false,
      'comments': [
        {'user': 'TechPriest', 'text': 'Unbelievable cable management! Wall mount looks flawless.'},
        {'user': 'GamerX', 'text': 'What are your idle temps on the CPU?'},
      ],
    },
    {
      'id': 'setup-2',
      'user': 'CyberValkyrie',
      'avatar': 'V',
      'title': 'QUANTUM CHILL // HARDLINE CUSTOM LOOP',
      'specs': 'Intel Core i9-14900K | RTX 4080 Super | Dual 360mm Rads',
      'image': 'https://images.unsplash.com/photo-1618424181497-157f25b6ddd5?w=600&auto=format&fit=crop&q=60',
      'likes': 189,
      'isLiked': true,
      'comments': [
        {'user': 'LiquidLiquid', 'text': 'Magenta dye with white coolant looks insane.'},
      ],
    },
    {
      'id': 'setup-3',
      'user': 'RetroRig_95',
      'avatar': 'R',
      'title': 'VAPORWAVE STATION // CRT MONITOR MATRIX',
      'specs': 'Ryzen 7 7800X3D | RX 7900 XTX | Vintage Mechanical Deck',
      'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=600&auto=format&fit=crop&q=60',
      'likes': 312,
      'isLiked': false,
      'comments': [
        {'user': 'SynthBeast', 'text': 'Vaporwave vibes are off the charts. Love the CRT secondary displays.'},
        {'user': 'KeybLover', 'text': 'What switch type on that keyboard?'},
      ],
    },
  ];

  // Local state for discussions
  final List<Map<String, dynamic>> _threads = [
    {
      'id': 'thread-1',
      'title': 'Is 750W PSU enough for RTX 4080 Super + Ryzen 7800X3D?',
      'author': 'PowerSeeker',
      'tag': 'HARDWARE',
      'color': AppColors.neonCyan,
      'repliesCount': 18,
      'date': '2 hours ago',
      'content': 'Planning my build right now. Calculated load is around 580W, but I want to make sure transients won\'t trip a 750W Gold PSU. Any experience?',
      'replies': [
        {'user': 'TechSteve', 'text': 'Yes, I run this exact setup on a Corsair RM750x. No issues even during heavy stress testing.'},
        {'user': 'AmpMaster', 'text': 'You are totally fine. 7800X3D is very power efficient. Max draw is usually under 85W.'},
      ],
    },
    {
      'id': 'thread-2',
      'title': 'Best fan curve parameters for Lian Li O11 Dynamic EVO?',
      'author': 'CoolingCzar',
      'tag': 'COOLING',
      'color': AppColors.neonMagenta,
      'repliesCount': 12,
      'date': '5 hours ago',
      'content': 'I have 9 fans installed (bottom intake, side intake rad, top exhaust). Looking for a curve that balances noise and thermals.',
      'replies': [
        {'user': 'FanFanatic', 'text': 'Link your fan speed to the water temp sensor rather than the CPU package spike temp.'},
      ],
    },
    {
      'id': 'thread-3',
      'title': 'How to safely flush liquid loops (pastel fluid cleanup)',
      'author': 'WaterGamer',
      'tag': 'MAINTENANCE',
      'color': AppColors.neonGreen,
      'repliesCount': 24,
      'date': '1 day ago',
      'content': 'I run opaque pink fluid for a year and now switching back to clear. Tips for removing stains from acrylic blocks?',
      'replies': [
        {'user': 'ModdingMage', 'text': 'Use Mayhems Blitz Part 2 for flushing or take the block apart and scrub with soft toothbrush and toothpaste.'},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _toggleLike(int index) {
    setState(() {
      final setup = _setups[index];
      final isLiked = setup['isLiked'] as bool;
      setup['isLiked'] = !isLiked;
      setup['likes'] = (setup['likes'] as int) + (!isLiked ? 1 : -1);
    });
  }

  void _openComments(Map<String, dynamic> item, bool isSetup) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F1622),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: AppColors.neonCyan, width: 1.5),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final commentsList = item['comments'] as List<dynamic>? ?? item['replies'] as List<dynamic>;
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 18,
                right: 18,
                top: 18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textMuted,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isSetup ? 'SETUP DISCUSSION // LOGS' : 'THREAD RESPONSES',
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      color: AppColors.neonCyan,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(color: Color(0xFF1E2B40)),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: commentsList.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(
                              child: Text(
                                'NO ARCHIVES YET. POST A LOG.',
                                style: TextStyle(fontFamily: 'Courier', color: AppColors.textMuted, fontSize: 11),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: commentsList.length,
                            itemBuilder: (context, i) {
                              final c = commentsList[i];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF1B2636),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        c['user'][0].toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.neonCyan,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '@${c['user']}',
                                            style: const TextStyle(
                                              fontFamily: 'Courier',
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            c['text'],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  const Divider(color: Color(0xFF1E2B40)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                            decoration: InputDecoration(
                              hintText: isSetup ? 'Enter setup log...' : 'Enter response...',
                              hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                              filled: true,
                              fillColor: const Color(0xFF05080D),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFF1E2B40)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppColors.neonCyan),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send_outlined, color: AppColors.neonCyan),
                          onPressed: () {
                            final val = _commentController.text.trim();
                            if (val.isNotEmpty) {
                              setState(() {
                                commentsList.add({
                                  'user': 'LocalGamer',
                                  'text': val,
                                });
                                if (!isSetup) {
                                  item['repliesCount'] = (item['repliesCount'] as int) + 1;
                                }
                              });
                              setModalState(() {
                                // Redraw modal content
                              });
                              _commentController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _createNewPost() {
    String postType = 'SETUP'; // 'SETUP' or 'THREAD'
    String title = '';
    String specDetails = '';
    String threadTag = 'HARDWARE';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: const Color(0xFF0F1622),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.neonMagenta, width: 1.5),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'NEW CYBER-COMMUNICATION',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.neonMagenta,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'POST TARGET SECTION',
                      style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: postType == 'SETUP' ? AppColors.neonMagenta : const Color(0xFF1E2B40),
                              foregroundColor: postType == 'SETUP' ? Colors.black : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () => setDialogState(() => postType = 'SETUP'),
                            child: const Text('SETUP FEED', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: postType == 'THREAD' ? AppColors.neonMagenta : const Color(0xFF1E2B40),
                              foregroundColor: postType == 'THREAD' ? Colors.black : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () => setDialogState(() => postType = 'THREAD'),
                            child: const Text('FORUM THREAD', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'TITLE / SUBJECT',
                      style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      onChanged: (val) => title = val,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: postType == 'SETUP' ? 'e.g. PROJECT AURORA' : 'e.g. Tips on overclocking GPU...',
                        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                        filled: true,
                        fillColor: const Color(0xFF05080D),
                        contentPadding: const EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF1E2B40)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.neonMagenta),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      postType == 'SETUP' ? 'HARDWARE SPECS' : 'BODY CONTENT / QUESTION',
                      style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      onChanged: (val) => specDetails = val,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: postType == 'SETUP'
                            ? 'e.g. Ryzen 7800X3D | RTX 4070 Ti | O11 Mini'
                            : 'Explain what you want to discuss or ask the community...',
                        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                        filled: true,
                        fillColor: const Color(0xFF05080D),
                        contentPadding: const EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF1E2B40)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.neonMagenta),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    if (postType == 'THREAD') ...[
                      const SizedBox(height: 14),
                      const Text(
                        'FORUM TAG',
                        style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        dropdownColor: const Color(0xFF0F1622),
                        initialValue: threadTag,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF05080D),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF1E2B40)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: ['HARDWARE', 'COOLING', 'MAINTENANCE', 'OVERCLOCK']
                            .map((tag) => DropdownMenuItem(
                                  value: tag,
                                  child: Text(tag, style: const TextStyle(fontFamily: 'Courier')),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) threadTag = val;
                        },
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('CANCEL', style: TextStyle(color: AppColors.textMuted, fontFamily: 'Courier')),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.neonMagenta,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            if (title.trim().isNotEmpty && specDetails.trim().isNotEmpty) {
                              setState(() {
                                if (postType == 'SETUP') {
                                  _setups.insert(0, {
                                    'id': 'setup-${_setups.length + 1}',
                                    'user': 'LocalGamer',
                                    'avatar': 'L',
                                    'title': title.toUpperCase(),
                                    'specs': specDetails,
                                    'image': 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=600&auto=format&fit=crop&q=60',
                                    'likes': 0,
                                    'isLiked': false,
                                    'comments': [],
                                  });
                                } else {
                                  Color tone = AppColors.neonCyan;
                                  if (threadTag == 'COOLING') tone = AppColors.neonMagenta;
                                  if (threadTag == 'MAINTENANCE') tone = AppColors.neonGreen;
                                  if (threadTag == 'OVERCLOCK') tone = AppColors.neonOrange;

                                  _threads.insert(0, {
                                    'id': 'thread-${_threads.length + 1}',
                                    'title': title,
                                    'author': 'LocalGamer',
                                    'tag': threadTag,
                                    'color': tone,
                                    'repliesCount': 0,
                                    'date': 'Just now',
                                    'content': specDetails,
                                    'replies': [],
                                  });
                                }
                              });
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xFF0F1622),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: AppColors.neonMagenta, width: 1.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  content: const Text(
                                    'POST REGISTERED // UPLOADED TO COMMUNITY DATABANK',
                                    style: TextStyle(fontFamily: 'Courier', color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('SUBMIT', style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05080D),
      drawer: const CyberDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'NEXUS COMMUNITY',
          style: TextStyle(
            fontFamily: 'Courier',
            letterSpacing: 1.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.neonMagenta,
          labelColor: AppColors.neonMagenta,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 12),
          tabs: const [
            Tab(text: 'BATTLE SETUPS'),
            Tab(text: 'DISCUSSION BOARDS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Setups Feed Tab
          _buildSetupsFeed(),
          // Discussions Tab
          _buildDiscussionsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.neonMagenta,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text(
          'CREATE POST',
          style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        onPressed: _createNewPost,
      ),
    );
  }

  Widget _buildSetupsFeed() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
      itemCount: _setups.length,
      itemBuilder: (context, index) {
        final setup = _setups[index];
        final isLiked = setup['isLiked'] as bool;
        return Container(
          margin: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF0C1114),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isLiked ? AppColors.neonMagenta.withOpacity(0.5) : const Color(0xFF1E2B40),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User header
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.neonMagenta, width: 1.5),
                        color: const Color(0xFF1E2B40),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        setup['avatar'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.neonMagenta,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '@${setup['user']}',
                            style: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'COMMUNITY MATRIX RESIDENT',
                            style: TextStyle(
                              fontSize: 8,
                              color: AppColors.textMuted,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Title & Specs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      setup['title'],
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.neonCyan,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      setup['specs'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Image
              AspectRatio(
                aspectRatio: 1.77,
                child: Container(
                  color: const Color(0xFF101722),
                  child: Image.network(
                    setup['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image_outlined, color: AppColors.textMuted, size: 36),
                      );
                    },
                  ),
                ),
              ),

              // Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  children: [
                    // Like button
                    InkWell(
                      onTap: () => _toggleLike(index),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? AppColors.neonMagenta : AppColors.textSecondary,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${setup['likes']}',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                                color: isLiked ? AppColors.neonMagenta : AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Comment button
                    InkWell(
                      onTap: () => _openComments(setup, true),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.chat_bubble_outline,
                              color: AppColors.neonCyan,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${(setup['comments'] as List).length}',
                              style: const TextStyle(
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDiscussionsList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
      itemCount: _threads.length,
      itemBuilder: (context, index) {
        final thread = _threads[index];
        final tone = thread['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF0C1114),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF1E2B40)),
          ),
          child: InkWell(
            onTap: () => _openComments(thread, false),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: tone.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: tone.withOpacity(0.35)),
                        ),
                        child: Text(
                          thread['tag'],
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: tone,
                          ),
                        ),
                      ),
                      Text(
                        thread['date'],
                        style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    thread['title'],
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    thread['content'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 13, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            '@${thread['author']}',
                            style: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.mode_comment_outlined, size: 13, color: AppColors.neonCyan),
                          const SizedBox(width: 6),
                          Text(
                            '${thread['repliesCount']} replies',
                            style: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.neonCyan,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
