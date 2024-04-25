import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes_app/create_form/notes_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatefulWidget {
  NewNoteForm({super.key});

  @override
  _NewNoteFormState createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New note"),
        ),
        body: Consumer<NotesProvider>(builder: (context, noteProvider, child) {
          if (noteProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  onPressed: () async {
                    // Save the note
                    Map<String, dynamic> note = {
                      "userId": FirebaseAuth.instance.currentUser!.uid,
                      "color": "${Colors.green.toString()}",
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
                          ..showSnackBar(SnackBar(
                            content: Text("Note created"),
                          ));
                        Navigator.of(context).pop();
                      } else {
                        //Show error message
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text("Error creating note"),
                          ));
                      }
                    });
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          );
        }));
  }
}
