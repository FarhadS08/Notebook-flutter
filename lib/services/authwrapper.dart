import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notebook/screens/register.dart';
import 'package:notebook/screens/home.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          if(snapshot.data?.uid == null){
            return RegistrationScreen();
          }else{
            return HomePage();
          }
        }
        return const CircularProgressIndicator(color: Colors.teal);
      },
    );
  }
}