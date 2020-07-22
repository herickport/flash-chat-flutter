import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/models/user.dart';
import 'package:flash_chat/services/user_manager.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    animation = ColorTween(
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: FutureBuilder<User>(
        future: UserManager().getCurrentUser(),
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).popAndPushNamed(
                    '/chat',
                    arguments: snapshot.data,
                  );
                });
              } else if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Hero(
                            tag: 'logo',
                            child: Container(
                              child: Image.asset('images/logo.png'),
                              height: 60.0,
                            ),
                          ),
                          TypewriterAnimatedTextKit(
                            speed: Duration(milliseconds: 300),
                            repeatForever: true,
                            text: ['Flash Chat'],
                            textStyle: TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 48.0),
                      Hero(
                        tag: 'login',
                        child: RoundedButton(
                          title: 'Log In',
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed('/login');
                          },
                        ),
                      ),
                      Hero(
                        tag: 'register',
                        child: RoundedButton(
                          title: 'Register',
                          color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed('/register');
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.none:
            default:
              return Container();
              break;
          }
        },
      ),
    );
  }
}
