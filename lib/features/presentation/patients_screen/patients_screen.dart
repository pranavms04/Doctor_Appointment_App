import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';
import 'widgets/patient_directory_card.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final List<Map<String, String>> _allPatients = [
    {
      "name": "Alex Johnson",
      "id": "PAT1025",
      "age": "29",
      "gender": "Male",
      "phone": "+91 9876543210",
      "bloodGroup": "O+",
      "lastVisit": "Today, 10:30 AM",
      "condition": "Cardiology Follow-up",
      "initials": "AJ",
    },
    {
      "name": "Marcus Vance",
      "id": "PAT0982",
      "age": "42",
      "gender": "Male",
      "phone": "+91 8765432109",
      "bloodGroup": "A-",
      "lastVisit": "Today, 11:15 AM",
      "condition": "General Checkup",
      "initials": "MV",
    },
  ];

  List<Map<String, String>> _filteredPatients = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredPatients = _allPatients;
  }

  void _filterSearch(String query) {
    setState(() {
      _filteredPatients = _allPatients
          .where(
            (p) =>
        p["name"]!.toLowerCase().contains(query.toLowerCase()) ||
            p["id"]!.toLowerCase().contains(query.toLowerCase()),
      )
          .toList();
    });
  }

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
          "My Patients",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          /// Real-time Search Header Panel
          Container(
            color: ThemeConstants.cardColor,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSearch,
              style: const TextStyle(color: ThemeConstants.textMainColor),
              decoration: InputDecoration(
                hintText: "Search by name or Patient ID...",
                hintStyle: const TextStyle(color: ThemeConstants.textMutedColor),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: ThemeConstants.textMutedColor,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: ThemeConstants.textMutedColor,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _filterSearch("");
                  },
                )
                    : null,
                filled: true,
                fillColor: ThemeConstants.backgroundColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: ThemeConstants.inputRadius,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// Dynamic Scrollable Directory Grid List
          Expanded(
            child: _filteredPatients.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_search_rounded,
                    size: 64,
                    color: ThemeConstants.textMutedColor.withAlpha(100),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "No patients found matching records",
                    style: const TextStyle(
                      color: ThemeConstants.textMutedColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: _filteredPatients.length,
              itemBuilder: (context, index) {
                return PatientDirectoryCard(
                  patient: _filteredPatients[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
