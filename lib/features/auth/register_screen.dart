import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CyberRigRegisterPage extends StatefulWidget {
  const CyberRigRegisterPage({super.key});

  @override
  State<CyberRigRegisterPage> createState() => _CyberRigRegisterPageState();
}

class _CyberRigRegisterPageState extends State<CyberRigRegisterPage> {
  bool _isPasswordObscured = true;
  bool _isTermsAgreed = false;

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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      
                      // Cyber-Themed Page Title
                      Text(
                        'CREATE AN\nACCOUNT',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.orbitron(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF00E5FF),
                          letterSpacing: 3,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Decorative Subtitle Monospace text
                      Text(
                        'Initializing terminal deployment profile...',
                        style: GoogleFonts.shareTechMono(
                          fontSize: 13,
                          color: Colors.white38,
                          letterSpacing: 1,
                        ),
                      ),
                      
                      const SizedBox(height: 32),

                      // Main Registration Glass Card Container
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
                            // 1. FULL NAME FIELD
                            _buildFieldLabel('FULL NAME'),
                            const SizedBox(height: 8),
                            TextField(
                              style: GoogleFonts.shareTechMono(color: Colors.white),
                              decoration: _buildInputDecoration(
                                hintText: 'ENTER NAME',
                                prefixIcon: Icons.person_outline,
                              ),
                            ),
                            
                            const SizedBox(height: 20),

                            // 2. EMAIL FIELD
                            _buildFieldLabel('EMAIL'),
                            const SizedBox(height: 8),
                            TextField(
                              style: GoogleFonts.shareTechMono(color: Colors.white),
                              decoration: _buildInputDecoration(
                                hintText: 'USER@CYBER-RIG.PRO',
                                prefixIcon: Icons.alternate_email,
                              ),
                            ),
                            
                            const SizedBox(height: 20),

                            // 3. PASSWORD FIELD
                            _buildFieldLabel('PASSWORD'),
                            const SizedBox(height: 8),
                            TextField(
                              obscureText: _isPasswordObscured,
                              style: GoogleFonts.shareTechMono(color: Colors.white),
                              decoration: _buildInputDecoration(
                                hintText: '••••••••',
                                prefixIcon: Icons.lock_outline,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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

                            const SizedBox(height: 20),

                            // 4. CONFIRM PASSWORD/EMAIL FIELD
                            _buildFieldLabel('CONFIRM SECURITY PIN'),
                            const SizedBox(height: 8),
                            TextField(
                              obscureText: _isPasswordObscured,
                              style: GoogleFonts.shareTechMono(color: Colors.white),
                              decoration: _buildInputDecoration(
                                hintText: '••••••••',
                                prefixIcon: Icons.verified_user_outlined,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Cybernetic Checkbox Row for Terms & Privacy
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor: Colors.white24,
                                    ),
                                    child: Checkbox(
                                      value: _isTermsAgreed,
                                      activeColor: const Color(0xFF00E5FF),
                                      checkColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isTermsAgreed = value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.shareTechMono(
                                        color: Colors.white54,
                                        fontSize: 12,
                                        height: 1.4,
                                        letterSpacing: 1,
                                      ),
                                      children: const [
                                        TextSpan(text: 'I AGREE TO THE '),
                                        TextSpan(
                                          text: 'TERMS OF SERVICE',
                                          style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: ' AND '),
                                        TextSpan(
                                          text: 'PRIVACY POLICY',
                                          style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Neon Cyan-to-Purple Main Action Button
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
                                  // Code execution for data storage would go here
                                  print("Registration data processed.");
                                  
                                  // Routes user forward to your Email Verification or Dashboard
                                  Navigator.pushNamed(context, '/verify-email');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'REGISTER',
                                  style: GoogleFonts.orbitron(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // "Or Register With" Horizontal Partition Layout
                            Row(
                              children: [
                                const Expanded(child: Divider(color: Colors.white10, thickness: 1)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    'OR REGISTER WITH',
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

                            // SSO Social Authentication Layout Grid Matrix
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSocialButton(fallbackIcon: Icons.g_mobiledata, iconColor: Colors.red),
                                _buildSocialButton(fallbackIcon: Icons.facebook, iconColor: const Color(0xFF1877F2)),
                                _buildSocialButton(fallbackIcon: Icons.mail, iconColor: const Color(0xFFEA4335)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Existing Account Navigation Redirect Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: GoogleFonts.shareTechMono(color: Colors.white54, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Pops back to login screen
                            },
                            child: Text(
                              'Log In',
                              style: GoogleFonts.shareTechMono(
                                color: const Color(0xFF00E5FF),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Footer System Encrypted Station Data
                      Column(
                        children: [
                          Text(
                            'STATION-ID: CRP-8812   SSL-ENCRYPTED',
                            style: GoogleFonts.shareTechMono(
                              color: Colors.white24,
                              fontSize: 11,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 36,
                            height: 2,
                            color: const Color(0xFF00E5FF).withOpacity(0.4),
                          )
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

  Widget _buildFieldLabel(String labelText) {
    return Text(
      labelText,
      style: GoogleFonts.shareTechMono(
        color: Colors.white60,
        fontSize: 12,
        letterSpacing: 1.5,
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
      hintStyle: GoogleFonts.shareTechMono(color: Colors.white24, fontSize: 14),
      prefixIcon: Icon(prefixIcon, color: Colors.white38, size: 18),
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

  Widget _buildSocialButton({required IconData fallbackIcon, required Color iconColor}) {
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
          onTap: () {},
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