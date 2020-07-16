import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.color, this.onPressed, this.childText});

  final Color color;
  final Function onPressed;
  final String childText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: color,
        elevation: 5.0,
        child: Text(childText),
      ),
    );
  }
}
