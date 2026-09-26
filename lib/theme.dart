import 'package:flutter/material.dart';

/// Student name shown on the Home screen.
const String kStudentName = 'Tanim Ahmed';

class AppColors {
  static const ink = Color(0xFF3B3B4F); // titles
  static const text = Color(0xFF1E1E2A);
  static const muted = Color(0xFF8A8A98);
  static const line = Color(0xFFDADAE2);

  static const teal = Color(0xFF0A6F69); // filled CTA
  static const deepTeal = Color(0xFF06443F); // Next / outlined CTA

  static const quizBg = Color(0xFFF0F0F0);
  static const progress = Color(0xFF2F6BE8);
  static const progressTrack = Color(0xFFD9D9D9);
  static const slider = Color(0xFF1E90FF);
  static const sliderTrack = Color(0xFFDCE7F5);

  static const correctFill = Color(0xFFA9D2C6);
  static const wrongFill = Color(0xFFFF9E9E);
  static const wrongIcon = Color(0xFFD6204F);

  static const passBox = Color(0xFF83E5A4);
  static const passHalo = Color(0xFFD5F5DF);
  static const failBox = Color(0xFFFF4A00);
  static const failHalo = Color(0xFFFFB8B0);
}

// Use local/system fonts so the app works without external downloads.
TextStyle outfit(double size,
        {FontWeight weight = FontWeight.w600, Color color = AppColors.text}) =>
    TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      fontFamily: 'SF Pro Display',
      fontFamilyFallback: const ['Segoe UI', 'Arial', 'sans-serif'],
    );

TextStyle baloo(double size,
        {FontWeight weight = FontWeight.w700,
        Color color = AppColors.text,
        double? height}) =>
    TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      fontFamily: 'Trebuchet MS',
      fontFamilyFallback: const ['Segoe UI', 'Arial', 'sans-serif'],
    );

TextStyle lora(double size, {Color color = AppColors.muted}) => TextStyle(
      fontSize: size,
      color: color,
      fontFamily: 'Georgia',
      fontFamilyFallback: const ['Times New Roman', 'serif'],
    );

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.teal),
    scaffoldBackgroundColor: Colors.white,
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'SF Pro Display'),
  );
}
