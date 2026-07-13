import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';
import '../../appointment_screen/appointment_screen.dart';
import '../../session_notes_screen/session_notes_screen.dart';
import '../../video_call_screen/video_call_screen.dart';
import '../../profile_screen/profile_screen.dart';
import '../../patients_screen/patients_screen.dart';
import '../../login_screen/login_screen.dart';

class CustomNavigationDrawer extends StatelessWidget {
  final VoidCallback onVideoCallTap;
  final String currentRouteName;

  const CustomNavigationDrawer({
    super.key,
    required this.onVideoCallTap,
    this.currentRouteName = 'Dashboard',
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ThemeConstants.backgroundColor, // Applied custom token background canvas
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          /// Modern Blue Block Drawer Header Profile Card
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
              color: ThemeConstants.primaryColor, // Linked directly to global primary token
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
              ),
            ),
            accountName: const Text(
              "Dr. John Doe",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            accountEmail: const Text(
              "doctor@gmail.com",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 3),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 36, color: ThemeConstants.primaryColor),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Navigation Links List Container
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              children: [
                _buildDrawerTile(
                  context,
                  icon: Icons.dashboard_outlined,
                  activeIcon: Icons.dashboard,
                  title: "Dashboard",
                  isActive: currentRouteName == 'Dashboard',
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.calendar_month_outlined,
                  activeIcon: Icons.calendar_month,
                  title: "Appointments",
                  isActive: currentRouteName == 'Appointments',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AppointmentScreen()),
                    );
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.video_call_outlined,
                  activeIcon: Icons.video_call,
                  title: "Video Calls",
                  isActive: currentRouteName == 'Video Calls',
                  onTap: () {
                    Navigator.pop(context);
                    onVideoCallTap();
                  },
                ),

                _buildSectionDivider(),

                _buildDrawerTile(
                  context,
                  icon: Icons.note_alt_outlined,
                  activeIcon: Icons.note_alt,
                  title: "Session Notes",
                  isActive: currentRouteName == 'Session Notes',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SessionNotesScreen()),
                    );
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.people_outline_rounded,
                  activeIcon: Icons.people_rounded,
                  title: "Patients",
                  isActive: currentRouteName == 'Patients',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PatientsScreen()),
                    );
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  title: "Profile",
                  isActive: currentRouteName == 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          _buildSectionDivider(),

          /// Persistent Bottom Logout Action Footer
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 20),
            child: _buildDrawerTile(
              context,
              icon: Icons.logout_rounded,
              activeIcon: Icons.logout_rounded,
              title: "Logout",
              isActive: false,
              isDestructive: true,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Structural separator using precise margin balancing loops
  Widget _buildSectionDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Divider(
        color: ThemeConstants.textMainColor.withAlpha(20), // Tied selector breakdown rules to main body color
        height: 1,
        thickness: 1,
      ),
    );
  }

  /// Master multi-state custom component tile renderer
  Widget _buildDrawerTile(
      BuildContext context, {
        required IconData icon,
        required IconData activeIcon,
        required String title,
        required bool isActive,
        required VoidCallback onTap,
        bool isDestructive = false,
      }) {
    final Color tileBg = isActive ? ThemeConstants.primaryColor.withAlpha(25) : Colors.transparent;
    final Color elementColor = isDestructive
        ? ThemeConstants.destructiveColor
        : (isActive ? ThemeConstants.primaryColor : ThemeConstants.textMutedColor);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: tileBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        horizontalTitleGap: 12,
        visualDensity: const VisualDensity(vertical: -1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          isActive ? activeIcon : icon,
          color: elementColor,
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive
                ? ThemeConstants.destructiveColor
                : (isActive ? ThemeConstants.primaryColor : ThemeConstants.textMainColor),
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 14,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
