import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = false;
  Future<void> getAllNotes() async {}
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
      notifyListeners();
    }
  }

  Future<bool> editExistingNote(
      String noteReference, Map<String, dynamic> newNoteContent) async {
    try {
      isLoading = true;
      notifyListeners();
      // create note
      FirebaseFirestore.instance
          .collection("notes")
          .doc(noteReference)
          .update(newNoteContent);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
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
      notifyListeners();
    }
  }
}
