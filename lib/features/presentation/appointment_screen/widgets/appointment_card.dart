import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';
import '../../video_call_screen/video_call_screen.dart';
import '../../session_notes_screen/session_notes_screen.dart';

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String patientId;
  final String age;
  final String phone;
  final String date;
  final String time;
  final String status;

  const AppointmentCard({
    super.key,
    required this.patientName,
    required this.patientId,
    required this.age,
    required this.phone,
    required this.date,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case "Confirmed":
        statusColor = ThemeConstants.statusConfirmed;
        break;
      case "Cancelled":
        statusColor = ThemeConstants.statusCancelled;
        break;
      default:
        statusColor = ThemeConstants.statusUnconfirmed;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ThemeConstants.cardColor,
        borderRadius: ThemeConstants.containerRadius,
        boxShadow: ThemeConstants.primaryShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: ThemeConstants.primaryColor.withAlpha(25),
                child: const Icon(
                  Icons.person,
                  color: ThemeConstants.primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ThemeConstants.textMainColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "ID: $patientId",
                      style: const TextStyle(
                        color: ThemeConstants.textMutedColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 30, color: Colors.black12),
          _buildDetailRow("Age", age),
          _buildDetailRow("Phone", phone),
          _buildDetailRow("Date", date),
          _buildDetailRow("Time", time),
          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: ThemeConstants.buttonRadius,
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SessionNotesScreen()),
                    );
                  },
                  icon: const Icon(Icons.note_alt_outlined, size: 18),
                  label: const Text(
                    "Notes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _buildPrimaryAction(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryAction(BuildContext context) {
    if (status == "Confirmed") {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeConstants.statusConfirmed,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: ThemeConstants.buttonRadius,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VideoCallScreen()),
          );
        },
        icon: const Icon(Icons.video_call, color: Colors.white),
        label: const Text(
          "Start Video Call",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    } else if (status == "Unconfirmed") {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeConstants.destructiveColor,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: ThemeConstants.buttonRadius,
          ),
        ),
        onPressed: () {},
        icon: const Icon(Icons.cancel, color: Colors.white, size: 18),
        label: const Text(
          "Cancel Appt.",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: ThemeConstants.buttonRadius,
          ),
          foregroundColor: ThemeConstants.textMutedColor,
          side: const BorderSide(color: ThemeConstants.textMutedColor),
        ),
        onPressed: null,
        icon: const Icon(Icons.info_outline, size: 18),
        label: const Text(
          "Cancelled",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: ThemeConstants.textMutedColor,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ThemeConstants.textMainColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
