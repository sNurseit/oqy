
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int minLength;
  const ExpandableText({required this.text, required this.minLength, super.key});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded =false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.minLength,
          overflow: TextOverflow.fade,
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14,),
        ),
        SizedBox(height: 5,),
        InkWell(
          splashColor: Colors.transparent, 
          highlightColor: Colors.transparent, 
          onTap: () => setState(() {
            isExpanded = !isExpanded;
          }),
          child: Text(
            isExpanded ? 'Show less' : 'Show more',
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ]
    );
  }
}