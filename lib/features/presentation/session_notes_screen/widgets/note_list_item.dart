import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';

class NoteListItem extends StatelessWidget {
  final String noteText;
  final String timeStamp;

  const NoteListItem({
    super.key,
    required this.noteText,
    required this.timeStamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ThemeConstants.cardColor,
        borderRadius: ThemeConstants.containerRadius,
        boxShadow: ThemeConstants.primaryShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: ThemeConstants.primaryColor.withAlpha(25),
            child: const Icon(
              Icons.note_alt_outlined,
              color: ThemeConstants.primaryColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noteText,
                  style: const TextStyle(
                    height: 1.5,
                    color: ThemeConstants.textMainColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: ThemeConstants.textMutedColor.withAlpha(120),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeStamp,
                      style: const TextStyle(
                        color: ThemeConstants.textMutedColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
