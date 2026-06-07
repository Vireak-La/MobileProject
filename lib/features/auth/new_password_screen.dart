import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. IMPORT YOUR NEXT TARGET PAGE HERE:
import 'package:mobileproject/features/auth/login_screen.dart';

class CyberRigNewPasswordPage extends StatefulWidget {
  const CyberRigNewPasswordPage({super.key});

  @override
  State<CyberRigNewPasswordPage> createState() => _CyberRigNewPasswordPageState();
}

class _CyberRigNewPasswordPageState extends State<CyberRigNewPasswordPage> {
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                      onPressed: () {
                        // Routing close button to LoginScreen instead of a basic pop
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const CyberRigLoginPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
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

                      // Main Container utilizing CustomPainter for the cybernetic corners
                      CustomPaint(
                        painter: CyberGridCornersPainter(),
                        child: Container(
                          padding: const EdgeInsets.all(28.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF121214).withOpacity(0.85),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              
                              // Main Header Title with Electric Cyan Highlight
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.orbitron(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    height: 1.3,
                                  ),
                                  children: const [
                                    TextSpan(text: 'CREATE NEW '),
                                    TextSpan(
                                      text: 'ACCESS\nKEY',
                                      style: TextStyle(color: Color(0xFF00E5FF)),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 14),
                              
                              // Monospace descriptive subtitle 
                              Text(
                                'Set a new secure password for your operator account.',
                                style: GoogleFonts.shareTechMono(
                                  fontSize: 14,
                                  color: Colors.white38,
                                  height: 1.4,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              
                              const SizedBox(height: 36),

                              // 1. NEW PASSWORD FIELD
                              _buildFieldLabel('NEW PASSWORD'),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _passwordController,
                                obscureText: _isPasswordObscured,
                                style: GoogleFonts.shareTechMono(color: Colors.white, letterSpacing: 2),
                                decoration: _buildInputDecoration(
                                  hintText: '•••••••••••••',
                                  isObscured: _isPasswordObscured,
                                  onToggle: () {
                                    setState(() {
                                      _isPasswordObscured = !_isPasswordObscured;
                                    });
                                  },
                                ),
                              ),
                              
                              const SizedBox(height: 28),

                              // 2. CONFIRM NEW PASSWORD FIELD
                              _buildFieldLabel('CONFIRM NEW PASSWORD'),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _confirmPasswordController,
                                obscureText: _isConfirmPasswordObscured,
                                style: GoogleFonts.shareTechMono(color: Colors.white, letterSpacing: 2),
                                decoration: _buildInputDecoration(
                                  hintText: '•••••••••••••',
                                  isObscured: _isConfirmPasswordObscured,
                                  onToggle: () {
                                    setState(() {
                                      _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(height: 36),

                              // UPDATE PASSWORD Gradient Button
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
                                    String pass = _passwordController.text;
                                    String confirmPass = _confirmPasswordController.text;
                                    
                                    // Match validation verify logic
                                    if (pass.isNotEmpty && pass == confirmPass) {
                                      print("Bypassing validation check. Navigating to LoginScreen...");
                                      
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => CyberRigLoginPage()), // Use your actual login class name here
                                        (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      print("Validation failure: Vectors mismatch or fields empty.");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'UPDATE PASSWORD',
                                    style: GoogleFonts.orbitron(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 28),
                              const Divider(color: Colors.white10, thickness: 1),
                              const SizedBox(height: 16),

                              // Return to Terminal Login link
                              GestureDetector(
                                onTap: () {
                                  // ACTION 2: Direct routing back to LoginScreen resetting the backstack
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const CyberRigLoginPage()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.arrow_back_ios, color: Colors.white38, size: 12),
                                      const SizedBox(width: 6),
                                      Text(
                                        'RETURN TO TERMINAL LOGIN',
                                        style: GoogleFonts.shareTechMono(
                                          color: Colors.white38,
                                          fontSize: 13,
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 48),

                      // Bottom Support Link Footnote External to Card Frame
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Need help? ',
                            style: GoogleFonts.shareTechMono(color: Colors.white54, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Contacting System Administration Support channels...");
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
    required bool isObscured,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.shareTechMono(color: Colors.white12, fontSize: 16, letterSpacing: 2),
      suffixIcon: IconButton(
        icon: Icon(
          isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: Colors.white38,
          size: 20,
        ),
        onPressed: onToggle,
      ),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 1.2),
      ),
    );
  }
}

class CyberGridCornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const double lineLength = 16.0;

    // Top Left Corner
    canvas.drawLine(const Offset(0, 0), const Offset(lineLength, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, lineLength), paint);

    // Top Right Corner
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - lineLength, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, lineLength), paint);

    // Bottom Left Corner
    canvas.drawLine(Offset(0, size.height), Offset(lineLength, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - lineLength), paint);

    // Bottom Right Corner
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - lineLength, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - lineLength), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}