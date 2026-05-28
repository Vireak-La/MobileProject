import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../data/mock_repository.dart';
import '../../theme/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  List<Branch> allBranches = MockRepository.getBranches();
  List<Branch> filteredBranches = [];
  Branch? selectedBranch;
  String currentFilter = 'All';

  @override
  void initState() {
    super.initState();
    filteredBranches = allBranches;
    selectedBranch = allBranches[0];
  }

  void _applyFilter(String filter) {
    setState(() {
      currentFilter = filter;
      if (filter == 'All') {
        filteredBranches = allBranches;
      } else if (filter == 'Service') {
        filteredBranches = allBranches.where((b) => b.hasServiceCenter).toList();
      } else if (filter == 'Nearby') {
        filteredBranches = allBranches.where((b) => b.distance < 4.0).toList();
      } else if (filter == 'Top Rated') {
        filteredBranches = allBranches.where((b) => b.rating >= 4.7).toList();
      }
      if (filteredBranches.isNotEmpty) {
        selectedBranch = filteredBranches[0];
        _moveMapTo(selectedBranch!.location);
      } else {
        selectedBranch = null;
      }
    });
  }

  void _moveMapTo(LatLng location) {
    _mapController.move(location, 14.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STORE FINDER'),
      ),
      body: Stack(
        children: [
          // Flutter Map Widget using OSM tiles
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: selectedBranch?.location ?? const LatLng(11.5564, 104.9282),
              initialZoom: 13.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.lavireak.mobileproject',
                // Dark filter/tint option via container styling isn't natively in TileLayer,
                // but we can apply a color filter overlay or tileBuilder for a hacker/dark theme!
              ),
              MarkerLayer(
                markers: filteredBranches.map((branch) {
                  final isSelected = selectedBranch?.id == branch.id;
                  return Marker(
                    point: branch.location,
                    width: 60,
                    height: 60,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBranch = branch;
                        });
                        _moveMapTo(branch.location);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.neonMagenta : AppColors.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.white : AppColors.neonCyan,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (isSelected ? AppColors.neonMagenta : AppColors.neonCyan)
                                      .withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.computer,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xCC000000),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              branch.name.split(' ').first,
                              style: TextStyle(
                                fontSize: 8,
                                color: isSelected ? AppColors.neonMagenta : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Filters overlay chip bar
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterChip('All', 'ALL BRANCHES'),
                  _filterChip('Service', 'REPAIR CENTERS'),
                  _filterChip('Nearby', 'NEARBY (<4KM)'),
                  _filterChip('Top Rated', 'TOP RATED (4.7+)'),
                ],
              ),
            ),
          ),

          // Bottom card showing detail details of the selected branch
          if (selectedBranch != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Card(
                elevation: 8,
                shadowColor: AppColors.neonCyan.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.neonCyan, width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedBranch!.name,
                              style: const TextStyle(
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.neonCyan,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${selectedBranch!.rating}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedBranch!.address,
                        style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Text(
                            selectedBranch!.hours,
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Badges
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: selectedBranch!.hasServiceCenter
                                  ? Colors.green.withOpacity(0.15)
                                  : Colors.red.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: selectedBranch!.hasServiceCenter ? Colors.green : Colors.red,
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              selectedBranch!.hasServiceCenter
                                  ? '🔧 SERVICE DEPT'
                                  : '🚫 NO REPAIRS',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: selectedBranch!.hasServiceCenter ? Colors.green : Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.neonCyan.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.neonCyan, width: 0.5),
                            ),
                            child: Text(
                              '📦 ${selectedBranch!.availableStock} RIGS IN STOCK',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: AppColors.neonCyan,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${selectedBranch!.distance} km away',
                            style: const TextStyle(fontSize: 12, color: AppColors.neonMagenta),
                          ),
                        ],
                      ),
                      const Divider(height: 24, color: Color(0xFF1E2B40)),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.phone, size: 16),
                              label: const Text('CALL STORE'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF1E2B40)),
                                foregroundColor: AppColors.textPrimary,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Calling ${selectedBranch!.phone}...'),
                                    backgroundColor: AppColors.surfaceCard,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.directions, size: 16, color: Colors.black),
                              label: const Text('DIRECTIONS'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.neonCyan,
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: AppColors.surface,
                                  builder: (context) => Container(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'LAUNCH EXTERNAL MAPS',
                                          style: TextStyle(
                                            fontFamily: 'Courier',
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.neonCyan,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Do you want to navigate to ${selectedBranch!.name} via Google Maps?',
                                          style: const TextStyle(color: AppColors.textSecondary),
                                        ),
                                        const SizedBox(height: 24),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                child: const Text('CANCEL'),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: ElevatedButton(
                                                child: const Text('LAUNCH'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Launching directions in browser...'),
                                                      backgroundColor: AppColors.surfaceCard,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _filterChip(String filterKey, String label) {
    final isSelected = currentFilter == filterKey;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) => _applyFilter(filterKey),
        selectedColor: AppColors.neonCyan,
        backgroundColor: const Color(0xCC000000).withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: isSelected ? Colors.transparent : AppColors.neonCyan.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
