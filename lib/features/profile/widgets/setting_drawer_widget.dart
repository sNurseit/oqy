import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/features/profile/bloc/profile_bloc.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/profile_service.dart';

class SettingDrawerWidget extends StatelessWidget {

  const SettingDrawerWidget({
    Key? key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return  BlocProvider(
      create: (context) => ProfileBloc(GetIt.I<ProfileService>()),
      child: Drawer(
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
                onTap: ()=> context.read<ProfileBloc>().add(NavigateToSettings(context: context)),
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
                  AutoRouter.of(context).replace(const AuthRoute());
                },
              ),
            ],
          ),
      ),
    );
  }
}