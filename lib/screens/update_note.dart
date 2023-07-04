import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/firestore.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen(
      {super.key,
      required this.usedId,
      required this.id,
      required this.note,
      required this.title});

  final String usedId;
  final String id;
  final String note;
  final String title;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _titleController =
      TextEditingController(text: widget.title);

  late TextEditingController _noteController = TextEditingController(text: widget.note);
  String? newTitle;
  String? newNote;

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
                  controller: _titleController,
                  onChanged: (valueTitle) {
                    newTitle = valueTitle;
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
                  controller: _noteController,
                  onChanged: (valueNote) {
                    newNote = valueNote;
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
                      firestore.updateNotes(
                        widget.usedId,
                        widget.id,
                        newTitle!,
                        newNote!,
                      );
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
