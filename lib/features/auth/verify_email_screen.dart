import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileproject/features/auth/new_password_screen.dart';

class CyberRigVerifyEmailPage extends StatefulWidget {
  const CyberRigVerifyEmailPage({super.key});

  @override
  State<CyberRigVerifyEmailPage> createState() => _CyberRigVerifyEmailPageState();
}

class _CyberRigVerifyEmailPageState extends State<CyberRigVerifyEmailPage> {
  final int _pinLength = 4;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    // Initialize with a single space character placeholder to detect backspaces safely
    _controllers = List.generate(_pinLength, (index) => TextEditingController(text: " "));
    _focusNodes = List.generate(_pinLength, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onPinChanged(String value, int index) {
    // 1. Backspace Case: If the value becomes completely empty, the user deleted our placeholder space
    if (value.isEmpty) {
      _controllers[index].text = " ";
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].text = " "; 
      }
      return;
    }

    // 2. Multi-character Entry Case: User typed a character over or next to the placeholder space
    if (value.length > 1) {
      String actualDigit = value.replaceAll(" ", "");
      
      if (actualDigit.isNotEmpty) {
        String singleCharacter = actualDigit.substring(actualDigit.length - 1);
        _controllers[index].text = singleCharacter;

        // Drive the focus chain down the grid matrix
        if (index < _pinLength - 1) {
          _focusNodes[index + 1].requestFocus();
        } else {
          _focusNodes[index].unfocus(); // Completed the matrix sequence
        }
      } else {
        _controllers[index].text = " ";
      }
    }
  }

  String _getCalculatedPin() {
    return _controllers.map((c) => c.text.trim()).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Prevents layout distortions/overflow errors when the on-screen keyboard kicks up
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A1E1E), 
              Color(0xFF0F0B1E), 
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Custom App Bar Layout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.developer_board,
                          size: 20,
                          color: Color(0xFF00E5FF),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Cyber-Rig Pro',
                          style: GoogleFonts.orbitron(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00E5FF),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70, size: 22),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              Container(
                height: 1,
                width: double.infinity,
                color: const Color(0xFF00E5FF).withOpacity(0.15),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // Main Terminal Verification Card Container
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF121214).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              'VERIFY YOUR\nEMAIL',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.orbitron(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'We sent a 4-digit verification code to\nyour email.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.shareTechMono(
                                fontSize: 14,
                                color: Colors.white60,
                                height: 1.4,
                                letterSpacing: 0.5,
                              ),
                            ),
                            
                            const SizedBox(height: 32),

                            // 4-Digit Input Matrix Box Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(_pinLength, (index) {
                                return SizedBox(
                                  width: 56, 
                                  height: 68,
                                  child: TextField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    onChanged: (value) => _onPinChanged(value, index),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.orbitron(
                                      fontSize: 22, 
                                      fontWeight: FontWeight.bold, 
                                      color: const Color(0xFF00E5FF),
                                    ),
                                    onTap: () {
                                      _controllers[index].selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: _controllers[index].text.length,
                                      );
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')), 
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      counterText: '', 
                                      filled: true,
                                      fillColor: const Color(0xFF16161A),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.white.withOpacity(0.08), width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),

                            const SizedBox(height: 28),

                            // Resend System Interface Timer Group
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.access_time, color: Color(0xFFFF4081), size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  '01:57',
                                  style: GoogleFonts.shareTechMono(
                                    color: const Color(0xFFFF4081),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                print("Resending verification payload...");
                              },
                              child: Text(
                                'RESEND CODE',
                                style: GoogleFonts.shareTechMono(
                                  color: Colors.white38,
                                  fontSize: 13,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(height: 36),

                            // VERIFY & PROCEED Neon Pulse Button Layout
                            Container(
                              width: double.infinity,
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00E5FF),
                                    Color(0xFFD500F9),
                                  ],
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  String finalCleanPin = _getCalculatedPin();
                                  print("Bypassing validation check. Navigating to Access Key generation step. Raw context: $finalCleanPin");
                                  
                                  // Navigates directly to your password page setup
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const CyberRigNewPasswordPage()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'VERIFY & PROCEED',
                                  style: GoogleFonts.orbitron(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Inner Card Matrix Metadata Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ENCRYPTED SESSION',
                                      style: GoogleFonts.shareTechMono(color: Colors.white24, fontSize: 10, letterSpacing: 1),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'AES-256-BIT',
                                      style: GoogleFonts.shareTechMono(color: const Color(0xFF00E5FF).withOpacity(0.6), fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'NODE STATUS ',
                                      style: GoogleFonts.shareTechMono(color: Colors.white24, fontSize: 11),
                                    ),
                                    Text(
                                      'STABLE',
                                      style: GoogleFonts.shareTechMono(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 48),

                      // Bottom Support Link Footnote
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Need help? ',
                            style: GoogleFonts.shareTechMono(color: Colors.white54, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Contacting Admin Support...");
                            },
                            child: Text(
                              'Contact System Admin',
                              style: GoogleFonts.shareTechMono(
                                color: const Color(0xFF00E5FF),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
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
}

// Ensure your CyberRigNewPasswordPage class code is left in this folder project structure or imported!