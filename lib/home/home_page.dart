import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes_app/content/fs_admin_table.dart';
import 'package:fire_notes_app/content/item_public.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => FsAdminTable(),
                ),
              );
            },
            icon: Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: FirestoreListView(
        padding: EdgeInsets.symmetric(horizontal: 18),
        pageSize: 15,
        query: FirebaseFirestore.instance
            .collection("tweet")
            .where("public", isEqualTo: true),
        itemBuilder: (BuildContext context,
            QueryDocumentSnapshot<Map<String, dynamic>> document) {
          // document = 1 tweet de la collection
          return ItemPublic(publicFData: document.data());
        },
      ),
    );
  }
}
