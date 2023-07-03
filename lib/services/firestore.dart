import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notebook/models/notes.dart';

class FirestoreService extends ChangeNotifier {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update note
  Future<void> updateTodo(String userId, String id, String text) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todos')
          .doc(id)
          .update({'text': text});
      print('Todo updated successfully');
      notifyListeners();
    } catch (e) {
      print('Error adding todo: $e');
      throw e;
    }
  }

  // Add note
  Future<void> addNotes(String userId, NotesModel notesModel) async {
    try {
      await _firestore.collection('users')
          .doc(userId)
          .collection('notes')
          .add(notesModel.toMap());
      notifyListeners();
    }catch(e){
      throw e;
    }
  }

  // Get note
  Stream<List<NotesModel>> getNotes(String userId) {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todos')
          .snapshots()
          .map((QuerySnapshot snapshot) =>
          snapshot.docs.map((doc) => NotesModel.fromDocument(doc)).toList());
    } catch (e) {
      print('Error getting todos: $e');
      throw e;
    }
  }

  // Remove note
  Future<void> removeTodo(String userId, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todos')
          .doc(id)
          .delete();
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }


}