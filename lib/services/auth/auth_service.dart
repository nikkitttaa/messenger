import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign In
  Future<UserCredential> signInWithEmailAndPawword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
  }

  // Sign Out
  Future<void> signOut() async{
    return await FirebaseAuth.instance.signOut();
  }

  //Sign Up
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } 
    on FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
  }
}
