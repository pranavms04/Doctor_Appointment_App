import 'package:flutter/material.dart';
import '../../core/theme/theme_constants.dart';
import 'package:doctor_appointment_app/features/presentation/appointment_screen/appointment_screen.dart';
import 'package:doctor_appointment_app/features/presentation/session_notes_screen/session_notes_screen.dart';
import 'package:doctor_appointment_app/features/presentation/video_call_screen/video_call_screen.dart';
import 'package:doctor_appointment_app/features/presentation/profile_screen/profile_screen.dart';
import 'package:doctor_appointment_app/features/presentation/home_screen/widgets/custom_navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _callQueue = [
    {
      "name": "Alex Johnson",
      "id": "PAT1025",
      "age": "29",
      "phone": "+91 9876543210",
      "reason": "Cardiology Follow-up",
      "time": "10:30 AM",
      "status": "Confirmed",
      "initials": "AJ",
    },
    {
      "name": "Marcus Vance",
      "id": "PAT0982",
      "age": "42",
      "phone": "+91 8765432109",
      "reason": "General Checkup",
      "time": "11:15 AM",
      "status": "Confirmed",
      "initials": "MV",
    },
  ];

  void _showCallSelectionSheet(
      BuildContext context, {
        Map<String, String>? initialSelectedPatient,
      }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ThemeConstants.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  initialSelectedPatient != null
                      ? "Confirm Video Call Session"
                      : "Select Patient to Call",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: initialSelectedPatient != null ? 1 : _callQueue.length,
                    itemBuilder: (ctx, index) {
                      final patient = initialSelectedPatient ?? _callQueue[index];
                      final bool isCompleted = patient["status"] == "Completed";

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        color: ThemeConstants.cardColor,
                        elevation: 0,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: (isCompleted ? Colors.blue : ThemeConstants.statusConfirmed).withAlpha(25),
                            child: Text(
                              patient["initials"]!,
                              style: TextStyle(
                                color: isCompleted ? Colors.blue : ThemeConstants.statusConfirmed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            patient["name"]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${patient["id"]} • ${patient["reason"]}\nStatus: ${patient["status"]}",
                            style: const TextStyle(fontSize: 12, height: 1.4),
                          ),
                          isThreeLine: true,
                          trailing: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isCompleted ? Colors.grey : ThemeConstants.statusConfirmed,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                            ),
                            icon: Icon(
                              isCompleted ? Icons.check_circle_outline : Icons.video_call_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: Text(
                              isCompleted ? "Done" : "Join",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            onPressed: isCompleted
                                ? null
                                : () async {
                              Navigator.pop(context);
                              final sessionFinished = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(builder: (_) => const VideoCallScreen()),
                              );

                              if (sessionFinished == true) {
                                setState(() {
                                  patient["status"] = "Completed";
                                });
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConstants.cardColor,
        surfaceTintColor: ThemeConstants.cardColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome", style: TextStyle(fontSize: 13, color: ThemeConstants.textMutedColor)),
            const Text(
              "Dr. John Doe",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(icon: const Icon(Icons.notifications_none_rounded), onPressed: () {}),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  // Fixed: Removed 'const' keyword preceding this container block to accept variables dynamically
                  decoration: BoxDecoration(
                    color: ThemeConstants.statusCancelled,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=8")),
          ),
        ],
      ),
      drawer: CustomNavigationDrawer(onVideoCallTap: () => _showCallSelectionSheet(context)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Doctor Card Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: ThemeConstants.primaryColor,
                borderRadius: ThemeConstants.containerRadius,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 35, color: ThemeConstants.primaryColor),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dr. John Doe",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text("Cardiologist", style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text("Quick Actions", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.2,
              children: [
                _dashboardCard(
                  icon: Icons.calendar_today,
                  title: "Appointments",
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AppointmentScreen()));
                  },
                ),
                _dashboardCard(
                  icon: Icons.video_call,
                  title: "Video Call",
                  color: ThemeConstants.statusConfirmed,
                  onTap: () => _showCallSelectionSheet(context),
                ),
                _dashboardCard(
                  icon: Icons.note_alt_outlined,
                  title: "Session Notes",
                  color: ThemeConstants.statusUnconfirmed,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SessionNotesScreen()));
                  },
                ),
                _dashboardCard(
                  icon: Icons.person_outline,
                  title: "Profile",
                  color: Colors.purple,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text("Today's Appointments Queue", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _callQueue.length,
              itemBuilder: (context, index) {
                final patient = _callQueue[index];
                final bool isCompleted = patient["status"] == "Completed";

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
                      _detailRow("Patient", patient["name"]!),
                      _detailRow("Patient ID", patient["id"]!),
                      _detailRow("Reason", patient["reason"]!),
                      _detailRow("Age", patient["age"]!),
                      _detailRow("Phone", patient["phone"]!),
                      _detailRow("Time", patient["time"]!),
                      _detailRow(
                          "Status",
                          patient["status"]!,
                          textColor: isCompleted ? Colors.blue : (patient["status"] == "Confirmed" ? ThemeConstants.statusConfirmed : ThemeConstants.textMainColor)
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                shape: RoundedRectangleBorder(borderRadius: ThemeConstants.buttonRadius),
                                alignment: Alignment.center,
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const SessionNotesScreen()));
                              },
                              icon: const Icon(Icons.note_add, size: 20),
                              label: const Text("Notes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isCompleted ? Colors.grey : ThemeConstants.statusConfirmed,
                                minimumSize: const Size.fromHeight(48),
                                shape: RoundedRectangleBorder(borderRadius: ThemeConstants.buttonRadius),
                              ),
                              onPressed: isCompleted ? null : () async {
                                final sessionFinished = await Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const VideoCallScreen(),
                                  ),
                                );

                                if (sessionFinished == true) {
                                  setState(() {
                                    patient["status"] = "Completed";
                                  });
                                }
                              },
                              icon: Icon(
                                isCompleted ? Icons.check_circle : Icons.video_call,
                                color: Colors.white,
                              ),
                              label: Text(
                                isCompleted ? "Consultation Completed" : "Start Video Call",
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ThemeConstants.cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: ThemeConstants.primaryShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withAlpha(25),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: ThemeConstants.textMainColor)),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value, {Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: ThemeConstants.textMutedColor, fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor ?? ThemeConstants.textMainColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}