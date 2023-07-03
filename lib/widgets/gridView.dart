import 'package:flutter/material.dart';
import 'package:notebook/models/notes.dart';
import 'package:notebook/services/firestore.dart';
import 'package:provider/provider.dart';

class NotePads extends StatelessWidget {
  final String userId;

  NotePads({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreService>(
      builder: (context, firestore, child) {
        return StreamBuilder<List<NotesModel>>(
          stream: firestore.getNotes(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.teal));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(child: Text('An error occurred'));
            } else {
              List<NotesModel> notesModel = snapshot.data!;
              return GridView.builder(
                itemCount: notesModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            notesModel[index].title,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            notesModel[index].note,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
