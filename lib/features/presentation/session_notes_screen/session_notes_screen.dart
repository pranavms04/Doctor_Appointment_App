import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';
import 'widgets/add_note_card.dart';
import 'widgets/note_list_item.dart';

class SessionNotesScreen extends StatefulWidget {
  const SessionNotesScreen({super.key});

  @override
  State<SessionNotesScreen> createState() => _SessionNotesScreenState();
}

class _SessionNotesScreenState extends State<SessionNotesScreen> {
  final TextEditingController _noteController = TextEditingController();

  final List<String> notes = [
    "Patient reported mild chest pain during exercise. Recommended ECG and blood tests.",
    "Blood pressure stable. Continue current medication for another 30 days.",
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void addNote() {
    if (_noteController.text.trim().isEmpty) return;

    setState(() {
      notes.insert(0, _noteController.text.trim());
      _noteController.clear();
    });

    FocusScope.of(context).unfocus(); // Dismiss keyboard smoothly

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Session note added successfully"),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
          "Session Notes",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  /// Input interaction block
                  AddNoteCard(controller: _noteController, onSave: addNote),
                  const SizedBox(height: 25),

                  /// History Header Section Label
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Previous Notes History",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: ThemeConstants.textMainColor, // Linked directly to global layout theme colors
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  /// Clean mapping over historic logs
                  ...notes.map((noteText) {
                    return NoteListItem(
                      noteText: noteText,
                      timeStamp: "Today • 10:30 AM",
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
