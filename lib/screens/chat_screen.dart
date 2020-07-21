import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/models/message.dart';
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
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('messages').snapshots(),
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
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Text(
                      '${messages[index].text} from ${messages[index].user.email}',
                      style: TextStyle(
                        color: loggedInUser.id == messages[index].user.id
                            ? Colors.blue
                            : Colors.red,
                      ),
                    );
                  },
                );
              },
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
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await MessageManager().sendMessage(
                        user: loggedInUser,
                        text: _messageTextController.text,
                      );

                      _messageTextController.clear();
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
