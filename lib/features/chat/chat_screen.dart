import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../data/mock_repository.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text, AppStateNotifier state) {
    if (text.trim().isEmpty) return;
    state.sendChatMessage(text.trim());
    _controller.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppStateNotifier>(context);
    final faqs = MockRepository.getFaqs();

    // Trigger scroll when new messages arrive
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      appBar: AppBar(
        title: const Text('TECH SUPPORT'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: AppColors.neonCyan),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColors.surface,
                  title: const Text(
                    'SUPPORT INFO',
                    style: TextStyle(fontFamily: 'Courier', color: AppColors.neonCyan),
                  ),
                  content: const Text(
                    'Our virtual AI representative, Cyber-Assistant V3, handles diagnostics inquiries 24/7. Live mechanics are online 9 AM - 6 PM daily.',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('OK', style: TextStyle(color: AppColors.neonMagenta)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Status bar connection
            Container(
              color: Colors.green.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.neonGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'CYBER-ASSISTANT V3 ONLINE',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 10,
                      color: AppColors.neonGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Message feed
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: state.chatMessages.length,
                itemBuilder: (context, index) {
                  final msg = state.chatMessages[index];
                  final isUser = msg.sender == 'user';

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        gradient: isUser ? AppColors.cyanMagentaGradient : null,
                        color: isUser ? null : AppColors.surfaceCard,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 0),
                          bottomRight: Radius.circular(isUser ? 0 : 16),
                        ),
                        border: isUser
                            ? null
                            : Border.all(color: const Color(0xFF1E2B40), width: 1.5),
                        boxShadow: [
                          if (isUser)
                            BoxShadow(
                              color: AppColors.neonCyan.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment:
                            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            isUser ? 'YOU' : 'CYBER-AGENT',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isUser ? Colors.white70 : AppColors.neonCyan,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            msg.text,
                            style: TextStyle(
                              color: isUser ? Colors.black87 : AppColors.textPrimary,
                              fontWeight: isUser ? FontWeight.w600 : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Typing Indicator
            if (state.isTyping)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(AppColors.neonMagenta),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Cyber-Assistant is compiling response...',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            // FAQ Shortcuts
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  final faq = faqs[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      backgroundColor: AppColors.surfaceCard,
                      label: Text(
                        faq.question,
                        style: const TextStyle(
                          color: AppColors.neonCyan,
                          fontSize: 11,
                          fontFamily: 'Courier',
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xFF1E2B40)),
                      ),
                      onPressed: () {
                        _sendMessage(faq.question, state);
                      },
                    ),
                  );
                },
              ),
            ),
            // Input text box
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter command/query...',
                        hintStyle: const TextStyle(fontFamily: 'Courier'),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.attach_file, color: AppColors.textMuted),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('File attachment mock triggered.'),
                                backgroundColor: AppColors.surfaceCard,
                              ),
                            );
                          },
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onSubmitted: (text) => _sendMessage(text, state),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _sendMessage(_controller.text, state),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        gradient: AppColors.cyanMagentaGradient,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonMagenta.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.black,
                      ),
                    ),
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
