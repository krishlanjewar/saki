import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary brand color based on the design (purple palette)
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF908CFF);
  static const Color primaryDark = Color(0xFF4B42D1);

  // Background and surface colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Colors.white;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text colors
  static const Color textPrimaryLight = Color(0xFF2D3142);
  static const Color textSecondaryLight = Color(0xFF9094A6);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFA0A0A0);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF64B5F6);
}
