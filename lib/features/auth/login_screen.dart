import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CyberRigLoginPage extends StatefulWidget {
  const CyberRigLoginPage({super.key});

  @override
  State<CyberRigLoginPage> createState() => _CyberRigLoginPageState();
}

class _CyberRigLoginPageState extends State<CyberRigLoginPage> {
  bool _isPasswordObscured = true;

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
              // Top Custom App Bar
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
              
              // Divider glow underneath the top bar
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
                      
                      // Heading Titles
                      Text(
                        'WELCOME BACK',
                        style: GoogleFonts.orbitron(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Initialize secure session to your rig',
                        style: GoogleFonts.shareTechMono(
                          fontSize: 14,
                          color: Colors.white54,
                          letterSpacing: 1,
                        ),
                      ),
                      
                      const SizedBox(height: 32),

                      // Main Login Glass Card
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email Field Header
                            Text(
                              'EMAIL',
                              style: GoogleFonts.shareTechMono(
                                color: Colors.white60,
                                fontSize: 12,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Email Input Field
                            TextField(
                              style: GoogleFonts.shareTechMono(color: Colors.white),
                              decoration: _buildInputDecoration(
                                hintText: 'Email or Username',
                                prefixIcon: Icons.alternate_email,
                              ),
                            ),
                            
                            const SizedBox(height: 24),

                            // Password Field Header with Forgot Password Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'PASSWORD',
                                  style: GoogleFonts.shareTechMono(
                                    color: Colors.white60,
                                    fontSize: 12,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Route over to the forgot password recovery workspace
                                    Navigator.pushNamed(context, '/forgot-password');
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: GoogleFonts.shareTechMono(
                                      color: const Color(0xFFFF4081), 
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Password Input Field
                            TextField(
                              obscureText: _isPasswordObscured,
                              style: GoogleFonts.shareTechMono(color: Colors.white),
                              decoration: _buildInputDecoration(
                                hintText: '••••••••',
                                prefixIcon: Icons.lock_outline,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                    color: Colors.white38,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordObscured = !_isPasswordObscured;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Vibrant Log In Button
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
                                  // Clear backstack stack history and launch directly into main engine dashboard
                                  Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
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
                                      'LOG IN',
                                      style: GoogleFonts.orbitron(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.logout, color: Colors.white, size: 18), 
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // "Or Connect With" Divider Line
                            Row(
                              children: [
                                const Expanded(child: Divider(color: Colors.white10, thickness: 1)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    'OR CONNECT WITH',
                                    style: GoogleFonts.shareTechMono(
                                      color: Colors.white38,
                                      fontSize: 11,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Divider(color: Colors.white10, thickness: 1)),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Social Media Row Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSocialButton(iconPath: 'assets/google.png', fallbackIcon: Icons.g_mobiledata, iconColor: Colors.red),
                                _buildSocialButton(iconPath: 'assets/facebook.png', fallbackIcon: Icons.facebook, iconColor: const Color(0xFF1877F2)),
                                _buildSocialButton(iconPath: 'assets/gmail.png', fallbackIcon: Icons.mail, iconColor: const Color(0xFFEA4335)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Bottom Footnote Links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: [
                          Text(
                            'New? ',
                            style: GoogleFonts.shareTechMono(color: Colors.white54, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Pivot directly onto the account configuration pipeline
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              'Create Account',
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

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.shareTechMono(color: Colors.white24, fontSize: 15),
      prefixIcon: Icon(prefixIcon, color: Colors.white38, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFF1A1A1E),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
      ),
    );
  }

  Widget _buildSocialButton({required String iconPath, required IconData fallbackIcon, required Color iconColor}) {
    return Expanded(
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1D22),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.03)),
        ),
        child: InkWell(
          onTap: () {
            // Handle external OAuth pipeline sequences here
          },
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Icon(
              fallbackIcon,
              color: iconColor,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}