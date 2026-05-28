import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../state/app_state.dart';
import '../../data/mock_repository.dart';
import '../../theme/app_colors.dart';

class RepairTrackerScreen extends StatefulWidget {
  final String? initialTicketNumber;
  const RepairTrackerScreen({super.key, this.initialTicketNumber});

  @override
  State<RepairTrackerScreen> createState() => _RepairTrackerScreenState();
}

class _RepairTrackerScreenState extends State<RepairTrackerScreen> {
  final TextEditingController _searchController = TextEditingController();
  RepairTicket? _matchedTicket;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialTicketNumber != null) {
      _searchController.text = widget.initialTicketNumber!;
      _hasSearched = true;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchTicket(AppStateNotifier state) {
    final query = _searchController.text.trim().toUpperCase();
    setState(() {
      _hasSearched = true;
      _matchedTicket = state.tickets.firstWhere(
        (t) => t.ticketNumber == query,
        orElse: () => null as dynamic, // Will fail try-catch, handled below
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppStateNotifier>(context);

    // If initial search triggered in route but not evaluated yet
    if (widget.initialTicketNumber != null && _matchedTicket == null && _hasSearched) {
      try {
        _matchedTicket = state.tickets.firstWhere(
          (t) => t.ticketNumber == widget.initialTicketNumber!.toUpperCase(),
        );
      } catch (_) {
        _matchedTicket = null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('REPAIR TRACKER'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'TRACK REPAIR AND UPGRADES STATUS',
              style: TextStyle(
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                color: AppColors.neonCyan,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            // Search Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Enter 6-digit ticket (e.g. RGB123)...',
                      hintStyle: TextStyle(fontFamily: 'Courier'),
                      prefixIcon: Icon(Icons.search, color: AppColors.neonCyan),
                    ),
                    style: const TextStyle(fontFamily: 'Courier', color: Colors.white),
                    textCapitalization: TextCapitalization.characters,
                    onSubmitted: (_) => _searchTicket(state),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => _searchTicket(state),
                  child: const Text('SEARCH'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Results Section
            if (!_hasSearched)
              _buildEmptyState("ENTER A TICKET NUMBER ABOVE TO BEGIN TRACKING.")
            else if (_matchedTicket == null)
              _buildEmptyState("TICKET NOT FOUND. VERIFY THE TICKET CODE AND TRY AGAIN.")
            else
              _buildTicketTimeline(_matchedTicket!),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          children: [
            const Icon(
              Icons.terminal,
              size: 48,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketTimeline(RepairTicket ticket) {
    // We map statuses to indices to know which steps are complete
    final List<String> statusSteps = [
      'Received',
      'Diagnostics',
      'Parts Sourcing',
      'Repairing',
      'Testing',
      'Ready for Pickup'
    ];

    int currentStatusIndex = statusSteps.indexWhere(
      (step) => step.toLowerCase().contains(ticket.status.toLowerCase()),
    );
    if (currentStatusIndex == -1) currentStatusIndex = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ticket Quick Header Info
        Card(
          color: AppColors.surfaceCard,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TICKET: ${ticket.ticketNumber}',
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.neonCyan,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.neonMagenta.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.neonMagenta, width: 0.5),
                      ),
                      child: Text(
                        ticket.status.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.neonMagenta,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20, color: Color(0xFF1E2B40)),
                _buildInfoRow('Device Name:', ticket.deviceName),
                const SizedBox(height: 4),
                _buildInfoRow(
                  'Booked On:',
                  DateFormat('yyyy-MM-dd HH:mm').format(ticket.dateSubmitted),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Current Diagnostics Notes:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ticket.notes,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'DIAGNOSTICS & PROGRESS TIMELINE',
          style: TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            color: AppColors.neonGreen,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),

        // Timeline Timeline steps
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ticket.timeline.length,
          itemBuilder: (context, index) {
            final event = ticket.timeline[index];
            final isCompleted = index <= currentStatusIndex;
            final isCurrent = index == currentStatusIndex;
            final isLast = index == ticket.timeline.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline left graphics
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? (isCurrent ? AppColors.neonMagenta : AppColors.neonCyan)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCompleted
                              ? (isCurrent ? AppColors.neonMagenta : AppColors.neonCyan)
                              : AppColors.textMuted,
                          width: 2,
                        ),
                        boxShadow: [
                          if (isCompleted)
                            BoxShadow(
                              color: (isCurrent ? AppColors.neonMagenta : AppColors.neonCyan)
                                  .withOpacity(0.4),
                              blurRadius: 8,
                            ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          isCurrent
                              ? Icons.play_arrow_rounded
                              : (isCompleted ? Icons.check : Icons.circle),
                          size: 14,
                          color: isCompleted ? Colors.black : AppColors.textMuted,
                        ),
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 56,
                        color: isCompleted ? AppColors.neonCyan : const Color(0xFF1E2B40),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                // Timeline text card
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isCurrent
                                ? AppColors.neonMagenta
                                : (isCompleted ? AppColors.neonCyan : AppColors.textMuted),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: isCompleted ? AppColors.textPrimary : AppColors.textMuted,
                          ),
                        ),
                        if (isCompleted) ...[
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('MMM d, yyyy - hh:mm a').format(event.timestamp),
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textMuted,
                              fontFamily: 'Courier',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Courier',
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
