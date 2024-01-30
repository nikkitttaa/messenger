import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messanger_test/chat/chat_service.dart';
import 'package:messanger_test/components/colors.dart';
import 'package:messanger_test/components/my_icons.dart';
import 'package:messanger_test/components/my_send_text_field.dart';


class ChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String receiverUsername;
  const ChatScreen(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID,
      required this.receiverUsername});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);

      setState(() {
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            //user avatar
            CircleAvatar(
              radius: 25,
              child: Text(
                widget.receiverUsername,
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            //user name and check online/offline
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiverUsername,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),

                Text('Не в сети', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10, color: searchTxtColor))
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  //build messege list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessage(
          widget.receiverUserID, _auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        
        List<DocumentSnapshot> reversedDocs = snapshot.data!.docs.reversed.toList();

        return ListView.builder(
          reverse: true,
          itemCount: reversedDocs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = reversedDocs[index];
            return _buildMessageItem(document);
          },
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    Alignment aligment = (data['senderID'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    Color colorMessege =
        (data['senderID'] == _auth.currentUser!.uid) ? myMessegeColor : otherMessegeColor;
      
    Timestamp firestoreTimestamp = data['timestamp'];
    DateTime dateTime = firestoreTimestamp.toDate();
    String time = DateFormat('HH:mm').format(dateTime);

    return Align(
      alignment: aligment,
      child: Container(
        decoration: BoxDecoration(
            color: colorMessege, borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height / 70),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.7),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Text(
              data['message'],
              softWrap: true,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
    
            const SizedBox(
              width: 7,
            ),
    
            Text(time, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold,),)
          ],
        ),
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          width: 15,
        ),
        MyIcons(icon: Image.asset('assets/icons/attach.png', color: Colors.black,), onTap: (){}),

        //text field
        Expanded(
            child: MySendTextField(
                controller: _messageController,),),

        //send button
        MyIcons(icon:const Icon(Icons.send), onTap: (){
          sendMessage();
        }),
        
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
