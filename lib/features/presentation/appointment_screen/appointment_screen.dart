import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/presentation/video_call_screen/video_call_screen.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';
import 'widgets/appointment_filter_chip.dart';
import 'widgets/appointment_card.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedStatus = "All";

  List<Map<String, String>> get filteredAppointments {
    return appointments.where((appointment) {
      final search = _searchController.text.toLowerCase();
      final matchesSearch =
          appointment["patientName"]!.toLowerCase().contains(search) ||
              appointment["patientId"]!.toLowerCase().contains(search);

      final matchesStatus =
          selectedStatus == "All" || appointment["status"] == selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  final List<Map<String, String>> appointments = [
    {
      "patientName": "Alex Johnson",
      "patientId": "PAT1025",
      "age": "29",
      "phone": "+91 9876543210",
      "date": "25 July 2026",
      "time": "10:30 AM",
      "status": "Confirmed",
    },
    {
      "patientName": "Sarah Wilson",
      "patientId": "PAT1042",
      "age": "34",
      "phone": "+91 9988776655",
      "date": "25 July 2026",
      "time": "12:00 PM",
      "status": "Unconfirmed",
    },
    {
      "patientName": "Michael Brown",
      "patientId": "PAT1045",
      "age": "40",
      "phone": "+91 9876512345",
      "date": "25 July 2026",
      "time": "3:00 PM",
      "status": "Cancelled",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor, // Applied constant global theme canvas color
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConstants.cardColor,
        surfaceTintColor: ThemeConstants.cardColor,
        foregroundColor: ThemeConstants.textMainColor,
        title: const Text(
          "Appointments",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            /// Search box wrapped dynamically via text entry layout fields
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(color: ThemeConstants.textMainColor),
              decoration: InputDecoration(
                hintText: "Search patient by name or ID...",
                hintStyle: const TextStyle(color: ThemeConstants.textMutedColor),
                prefixIcon: const Icon(Icons.search, color: ThemeConstants.textMutedColor),
                filled: true,
                fillColor: ThemeConstants.inputFillColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: ThemeConstants.inputRadius, // Centralized inputs radius
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Horizontal Selection Chips Dashboard Row Bar
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: ["All", "Confirmed", "Unconfirmed", "Cancelled"].map((status) {
                  return AppointmentFilterChip(
                    status: status,
                    isSelected: selectedStatus == status,
                    onTap: () => setState(() => selectedStatus = status),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            /// Mapping dynamically structured cards mapping elements
            ...filteredAppointments.map((appointment) {
              return AppointmentCard(
                patientName: appointment["patientName"]!,
                patientId: appointment["patientId"]!,
                age: appointment["age"]!,
                phone: appointment["phone"]!,
                date: appointment["date"]!,
                time: appointment["time"]!,
                status: appointment["status"]!,
              );
            }),
          ],
        ),
      ),
    );
  }
}
