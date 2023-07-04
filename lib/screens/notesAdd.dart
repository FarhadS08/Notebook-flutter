import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notebook/models/notes.dart';
import 'package:notebook/services/firestore.dart';
import 'package:provider/provider.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  NotesModel? notesModel;
  String? title;
  String? note;

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreService>(
      builder: (context, firestore, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: (valueTitle) {
                    title = valueTitle;
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 24),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (valueNote) {
                    note = valueNote;
                  },
                  maxLines: 8,
                  decoration: InputDecoration(
                    labelText: 'Notes',
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 24),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal, // foreground
                    ),
                    onPressed: () {
                      notesModel = NotesModel(
                        title: title!,
                        userId: userId,
                        id: '',
                        isDone: false,
                        note: note!,
                      );
                      firestore.addNotes(userId, notesModel!);
                      Navigator.pop(context);
                    },
                    child: Text('Add Note'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
