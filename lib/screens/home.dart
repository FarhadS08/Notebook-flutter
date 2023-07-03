import 'package:flutter/material.dart';
import 'package:notebook/services/firestore.dart';
import 'package:notebook/widgets/gridView.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  final String userId;

  HomePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreService>(
        builder: (context, firestore, child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text('Notebook'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: NotePads(userId: userId),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,
              child: Icon(Icons.add),
              onPressed: () {

              },
            ),
          );
        }
    );
  }
}
