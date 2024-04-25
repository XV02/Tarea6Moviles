import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes_app/auth/bloc/auth_bloc.dart';
import 'package:fire_notes_app/content/fs_admin_table.dart';
import 'package:fire_notes_app/content/note_container.dart';
import 'package:fire_notes_app/notes/new_note_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class HomePage extends StatelessWidget {
  final _fabKey = GlobalKey<ExpandableFabState>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => FsAdminTable(),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
            },
            child: const Text("Log out"),
          ),
          Expanded(
            child: FirestoreListView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              pageSize: 15,
              query: FirebaseFirestore.instance.collection("notes").where(
                  "userId",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid),
              itemBuilder: (BuildContext context,
                  QueryDocumentSnapshot<Map<String, dynamic>> document) {
                // document = 1 tweet de la collection
                return NoteContainer(
                    noteContent: document.data(), noteId: document.id);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _fabKey,
        // type: ExpandableFabType.up,
        children: [
          FloatingActionButton.small(
            heroTag: null,
            tooltip: "New note",
            child: const Icon(Icons.file_copy),
            onPressed: () {
              _fabKey.currentState?.toggle();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const NewNoteForm()));
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            tooltip: "New folder",
            child: const Icon(Icons.folder),
            onPressed: () {
              _fabKey.currentState?.toggle();
            },
          ),
        ],
      ),
    );
  }
}
