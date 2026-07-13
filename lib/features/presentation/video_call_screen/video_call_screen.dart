import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../core/webrtc/webrtc_service.dart';
import 'widgets/call_controls.dart';
import 'widgets/local_video.dart';
import 'widgets/remote_video.dart';
import '../../core/theme/theme_constants.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final WebRTCService _webRTCService = WebRTCService();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  bool _isRemoteConnected = false;

  @override
  void initState() {
    super.initState();
    _initializeWebRTC();
  }

  Future<void> _initializeWebRTC() async {
    try {
      await _localRenderer.initialize();
      await _remoteRenderer.initialize();
      await _webRTCService.openUserMedia(_localRenderer);

      await _webRTCService.createPeerConnectionInstance(
        remoteRenderer: _remoteRenderer,
        onIceCandidate: (candidate) {},
        onTrackAdded: (stream) {
          if (mounted) {
            setState(() {
              _isRemoteConnected = true;
            });
          }
        },
      );

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint("Error initializing WebRTC: $e");
    }
  }

  void _promptCallClosureSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ThemeConstants.backgroundColor,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Icon(Icons.help_outline_rounded, size: 48, color: ThemeConstants.primaryColor),
                const SizedBox(height: 14),
                Text(
                  "Session Verification",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ThemeConstants.textMainColor),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Has the patient consultation completely finished, or did the call terminate unexpectedly due to network drops?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ThemeConstants.textMutedColor, height: 1.4, fontSize: 14),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    // Network Issue / Reconnect Option
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: ThemeConstants.primaryColor),
                          shape: RoundedRectangleBorder(borderRadius: ThemeConstants.buttonRadius),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Re-establishing WebRTC signal track lines..."),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: const Text(
                          "Network Drop / Retry",
                          style: TextStyle(fontWeight: FontWeight.bold, color: ThemeConstants.primaryColor, fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Consultation Completed Option
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeConstants.statusConfirmed,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: ThemeConstants.buttonRadius),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          _executeHardTearDown(isCompleted: true);
                        },
                        child: const Text(
                          "Yes, Consultation Over",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Master single implementation path passing completion boolean markers out safely
  void _executeHardTearDown({bool isCompleted = false}) async {
    await _webRTCService.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    if (mounted) {
      Navigator.pop(context, isCompleted);
    }
  }

  @override
  void dispose() {
    _webRTCService.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: RemoteVideoWidget(
                renderer: _remoteRenderer,
                isRemoteConnected: _isRemoteConnected,
              ),
            ),

            /// Header Card Panel
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alex Johnson",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "00:05:32",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _isRemoteConnected ? ThemeConstants.statusConfirmed : ThemeConstants.statusUnconfirmed,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      _isRemoteConnected ? "Connected" : "Signaling...",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),

            /// PIP Local View
            Positioned(
              right: 20,
              top: 90,
              child: SizedBox(
                width: 120,
                height: 170,
                child: LocalVideoWidget(
                  renderer: _localRenderer,
                  isCameraOn: _webRTCService.isCameraOn,
                ),
              ),
            ),

            /// Controls Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CallControlsWidget(
                isMicOn: _webRTCService.isMicOn,
                isCameraOn: _webRTCService.isCameraOn,
                isSpeakerOn: _webRTCService.isSpeakerOn,
                onToggleMic: () {
                  if (mounted) {
                    setState(() {
                      _webRTCService.toggleMic();
                    });
                  }
                },
                onToggleCamera: () {
                  if (mounted) {
                    setState(() {
                      _webRTCService.toggleCamera();
                    });
                  }
                },
                onToggleSpeaker: () {
                  if (mounted) {
                    setState(() {
                      _webRTCService.toggleSpeaker();
                    });
                  }
                },
                onSwitchCamera: () async {
                  await _webRTCService.switchCamera();
                  if (mounted) {
                    setState(() {});
                  }
                },
                onHangUp: _promptCallClosureSheet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}