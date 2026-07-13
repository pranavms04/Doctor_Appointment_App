import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';
import '../../video_call_screen/video_call_screen.dart';
import '../../session_notes_screen/session_notes_screen.dart';

class PatientDirectoryCard extends StatelessWidget {
  final Map<String, String> patient;

  const PatientDirectoryCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeConstants.cardColor,
        borderRadius: ThemeConstants.containerRadius,
        boxShadow: ThemeConstants.primaryShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: ThemeConstants.primaryColor.withAlpha(25),
                child: Text(
                  patient["initials"]!,
                  style: const TextStyle(
                    color: ThemeConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient["name"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ThemeConstants.textMainColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${patient["id"]} • ${patient["gender"]}, ${patient["age"]} yrs",
                      style: const TextStyle(color: ThemeConstants.textMutedColor, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: ThemeConstants.primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Blood: ${patient["bloodGroup"]}",
                  style: const TextStyle(
                    color: ThemeConstants.primaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: Colors.black12),
          _buildInfoRow(
            Icons.healing_outlined,
            "Condition",
            patient["condition"]!,
          ),
          _buildInfoRow(
            Icons.phone_android_rounded,
            "Contact",
            patient["phone"]!,
          ),
          _buildInfoRow(
            Icons.history_toggle_off_rounded,
            "Last Encounter",
            patient["lastVisit"]!,
          ),
          const SizedBox(height: 16),

          /// Action Row Controls
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: ThemeConstants.buttonRadius,
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SessionNotesScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.note_add_outlined, size: 18),
                  label: const Text(
                    "Notes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeConstants.statusConfirmed,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: ThemeConstants.buttonRadius,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VideoCallScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.video_call_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: const Text(
                    "Start Session",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 15, color: ThemeConstants.textMutedColor.withAlpha(120)),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(
              fontSize: 12,
              color: ThemeConstants.textMutedColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: ThemeConstants.textMainColor,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
