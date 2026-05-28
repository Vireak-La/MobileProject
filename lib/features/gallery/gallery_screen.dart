import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/mock_repository.dart';
import '../../theme/app_colors.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String selectedFilter = 'All';
  final List<String> filters = ['All', 'Gaming', 'Watercooled', 'Tutorial', 'Setup'];

  @override
  Widget build(BuildContext context) {
    final allItems = MockRepository.getGalleryItems();
    final items = selectedFilter == 'All'
        ? allItems
        : allItems.where((item) => item.tags.contains(selectedFilter)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BUILD SHOWCASE'),
      ),
      body: Column(
        children: [
          // Filter horizontal list
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      filter.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 12,
                        color: isSelected ? Colors.black : AppColors.neonCyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.neonCyan,
                    checkmarkColor: Colors.black,
                    backgroundColor: AppColors.surfaceCard,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : const Color(0xFF1E2B40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Gallery Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    if (item.isVideo) {
                      _showVideoPlayer(context, item);
                    } else {
                      _showImageZoom(context, item);
                    }
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Thumbnail with Video badge
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: item.thumbnailUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppColors.surface,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(AppColors.neonCyan),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: AppColors.surface,
                                  child: const Icon(Icons.broken_image, color: Colors.grey),
                                ),
                              ),
                              if (item.isVideo)
                                Container(
                                  color: Colors.black.withOpacity(0.3),
                                  child: const Center(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      radius: 24,
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        color: AppColors.neonCyan,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xCC000000),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'PHOTO',
                                      style: TextStyle(
                                        fontFamily: 'Courier',
                                        fontSize: 9,
                                        color: AppColors.neonMagenta,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // Metadata card content
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.person, size: 10, color: AppColors.textMuted),
                                  const SizedBox(width: 4),
                                  Text(
                                    item.author,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.thumb_up_alt_outlined, size: 12, color: AppColors.neonMagenta),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${item.likes}',
                                        style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.remove_red_eye_outlined, size: 12, color: AppColors.neonCyan),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${item.views}',
                                        style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                                      ),
                                    ],
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
              },
            ),
          ),
        ],
      ),
    );
  }

  // Interactive full-screen pinch-zoom photo viewer
  void _showImageZoom(BuildContext context, GalleryItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(item.title.toUpperCase(), style: const TextStyle(fontSize: 14)),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: CachedNetworkImage(
                    imageUrl: item.thumbnailUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified_user, color: AppColors.neonGreen, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            'Uploaded by ${item.author}',
                            style: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 12,
                              color: AppColors.neonGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Simulated Video Player with full controls
  void _showVideoPlayer(BuildContext context, GalleryItem item) {
    showDialog(
      context: context,
      builder: (context) => _MockVideoPlayerDialog(item: item),
    );
  }
}

class _MockVideoPlayerDialog extends StatefulWidget {
  final GalleryItem item;
  const _MockVideoPlayerDialog({required this.item});

  @override
  State<_MockVideoPlayerDialog> createState() => _MockVideoPlayerDialogState();
}

class _MockVideoPlayerDialogState extends State<_MockVideoPlayerDialog> {
  bool isPlaying = true;
  double progress = 0.35;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.neonCyan, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Simulated Video screen
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.item.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
                // Play overlay status
                Container(
                  color: Colors.black.withOpacity(isPlaying ? 0.2 : 0.6),
                ),
                if (!isPlaying)
                  const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: AppColors.neonCyan,
                      size: 64,
                    ),
                  ),
                Positioned(
                  bottom: 8,
                  left: 12,
                  right: 12,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Slider(
                          value: progress,
                          onChanged: (value) {
                            setState(() {
                              progress = value;
                            });
                          },
                          activeColor: AppColors.neonCyan,
                          inactiveColor: Colors.grey.shade700,
                        ),
                      ),
                      const Text(
                        '0:45 / 2:12',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontWeight: FontWeight.bold,
                    color: AppColors.neonCyan,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.item.description,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text(
                        'CLOSE',
                        style: TextStyle(
                          color: AppColors.neonMagenta,
                          fontFamily: 'Courier',
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
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
