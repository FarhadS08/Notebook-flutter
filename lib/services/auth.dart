import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? userModel;

  // Register User
  Future<UserModel?> createAccount(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        userModel = UserModel(
          email: userCredential.user!.email!,
          uid: userCredential.user!.uid,
        );
      }

      await _firestore.collection('users').add({
        'email': userModel?.email,
        'uid': userModel?.uid,
      });

      notifyListeners();
      return userModel;
    } catch (e) {
      throw e;
    }
  }

  // Sign In User
  Future<UserModel?> signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        DocumentSnapshot documentSnapshot = await
            _firestore.collection('users').doc(userCredential.user!.uid).get();

        if(documentSnapshot.exists){
          UserModel(
            email: userCredential.user!.email!,
            uid: userCredential.user!.uid,
          );
        }
      }
      notifyListeners();
      return userModel;
    } catch (e) {
      throw e;
    }
  }

  Future<void> LogOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
