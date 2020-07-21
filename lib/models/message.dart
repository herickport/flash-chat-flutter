import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/models/user.dart';

class Message {
  Message({this.user, this.text});

  Message.fromDocument(DocumentSnapshot document) {
    user = User.fromMap(document.data['sender']);
    text = document.data['text'];
  }

  User user;
  String text;
}
