import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/models/user.dart';
import 'package:flash_chat/services/user_manager.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 150.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(height: 48.0),
              TextField(
                controller: _emailController,
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Enter your password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 24.0),
              Hero(
                tag: 'login',
                child: RoundedButton(
                  title: 'Log In',
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    User user = User(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    await UserManager().signIn(user);

                    Navigator.of(context).pushReplacementNamed('/chat');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
