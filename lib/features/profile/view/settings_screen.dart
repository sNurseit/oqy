

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/service/profile_service.dart';

import '../bloc/profile_bloc.dart';


@RoutePage()
class SettingsScreen extends StatefulWidget {
  final Profile? profile;
  const SettingsScreen({super.key, required this.profile});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newRePasswordController = TextEditingController();

  final ProfileBloc _profileBloc = ProfileBloc(GetIt.I<ProfileService>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("old password"),
            TextField(
              controller: oldPasswordController,
            ),
            const Text("new password"),
            TextField(
              controller: newPasswordController,
            ),
            const Text("new password"),
            TextField(
              controller: newRePasswordController,
            ),
          ],
        ),
      ),
    );
  }
}