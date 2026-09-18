import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF1A5AC0);
  static const Color primaryDark = Color(0xFF0D3D8C);
  static const Color primaryLight = Color(0xFF4A7FD4);

  // Secondary
  static const Color secondary = Color(0xFFFFA0F0);
  static const Color secondaryDark = Color(0xFFE07DD0);
  static const Color secondaryLight = Color(0xFFFFC5F5);

  // Background
  static const Color background = Color(0xFFF0F0FA);
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Status (Bus capacity)
  static const Color available = Color(0xFF4CAF50);   // سبز - ظرفیت
  static const Color almostFull = Color(0xFFFF9800);  // نارنجی - نزدیک پر
  static const Color full = Color(0xFFE53935);        // قرمز - پر

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B6B80);
  static const Color textHint = Color(0xFF9E9EAF);
  static const Color textOnPrimary = Colors.white;

  // Divider & Border
  static const Color divider = Color(0xFFE0E0EE);
  static const Color border = Color(0xFFD0D0E0);

  // Disabled
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color disabledBackground = Color(0xFFEEEEEE);
}
