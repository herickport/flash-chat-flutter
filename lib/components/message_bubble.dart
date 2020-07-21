import 'package:flash_chat/models/message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({@required this.message, @required this.isLoggedInUser});

  final Message message;
  final bool isLoggedInUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLoggedInUser
          ? const EdgeInsets.fromLTRB(64.0, 0.0, 0.0, 8.0)
          : const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
      child: Column(
        crossAxisAlignment:
            isLoggedInUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.user.email,
            style: TextStyle(fontSize: 12.0),
          ),
          Material(
            color: isLoggedInUser ? Colors.lightBlue : Colors.white,
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
              topLeft: isLoggedInUser
                  ? const Radius.circular(16.0)
                  : const Radius.circular(0),
              topRight: isLoggedInUser
                  ? const Radius.circular(0)
                  : const Radius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isLoggedInUser ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
