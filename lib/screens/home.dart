import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notebook/screens/notesAdd.dart';
import 'package:notebook/services/firestore.dart';
import 'package:notebook/widgets/gridView.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String userId;
  final String? _userEmail = FirebaseAuth.instance.currentUser?.email;

  HomePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreService>(builder: (context, firestore, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: false,
          title: Text(_userEmail.toString().split("@")[0] + "'s notebook"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.logout_rounded, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: NotePads(userId: userId),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotes()));
          },
        ),
      );
    });
  }
}
