import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';

class AddNoteCard extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;

  const AddNoteCard({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ThemeConstants.cardColor,
        borderRadius: ThemeConstants.containerRadius,
        boxShadow: ThemeConstants.primaryShadow,
      ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 4,
            style: const TextStyle(color: ThemeConstants.textMainColor),
            decoration: InputDecoration(
              hintText: "Write consultation notes here...",
              hintStyle: const TextStyle(color: ThemeConstants.textMutedColor),
              filled: true,
              fillColor: ThemeConstants.backgroundColor, // Applied constant global theme canvas background tint
              border: OutlineInputBorder(
                borderRadius: ThemeConstants.inputRadius,
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeConstants.primaryColor, // Tied directly to global primary token
                shape: RoundedRectangleBorder(
                  borderRadius: ThemeConstants.buttonRadius,
                ),
                elevation: 0,
              ),
              onPressed: onSave,
              icon: const Icon(Icons.save_rounded, color: Colors.white, size: 20),
              label: const Text(
                "Save Session Note",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
