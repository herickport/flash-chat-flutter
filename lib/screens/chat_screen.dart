import 'package:flash_chat/components/messages_stream.dart';
import 'package:flash_chat/models/user.dart';
import 'package:flash_chat/services/message_manager.dart';
import 'package:flash_chat/services/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({this.currentUser});

  final User currentUser;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageTextController = TextEditingController();

  User loggedInUser;

  String messageText = '';

  @override
  void initState() {
    super.initState();

    loggedInUser = widget.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () async {
              await UserManager().signOut();

              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
        title: Text('⚡️Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: MessagesStream(loggedInUser: loggedInUser),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      decoration: kMessageTextFieldDecoration,
                      onChanged: (value) {
                        setState(() {
                          messageText = value;
                        });
                      },
                    ),
                  ),
                  FlatButton(
                    onPressed: messageText.isNotEmpty
                        ? () async {
                            _messageTextController.clear();

                            await MessageManager().sendMessage(
                              user: loggedInUser,
                              text: messageText,
                            );

                            setState(() {
                              messageText = '';
                            });
                          }
                        : null,
                    disabledTextColor: Colors.black54,
                    textColor: Colors.lightBlueAccent,
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
