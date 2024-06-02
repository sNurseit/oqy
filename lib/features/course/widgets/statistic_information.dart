import 'package:flutter/material.dart';

class StatisticInformationWidget extends StatelessWidget {
  final String text;
  final String description;
  final IconData icon; // Добавляем поле для иконки
  const StatisticInformationWidget({
    super.key,
    required this.text,
    required this.description,
    required this.icon, // Добавляем параметр для иконки
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 110,
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}