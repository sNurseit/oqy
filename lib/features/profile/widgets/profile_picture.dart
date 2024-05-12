import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String? picture;

  const ProfilePictureWidget({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    if(picture == null) {
      return const CircleAvatar(
        radius: 60,
      );
    } else{
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(65)),
        child: Image.memory(
        Uint8List.fromList(base64.decode(picture!.split(",")[1] )), 
          fit: BoxFit.cover, 
          width: 120, 
          height: 120,
        ),
      );
    }
  }
}