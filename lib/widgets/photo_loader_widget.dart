import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PhotoLoader extends StatefulWidget {
  final Function(String)? onPhotoSelected;
  final List<int>? image;
  final String? defaultPhoto;
  final Widget? child;
  final Widget notSelected;
  const PhotoLoader({Key? key, this.onPhotoSelected, required this.notSelected, this.child, this.image, this.defaultPhoto}) : super(key: key);

  @override
  _PhotoLoaderState createState() => _PhotoLoaderState();
}

class _PhotoLoaderState extends State<PhotoLoader> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _getImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      if (widget.onPhotoSelected != null) {
        String base64Image = base64Encode(_imageFile!.readAsBytesSync());
        widget.onPhotoSelected!(base64Image);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _getImageFromGallery,
      child: _imageFile == null
      ?
      widget.notSelected
      :Image.file(
        _imageFile!,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
