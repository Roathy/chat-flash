import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat-screen';

  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _authService = FirebaseAuth.instance;
  final FirebaseFirestore _storeService = FirebaseFirestore.instance;
  dynamic user;
  String messageText = '';
  final TextEditingController msgCtlr = TextEditingController();

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      user = _authService.currentUser;
      if (user != null) {
        if (user.email != null) {}
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final messages = firestore.collection('messages');

      try {
        QuerySnapshot querySnapshot = await messages.get();
        for (final doc in querySnapshot.docs) {
          print('${doc.id} = ${doc.data()}');
        }
      } catch (e) {
        print('Error fetching collection: $e');
      }
    } catch (e) {
      print('Error getting to database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgCtlr,
                      onChanged: (value) {
                        msgCtlr.text = value;
                        // messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _storeService.collection('messages').add({
                        'text': msgCtlr.text,
                        'sender': user.email
                      });
                      msgCtlr.text = '';
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _storeService.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs;
                  List<Text> messageWidgets = [];
                  for (var message in messages) {
                    final msgText = message.data['text'];
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
