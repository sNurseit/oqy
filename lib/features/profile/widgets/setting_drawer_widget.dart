import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/features/profile/bloc/profile_bloc.dart';
import 'package:oqy/service/profile_service.dart';

class SettingDrawerWidget extends StatelessWidget {
  const SettingDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _profileBloc = ProfileBloc(GetIt.I<ProfileService>());

    final theme = Theme.of(context);
    return  Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        ),
        backgroundColor: theme.cardColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Change personal data'),
              onTap: ()=> _profileBloc.add(NavigateToSettings(context: context, profile: null)),
            ),
            ListTile(
              title: Text('FAQ'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('Chat with support'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () {
              },
            ),
          ],
        ),
    );
  }
}