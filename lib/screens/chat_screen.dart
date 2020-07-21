import 'package:flash_chat/models/user.dart';
import 'package:flash_chat/services/message_manager.dart';
import 'package:flash_chat/services/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageTextController = TextEditingController();

  User loggedInUser;

  @override
  void initState() {
    super.initState();

    getUser();
  }

  void getUser() async {
    loggedInUser = await UserManager().getCurrentUser();

    if (loggedInUser != null) {
      print(loggedInUser.id);
    } else {
      print('>> Nenhum usuário logado');
    }
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

              Navigator.of(context).pop();
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
            SizedBox(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await MessageManager().sendMessage(
                        userId: loggedInUser.id,
                        text: _messageTextController.text,
                      );

                      print('>> Mensagem enviada');
                    },
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
