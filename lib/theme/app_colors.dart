import 'package:flutter/material.dart';

class AppColors {
  // Dark Backgrounds
  static const Color background = Color(0xFF070B11);
  static const Color surface = Color(0xFF0F1622);
  static const Color surfaceCard = Color(0xFF162031);
  static const Color surfaceElevated = Color(0xFF1E2B40);

  // RGB Gamer Accents
  static const Color neonCyan = Color(0xFF00F2FE);
  static const Color neonMagenta = Color(0xFFF355DA);
  static const Color neonGreen = Color(0xFF39FF14);
  static const Color neonOrange = Color(0xFFFF6B00);

  // Status/Utility Colors
  static const Color primary = neonCyan;
  static const Color secondary = neonMagenta;
  static const Color accent = neonGreen;
  
  static const Color textPrimary = Color(0xFFF0F4F8);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Gradients
  static const LinearGradient cyanMagentaGradient = LinearGradient(
    colors: [neonCyan, neonMagenta],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient rgbGradient = LinearGradient(
    colors: [neonCyan, neonMagenta, neonGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF111827), Color(0xFF1F2937)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
