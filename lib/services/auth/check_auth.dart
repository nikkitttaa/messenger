import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messanger_test/screens/home_screen.dart';
import 'package:messanger_test/services/auth/landing.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //user loggin
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        // user not loggin
        else {
          return const Landing();
        }
      },
    ));
  }
}
