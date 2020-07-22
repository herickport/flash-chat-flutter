import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/models/user.dart';
import 'package:flutter/services.dart';

class MessageManager {
  final _firestore = Firestore.instance;

  Future<void> sendMessage({User user, String text}) async {
    try {
      await _firestore.collection('messages').add(
        {
          'sender': {'uid': user.id, 'email': user.email},
          'text': text,
          'created_at': FieldValue.serverTimestamp(),
        },
      );
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
