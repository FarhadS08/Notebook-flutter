import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String title;
  final String note;
  final String id;
  final String userId;
  final bool isDone;

  NotesModel(
      {
        required this.title,
        required this.userId,
        required this.id,
        required this.isDone,
        required this.note
      });


    Map<String, dynamic> toMap(){
      return {
        'title': title,
        'note': note,
        'userId':userId,
        'isDone': isDone,
      };
    }

    factory NotesModel.fromDocument(DocumentSnapshot doc){
      try{
        var data = doc.data() as Map;
        return NotesModel(
          id: doc.id,
          title: data['title'] ?? '',
          note: data['note'] ?? '',
          userId: data['userId'] ?? '',
          isDone: data['isDone'] ?? false,
        );
      }catch(e){
        print('Error creating TodoModel from Document: $e');
        throw e;
      }
    }

}
