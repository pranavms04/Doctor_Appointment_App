import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';

class RemoteVideoWidget extends StatelessWidget {
  final RTCVideoRenderer renderer;
  final bool isRemoteConnected;

  const RemoteVideoWidget({
    super.key,
    required this.renderer,
    required this.isRemoteConnected,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRemoteConnected) {
      return Container(
        color: Colors.grey[950],
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: ThemeConstants.primaryColor),
              SizedBox(height: 16),
              Text(
                'Connecting to peer...',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: RTCVideoView(
        renderer,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
      ),
    );
  }
}
