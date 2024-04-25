// Create a widget that looks like a note
import 'package:flutter/material.dart';

class NoteContainer extends StatelessWidget {
  final Map<String, dynamic> noteContent;

  NoteContainer({
    super.key,
    required this.noteContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(noteContent["data"]["title"]));
  }
}
