import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unishare/app/modules/chat/messages.dart';

import '../homescreen/home_screen.dart';

class ChatRoom extends StatefulWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  ChatRoom({Key? key, FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: const Text('Chat Room'),
      ),
      body: _buildUserList(),
    );
  }

  //build user list except for the current login user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.firebaseFirestore.collection('users').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map<Widget>((docs) => _buildUserItem(docs)).toList(),
          );
        }));
  }

  //build user item
  Widget _buildUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    if (data['uid'] != widget.firebaseAuth.currentUser!.uid) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: ListTile(
          title: Text(document['displayName']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverUserName: document['displayName'],
                  receiverId: document.id,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}