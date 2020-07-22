import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/message_bubble.dart';
import 'package:flash_chat/models/message.dart';
import 'package:flash_chat/models/user.dart';
import 'package:flutter/material.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream({@required this.loggedInUser});

  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('messages')
          .orderBy('created_at', descending: true)
          .snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Message> messages = [];
        for (DocumentSnapshot document in snapshot.data.documents) {
          messages.add(Message.fromDocument(document));
        }

        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.all(8.0),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return MessageBubble(
              message: messages[index],
              isLoggedInUser: loggedInUser.id == messages[index].user.id,
            );
          },
        );
      },
    );
  }
}
