import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = false;
  bool editing = false;
  bool searching = false;
  bool isDesc = true;
  bool normalLoad = true;

  Query<Map<String, dynamic>> getAllNotes(String uid) {
    normalLoad = true;
    return FirebaseFirestore.instance
        .collection("notes")
        .where("userId", isEqualTo: uid);
  }

  Query<Map<String, dynamic>> getAllNotesOrderBy(String uid) {
    return FirebaseFirestore.instance
        .collection("notes")
        .where("userId", isEqualTo: uid)
        .orderBy("data.title", descending: isDesc);
  }

  Future<bool> createNewNote(Map<String, dynamic> noteContent) async {
    try {
      isLoading = true;
      notifyListeners();
      // create note
      FirebaseFirestore.instance.collection("notes").add(noteContent);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      normalLoad = true;
      notifyListeners();
    }
  }

  Future<bool> editExistingNote(
      Map<String, dynamic> newNoteContent, String noteId) async {
    try {
      isLoading = true;
      notifyListeners();
      // create note
      FirebaseFirestore.instance
          .collection("notes")
          .doc(noteId)
          .update(newNoteContent);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      normalLoad = true;
      notifyListeners();
    }
  }

  Future<bool> removeExistingNote(String noteReference) async {
    try {
      isLoading = true;
      notifyListeners();
      // create note
      FirebaseFirestore.instance
          .collection("notes")
          .doc(noteReference)
          .delete();
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      normalLoad = true;
      notifyListeners();
    }
  }

  Query<Map<String, dynamic>> findNotesByTitle(String title, String uid) {
    normalLoad = true;
    return FirebaseFirestore.instance
        .collection("notes")
        .where("data.title", isEqualTo: title)
        .where(
          "userId",
          isEqualTo: uid,
        );
  }

  void search(String search) {
    if (search == "") {
      searching = false;
      normalLoad = true;
      notifyListeners();
      return;
    }
    searching = true;
    notifyListeners();
  }

  void changeOrder() {
    isDesc = !isDesc;
    normalLoad = false;
    notifyListeners();
  }
}
