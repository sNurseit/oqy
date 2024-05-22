import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoLoader extends StatefulWidget {
  final Function(String)? onPhotoSelected;
  final List<int>? image;
  final String? defaultPhoto;
  
  const PhotoLoader({Key? key, this.onPhotoSelected, this.image, this.defaultPhoto}) : super(key: key);

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
    return Column(
      children: [
        _imageFile == null
            ? Container(
                width: double.infinity,
              )
            : Image.file(
                _imageFile!,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
        ElevatedButton(
          onPressed: _getImageFromGallery,
          child: Text('Select Photo'),
        ),
      ],
    );
  }
}
