import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/models/user.dart';
import 'package:flash_chat/services/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
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
                tag: 'register',
                child: RoundedButton(
                  title: 'Register',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    User user = User(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    setState(() {
                      showSpinner = true;
                    });
                    await UserManager().signUp(
                      user: user,
                      onSuccess: () {
                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.of(context).pushReplacementNamed('/chat');
                      },
                      onFail: (error) {
                        setState(() {
                          showSpinner = false;
                        });
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Error ao registrar: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: error),
                                ],
                              ),
                            ),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      },
                    );
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
