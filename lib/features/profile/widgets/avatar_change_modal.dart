import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oqy/features/profile/bloc/profile_bloc.dart';
import 'package:provider/provider.dart';

class AvatarChangeModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final _profileBloc = Provider.of<ProfileBloc>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    final image = await ImagePicker().getImage(source: ImageSource.gallery);
                  },
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.add_a_photo),
                  ),
                ),
                const Spacer(),

              ],
            ),
          ),
        ),
      ]
    );
  }
}