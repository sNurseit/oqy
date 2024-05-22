import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/features/profile/bloc/profile_bloc.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/profile_service.dart';
import 'package:oqy/widgets/custom_list_tile.dart';

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
              CustomListTile(
                icon: Icons.edit_outlined, title: 'Change personal data', 
                onTap: ()=> context.read<ProfileBloc>().add(NavigateToSettings(context: context)), 
                trailing: false
              ),
              CustomListTile(
                icon: Icons.question_mark_outlined, title: 'FAQ', 
                onTap: ()=> context.read<ProfileBloc>().add(NavigateToSettings(context: context)), 
                trailing: false
              ),
              CustomListTile(
                icon: Icons.chat_outlined, title: 'Chat with sapport', 
                onTap: ()=> context.read<ProfileBloc>().add(NavigateToSettings(context: context)), 
                trailing: false
              ),
              CustomListTile(
                icon: Icons.exit_to_app_rounded, title: 'Log out', 
                onTap: (){AutoRouter.of(context).replace(const AuthRoute());}, 
                trailing: false
              ),

            ],
          ),
      ),
    );
  }
}