import 'package:flutter/material.dart';
import 'package:notebook/models/notes.dart';
import 'package:notebook/screens/update_note.dart';
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
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    notesModel[index].title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    firestore.removeNotes(
                                        userId, notesModel[index].id);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: Colors.grey.shade500,
                                          size: 20.0,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                notesModel[index].note,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateScreen(
                                      usedId: userId,
                                      id: notesModel[index].id,
                                      note: notesModel[index].note,
                                      title: notesModel[index].title,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.edit, color: Colors.teal),
                              ),
                            ),
                          ],
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
