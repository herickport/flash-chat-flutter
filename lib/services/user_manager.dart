import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/models/user.dart';
import 'package:flutter/services.dart';

class UserManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(User user) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final FirebaseUser newUser = result.user;

      if (newUser != null) {}
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<User> getCurrentUser() async {
    User currentUser;
    try {
      FirebaseUser user = await _auth.currentUser();

      if (user != null) {
        currentUser = User(email: user.email);
      }

      return currentUser;
    } on PlatformException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
