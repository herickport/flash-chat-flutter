import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class MessageManager {
  final _firestore = Firestore.instance;

  Future<void> sendMessage({String userId, String text}) async {
    try {
      await _firestore.collection('messages').add(
        {'sender': userId, 'text': text},
      );
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
