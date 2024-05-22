import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  final bool trailing;
  
  const CustomListTile({super.key, 
    required this.icon,
    required this.title,
    required this.onTap,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return trailing ? ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14.0),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        onTap();
      },
    ) 
    : ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14.0),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}