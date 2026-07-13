import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';

class LocalVideoWidget extends StatelessWidget {
  final RTCVideoRenderer renderer;
  final bool isCameraOn;

  const LocalVideoWidget({
    super.key,
    required this.renderer,
    required this.isCameraOn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24, width: 1),
        boxShadow: ThemeConstants.subtleShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: isCameraOn
            ? RTCVideoView(
          renderer,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          mirror: true,
        )
            : Container(
          color: Colors.grey[900],
          child: const Center(
            child: Icon(
              Icons.videocam_off,
              color: Colors.white54,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
