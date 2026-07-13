import 'package:flutter/material.dart';

class ThemeConstants {
  // Global App Colors
  static const Color primaryColor = Color(0xff1976D2);
  static const Color backgroundColor = Color(0xffF5F7FB);
  static const Color cardColor = Colors.white;
  static const Color inputFillColor = Colors.white;
  static const Color textMainColor = Colors.black87;
  static const Color textMutedColor = Colors.grey;

  // Status Colors
  static const Color statusConfirmed = Colors.green;
  static const Color statusUnconfirmed = Colors.orange;
  static const Color statusCancelled = Colors.red;
  static const Color destructiveColor = Colors.redAccent;

  // Modern Flat Shadows matching your design tokens
  static const List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> subtleShadow = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6,
      offset: Offset(0, 1),
    ),
  ];

  // Global Border Radius Constants
  static final BorderRadius containerRadius = BorderRadius.circular(18);
  static final BorderRadius buttonRadius = BorderRadius.circular(20);
  static final BorderRadius inputRadius = BorderRadius.circular(14);
}