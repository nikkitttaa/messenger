import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messanger_test/model/messege.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send messege
  Future<void> sendMessage(String receiverID, String message) async {
    //user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final String currentUsername;

    final userCollection = FirebaseFirestore.instance.collection('users');
    final querySnapshot =
        await userCollection.where('email', isEqualTo: currentUserEmail).get();
    final documents = querySnapshot.docs;

    currentUsername = documents[0].data()['username'];

    final DateTime timestamp = DateTime.now();

    //new messege
    Message newMessege = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      senderUsername: currentUsername,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('message')
        .add(newMessege.toMap());
  }

  //get messege
  Stream<QuerySnapshot> getMessage(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
