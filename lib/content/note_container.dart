// Create a widget that looks like a note
import 'package:fire_notes_app/notes/edit_note_form.dart';
import 'package:flutter/material.dart';

class NoteContainer extends StatelessWidget {
  final Map<String, dynamic> noteContent;
  final String noteId;

  const NoteContainer({
    super.key,
    required this.noteContent,
    required this.noteId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                EditNoteForm(note: noteContent, noteId: noteId)));
      },
      child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(
                    int.parse(noteContent["color"].substring(1), radix: 16)),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(noteContent["data"]["title"])),
    );
  }
}
