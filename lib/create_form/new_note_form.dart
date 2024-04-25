import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes_app/create_form/notes_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({super.key});

  @override
  createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New note"),
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
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  onPressed: () async {
                    // Save the note
                    Map<String, dynamic> note = {
                      "userId": FirebaseAuth.instance.currentUser!.uid,
                      "color": Colors.green.toString(),
                      "createdAt": Timestamp.fromDate(DateTime.now()),
                      "type": "normal",
                      "data": {
                        "audios": [],
                        "images": [],
                        "title": _titleController.text,
                        "details": _descriptionController.text,
                      }
                    };
                    await noteProvider.createNewNote(note).then((success) {
                      if (success) {
                        //Show success message
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                            content: Text("Note created"),
                          ));
                        Navigator.of(context).pop();
                      } else {
                        //Show error message
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                            content: Text("Error creating note"),
                          ));
                      }
                    });
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          );
        }));
  }
}
