import 'package:flutter/material.dart';

class StyleText extends StatelessWidget {
  const StyleText(this.text, {super.key}); 
// first text refers to the "text" variable, second refers to th  argumenet passed 

  final String text;

  @override
  Widget build(context) {
    return  Text(
      text,
      style: TextStyle(
        color: Colors.white, 
        fontSize: 29.7),
    );
  }
}
