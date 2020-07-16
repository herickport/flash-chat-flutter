import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'package:flutter/services.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flash Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(
              builder: (_) => LoginScreen(),
            );
            break;
          case '/register':
            return MaterialPageRoute(
              builder: (_) => RegistrationScreen(),
            );
            break;
          case '/chat':
            return MaterialPageRoute(
              builder: (_) => ChatScreen(),
            );
            break;
          case '/':
          default:
            return MaterialPageRoute(
              builder: (_) => WelcomeScreen(),
            );
            break;
        }
      },
    );
  }
}
