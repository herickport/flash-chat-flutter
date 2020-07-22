import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/models/user.dart';
import 'package:flash_chat/utils/firebase_errors.dart';
import 'package:flutter/services.dart';

class UserManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;

  Future<void> signUp({User user, Function onSuccess, Function onFail}) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      if (result.user != null) {
        loggedInUser = await getCurrentUser();
        onSuccess(loggedInUser);
      }
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  }

  Future<void> signIn({User user, Function onSuccess, Function onFail}) async {
    try {
      final AuthResult result = await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      if (result.user != null) {
        loggedInUser = await getCurrentUser();
        onSuccess(loggedInUser);
      }
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  }

  Future<User> getCurrentUser() async {
    User currentUser;
    try {
      FirebaseUser user = await _auth.currentUser();

      if (user != null) {
        currentUser = User(id: user.uid, email: user.email);
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
