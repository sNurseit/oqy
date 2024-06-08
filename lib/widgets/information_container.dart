import 'package:flutter/material.dart';

class InformationContaierWidget extends StatelessWidget {
  final Widget informationWidget;
  final Widget child;
  const InformationContaierWidget({required this.child, super.key, required this.informationWidget});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              informationWidget,
              const SizedBox(height: 10,),
              child,
            ],
          ),
      ),
    );
  }
}