import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CyberRigForgetPasswordPage extends StatefulWidget {
  const CyberRigForgetPasswordPage({super.key});

  @override
  State<CyberRigForgetPasswordPage> createState() => _CyberRigForgetPasswordPageState();
}

class _CyberRigForgetPasswordPageState extends State<CyberRigForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Top App Bar Header Area
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
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
              ),
              
              // Thin cybernetic horizon separator glow
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
                      const SizedBox(height: 60),

                      // Main Forget Password Glass Box Container
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF121214).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF00E5FF).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            
                            // Glowing Reset Badge Asset Top
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: const Color(0xFF162529),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF00E5FF).withOpacity(0.3),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00E5FF).withOpacity(0.15),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  )
                                ]
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.lock_reset,
                                  color: Color(0xFF00E5FF),
                                  size: 36,
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 28),
                            
                            // Section Header Title
                            Text(
                              'RESET PASSWORD',
                              style: GoogleFonts.orbitron(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Help Text Paragraph Block
                            Text(
                              'Enter your registered email below and we\'ll send you instructions to reset your password.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.shareTechMono(
                                fontSize: 14,
                                color: Colors.white60,
                                height: 1.5,
                                letterSpacing: 0.5,
                              ),
                            ),
                            
                            const SizedBox(height: 32),

                            // Input Field Label Identification
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'REGISTERED EMAIL',
                                style: GoogleFonts.shareTechMono(
                                  color: Colors.white60,
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Email Entry Input Node Box
                            TextField(
                              controller: _emailController,
                              style: GoogleFonts.shareTechMono(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'pilot@cyber-rig.pro',
                                hintStyle: GoogleFonts.shareTechMono(color: Colors.white12, fontSize: 15),
                                prefixIcon: const Icon(Icons.alternate_email, color: Colors.white38, size: 20),
                                filled: true,
                                fillColor: const Color(0xFF16161A),
                                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.08), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            // CONFIRM Neon Purple Gradient Execution Action Link
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
                                  print("Reset request dispatch: ${_emailController.text}");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 24), // Offset tracking balancing out the trailing icon
                                    Text(
                                      'CONFIRM',
                                      style: GoogleFonts.orbitron(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.send_and_archive_sharp, 
                                      color: Colors.white, 
                                      size: 16,
                                    ), 
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),
                            
                            const Divider(color: Colors.white10, thickness: 1),
                            
                            const SizedBox(height: 16),

                            // Back Navigation Step Text Return link
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.arrow_back, color: Color(0xFF00E5FF), size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Back to Login',
                                      style: GoogleFonts.shareTechMono(
                                        color: const Color(0xFF00E5FF),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 48),

                      // Bottom Interface Environmental Status Matrix Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'SYSTEMS ONLINE',
                            style: GoogleFonts.shareTechMono(
                              color: Colors.white24,
                              fontSize: 11,
                              letterSpacing: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '•',
                              style: TextStyle(color: Colors.white.withOpacity(0.1)),
                            ),
                          ),
                          Text(
                            'v2.4.0-CORE',
                            style: GoogleFonts.shareTechMono(
                              color: Colors.white24,
                              fontSize: 11,
                              letterSpacing: 1,
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