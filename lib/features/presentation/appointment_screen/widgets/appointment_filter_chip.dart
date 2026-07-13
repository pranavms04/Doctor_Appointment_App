import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';

class AppointmentFilterChip extends StatelessWidget {
  final String status;
  final bool isSelected;
  final VoidCallback onTap;

  const AppointmentFilterChip({
    super.key,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20), // Maintained specific circular layout constraint for modern tab styling
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? ThemeConstants.primaryColor : ThemeConstants.cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: ThemeConstants.subtleShadow, // Replaced with central subtle shadow token
          ),
          child: Center(
            child: Text(
              status,
              style: TextStyle(
                color: isSelected ? Colors.white : ThemeConstants.textMainColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
