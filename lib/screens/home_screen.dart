import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messanger_test/components/colors.dart';
import 'package:messanger_test/components/my_search_bar.dart';
import 'package:messanger_test/screens/chat_screen.dart';
import 'package:messanger_test/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Чаты',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          actions: [
            //signOut button
            IconButton(
                onPressed: signOut,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
        ),
        body: Column(
          children: [
            const MySearchBar(),
            Flexible(
              child: _buildUserList(),
            )
          ],
        ));
  }

  //Builder user list
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  //Builder user list item
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser?.email != data['email']) {
      return ListTile(
        title: Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height / 70),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: peopleStrike, width: 1),
                    bottom: BorderSide(color: peopleStrike, width: 1))),
            child: Row(
              children: [
                //user avatar
                CircleAvatar(
                  radius: 30,
                  child: Text(
                    data['username'],
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                //user name and last messege
                Column(
                  children: [
                    Text(
                      data['username'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        receiverUserEmail: data['email'],
                        receiverUserID: data['uid'],
                        receiverUsername: data['username'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
