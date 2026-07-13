import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';

class ProfileMetricCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final IconData icon;

  const ProfileMetricCard({
    super.key,
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: ThemeConstants.cardColor,
          borderRadius: BorderRadius.circular(16), // Maintained granular 16 radius for nested sub-card aesthetic uniformity
          boxShadow: ThemeConstants.subtleShadow, // Configured subtle layout shadow token
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color.withAlpha(25), // Tint fallback logic preserving unique multi-color action items
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.textMainColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: ThemeConstants.textMutedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
