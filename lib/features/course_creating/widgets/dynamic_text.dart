import 'package:flutter/material.dart';



class DynamicText extends StatelessWidget {
  final String text;
  final int currentLength;
  final int maxLength;


  const DynamicText({required this.text,required this.currentLength, required this.maxLength, super.key});

  @override
  Widget build(BuildContext context) {
    return currentLength > maxLength ?
     Text(
      '${text} ($currentLength/$maxLength)',
      style: TextStyle(color: Colors.red)
    )
    :
     Text(
      '${text} ($currentLength/$maxLength)',
      style: TextStyle(color: Colors.black)
    );
  }
}