import 'package:fire_notes_app/notes/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNoteForm extends StatefulWidget {
  final Map<String, dynamic>? note;
  final String noteId;
  const EditNoteForm({super.key, required this.note, required this.noteId});

  @override
  createState() => _EditNoteFormState();
}

class _EditNoteFormState extends State<EditNoteForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit note"),
        ),
        body: Consumer<NotesProvider>(builder: (context, noteProvider, child) {
          if (noteProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: _titleController
                    ..text = widget.note?["data"]["title"]!,
                  enabled: !noteProvider.editing,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: _descriptionController
                    ..text = widget.note?["data"]["details"]!,
                  enabled: !noteProvider.editing,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        // Save the note
                        Map<String, dynamic> note = widget.note!;
                        note["data"]["title"] = _titleController.text;
                        note["data"]["details"] = _descriptionController.text;
                        await noteProvider
                            .editExistingNote(note, widget.noteId)
                            .then((success) {
                          if (success) {
                            //Show success message
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                content: Text("Note updated"),
                              ));
                            Navigator.of(context).pop();
                          } else {
                            //Show error message
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                content: Text("Error updating note"),
                              ));
                          }
                        });
                      },
                      child: const Text("Save"),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    MaterialButton(
                        color: Colors.red,
                        onPressed: () async {
                          await noteProvider
                              .removeExistingNote(widget.noteId)
                              .then((success) {
                            if (success) {
                              //Show success message
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                  content: Text("Note deleted"),
                                ));
                              Navigator.of(context).pop();
                            } else {
                              //Show error message
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                  content: Text("Error deleting note"),
                                ));
                            }
                          });
                        },
                        child: const Text("Delete")),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
