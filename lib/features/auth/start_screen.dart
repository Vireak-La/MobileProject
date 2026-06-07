import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Import your central routing definitions so this page knows about 'AppRoutes'
import 'package:mobileproject/main.dart'; 

class CyberRigStartPage extends StatelessWidget {
  const CyberRigStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Subtle vertical gradient background mimicking the image
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A1E1E), // Dark teal/cyan top
              Color(0xFF0F0B1E), // Dark purple bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decorative Right-side Vertical Text
              Positioned(
                right: 10,
                bottom: 100,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'BUILD PRECISION_ENABLED',
                    style: GoogleFonts.shareTechMono(
                      color: Colors.white24,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),

              // Main Content Layout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Left System Init Tag
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 2,
                          color: const Color(0xFF00E5FF),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'SYS_INIT_V4.2',
                          style: GoogleFonts.shareTechMono(
                            color: const Color(0xFF00E5FF).withOpacity(0.6),
                            fontSize: 14,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(flex: 2),

                    // Central Logo & Title Section
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Concentric Diamond Chip Logo
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Transform.rotate(
                                angle: 0.785398, // ~45 degrees in radians
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white12, width: 1.5),
                                  ),
                                ),
                              ),
                              Transform.rotate(
                                angle: 0.785398,
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF00E5FF).withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.developer_board, // Standard Flutter microchip icon
                                size: 40,
                                color: Color(0xFF00E5FF),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),

                          // Main Title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CYBER-RIG PRO',
                                style: GoogleFonts.orbitron(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00E5FF),
                                  shape: BoxShape.circle,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Subtitle with Side Borders
                          IntrinsicWidth(
                            child: Row(
                              children: [
                                Container(width: 1, height: 40, color: Colors.white24),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      'ENTER THE MATRIX OF CUSTOM\nPOWER',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.shareTechMono(
                                        fontSize: 14,
                                        color: const Color(0xFF00E5FF),
                                        letterSpacing: 3,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(width: 1, height: 40, color: Colors.white24),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 3),

                    // Vibrant Gradient Call to Action Button
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF00E5FF), // Electric Cyan
                            Color(0xFFD500F9), // Neon Purple/Pink
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00E5FF).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Cleanly route over to the login/auth section using your architecture
                          Navigator.pushNamed(context, '/login');
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
                            Text(
                              'GET STARTED',
                              style: GoogleFonts.orbitron(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bottom Status Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00FF66), // Green status dot
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'SERVERS ONLINE',
                              style: GoogleFonts.shareTechMono(
                                fontSize: 12,
                                color: Colors.white54,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'v1.0.8-PRO',
                          style: GoogleFonts.shareTechMono(
                            fontSize: 12,
                            color: Colors.white38,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}