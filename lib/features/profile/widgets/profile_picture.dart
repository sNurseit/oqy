import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  String? picture;

  ProfilePictureWidget({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    if(picture == null) {
      return const CircleAvatar(
        radius: 60,
      );
    } else{
      return CircleAvatar(
        radius: 60,
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