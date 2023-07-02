import 'package:flutter/material.dart';
import 'package:notebook/screens/home.dart';
import 'package:notebook/screens/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffF2F2F2),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          primary: Colors.teal,
        ),
      ),
    );
  }
}


