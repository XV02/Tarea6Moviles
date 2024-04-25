import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes_app/auth/bloc/auth_bloc.dart';
import 'package:fire_notes_app/content/fs_admin_table.dart';
import 'package:fire_notes_app/content/note_container.dart';
import 'package:fire_notes_app/notes/new_note_form.dart';
import 'package:fire_notes_app/notes/notes_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _fabKey = GlobalKey<ExpandableFabState>();
  final _searchController = TextEditingController();
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
      body: Consumer<NotesProvider>(builder: (context, noteProvider, child) {
        return Column(
          children: [
            MaterialButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
              },
              child: const Text("Log out"),
            ),
            // Add a search fieldtext with a button to search
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: "Search",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      noteProvider.search(_searchController.text);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            //Add a button that says ASC by default, and changes color and text to DESC when pressed
            MaterialButton(
              color: (noteProvider.isDesc) ? Colors.blue : Colors.black,
              onPressed: () {
                noteProvider.changeOrder();
              },
              child: Text(
                (noteProvider.isDesc ? "DESC" : "ASC"),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: FirestoreListView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                pageSize: 15,
                query: (noteProvider.searching)
                    ? noteProvider.findNotesByTitle(_searchController.text,
                        FirebaseAuth.instance.currentUser!.uid)
                    : (noteProvider.normalLoad)
                        ? noteProvider
                            .getAllNotes(FirebaseAuth.instance.currentUser!.uid)
                        : noteProvider.getAllNotesOrderBy(
                            FirebaseAuth.instance.currentUser!.uid),
                itemBuilder: (BuildContext context,
                    QueryDocumentSnapshot<Map<String, dynamic>> document) {
                  return NoteContainer(
                      noteContent: document.data(), noteId: document.id);
                },
              ),
            ),
          ],
        );
      }),
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
