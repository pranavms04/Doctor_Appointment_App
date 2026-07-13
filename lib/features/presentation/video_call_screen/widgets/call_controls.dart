import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';

class CallControlsWidget extends StatelessWidget {
  final bool isMicOn;
  final bool isCameraOn;
  final bool isSpeakerOn;

  final VoidCallback onToggleMic;
  final VoidCallback onToggleCamera;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onSwitchCamera;
  final VoidCallback onHangUp;

  const CallControlsWidget({
    super.key,
    required this.isMicOn,
    required this.isCameraOn,
    required this.isSpeakerOn,
    required this.onToggleMic,
    required this.onToggleCamera,
    required this.onToggleSpeaker,
    required this.onSwitchCamera,
    required this.onHangUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.black54, // Corrected typo and kept dark overlay color for video overlay contrast readability
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Audio Route (Speaker / Earpiece) Toggle
          _buildControlButton(
            icon: isSpeakerOn ? Icons.volume_up : Icons.volume_down,
            color: isSpeakerOn ? ThemeConstants.primaryColor : Colors.white24,
            iconColor: Colors.white,
            onPressed: onToggleSpeaker,
          ),

          // Microphone Toggle
          _buildControlButton(
            icon: isMicOn ? Icons.mic : Icons.mic_off,
            color: isMicOn ? Colors.white24 : ThemeConstants.destructiveColor,
            iconColor: Colors.white,
            onPressed: onToggleMic,
          ),

          // Camera On/Off Toggle
          _buildControlButton(
            icon: isCameraOn ? Icons.videocam : Icons.videocam_off,
            color: isCameraOn ? Colors.white24 : ThemeConstants.destructiveColor,
            iconColor: Colors.white,
            onPressed: onToggleCamera,
          ),

          // Switch Front/Rear Camera
          _buildControlButton(
            icon: Icons.flip_camera_ios,
            color: Colors.white24,
            iconColor: Colors.white,
            onPressed: onSwitchCamera,
          ),

          // End Call Button
          _buildControlButton(
            icon: Icons.call_end,
            color: ThemeConstants.statusCancelled,
            iconColor: Colors.white,
            onPressed: onHangUp,
            isLarge: true,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onPressed,
    bool isLarge = false,
  }) {
    final double size = isLarge ? 64.0 : 52.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor, size: isLarge ? 28 : 24),
        onPressed: onPressed,
      ),
    );
  }
}
