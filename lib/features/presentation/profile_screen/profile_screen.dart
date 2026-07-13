import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';
import 'widgets/profile_metric_card.dart';
import 'widgets/profile_option_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor, // Applied centralized canvas color token
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConstants.cardColor,
        surfaceTintColor: ThemeConstants.cardColor,
        foregroundColor: ThemeConstants.textMainColor,
        title: const Text(
          "Doctor Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Edit Profile feature coming soon!"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            /// Header Card (Avatar + Doctor Basic info)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ThemeConstants.cardColor,
                borderRadius: ThemeConstants.containerRadius,
                boxShadow: ThemeConstants.primaryShadow,
              ),
              child: Column(
                children: [
                  const Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/150?img=8",
                        ),
                      ),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.green, // Visual status indicator dot preserved natively
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Dr. John Doe",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ThemeConstants.textMainColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Cardiologist • MBBS, MD",
                    style: TextStyle(
                      fontSize: 14,
                      color: ThemeConstants.textMutedColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "License ID: LIC-98765-2026",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const Divider(height: 30, color: Colors.black12),

                  /// Quick Status Toggle Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Consultation Status",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            _isAvailable
                                ? "Available for Video Calls"
                                : "Off-duty / Busy",
                            style: TextStyle(
                              color: _isAvailable ? Colors.green : ThemeConstants.destructiveColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: _isAvailable,
                        activeColor: Colors.green,
                        onChanged: (val) {
                          setState(() {
                            _isAvailable = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// Analytical Metrics Section
            Row(
              children: [
                ProfileMetricCard(
                  value: "1.2k+",
                  label: "Patients",
                  color: Colors.blue,
                  icon: Icons.people_outline,
                ),
                const SizedBox(width: 12),
                ProfileMetricCard(
                  value: "890+",
                  label: "Video Calls",
                  color: ThemeConstants.statusConfirmed,
                  icon: Icons.video_call_outlined,
                ),
                const SizedBox(width: 12),
                ProfileMetricCard(
                  value: "4.9",
                  label: "Rating",
                  color: ThemeConstants.statusUnconfirmed,
                  icon: Icons.star_border_rounded,
                ),
              ],
            ),
            const SizedBox(height: 25),

            /// Professional Settings Options Block
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Account Management",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: ThemeConstants.cardColor,
                borderRadius: ThemeConstants.containerRadius,
                boxShadow: ThemeConstants.primaryShadow,
              ),
              child: Column(
                children: [
                  ProfileOptionTile(
                    icon: Icons.calendar_month_outlined,
                    title: "Manage Availability Slots",
                    subtitle: "Set daily online parameters",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 55, color: Colors.black12),
                  ProfileOptionTile(
                    icon: Icons.verified_user_outlined,
                    title: "Security & KYC Verification",
                    subtitle: "Review WebRTC digital signatures",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 55, color: Colors.black12),
                  ProfileOptionTile(
                    icon: Icons.wallet_outlined,
                    title: "Payouts & Remittance",
                    subtitle: "View consultation billing cycles",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 55, color: Colors.black12),
                  ProfileOptionTile(
                    icon: Icons.help_outline_rounded,
                    title: "Technical Help Desk",
                    subtitle: "Test WebRTC camera/audio pipelines",
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            /// Secure Logout Option Trigger
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: ThemeConstants.destructiveColor,
                  side: const BorderSide(color: ThemeConstants.destructiveColor),
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(
                    borderRadius: ThemeConstants.buttonRadius,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text(
                  "Log Out of Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
