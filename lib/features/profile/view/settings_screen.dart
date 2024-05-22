

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/domain/entity/answer.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/features/profile/widgets/avatar_change_modal.dart';
import 'package:oqy/widgets/custom_list_tile.dart';
import 'package:oqy/service/profile_service.dart';

import '../bloc/profile_bloc.dart';


@RoutePage()
class SettingsScreen extends StatelessWidget {
  final Profile? profile;
  SettingsScreen({super.key, required this.profile});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newRePasswordController = TextEditingController();
  final ProfileBloc _profileBloc = ProfileBloc(GetIt.I<ProfileService>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0), 
                  child: Text(
                    "General settings",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: CustomListTile(
                          icon: Icons.person,
                          title: 'Change avatar',
                          trailing: false,
                          onTap:  () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => AvatarChangeModal(),
                            );
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300], 
                        thickness: 1.0, 
                        height: 0,
                      ),
                      Container(
                        color: Colors.white, 
                        child: CustomListTile(
                          icon: Icons.person_outline,
                          title: 'Change personal info',
                          trailing: false,
                          onTap: () {
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300], 
                        thickness: 1.0, 
                        height: 0,
                      ),
                      Container(
                        color: Colors.white, 
                        child: CustomListTile(
                          icon: Icons.shopping_basket_outlined,
                          title: 'My enrollment',
                          trailing: false,
                          onTap: () {
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0), 
                  child: Text(
                    "Security settings",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: CustomListTile(
                          icon: Icons.email_outlined,
                          title: 'Change email',
                          trailing: false,
                          onTap: () {
                            
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300], 
                        thickness: 1.0, 
                        height: 0, 
                      ),
                      Container(
                        color: Colors.white, 
                        child: CustomListTile(
                          icon: Icons.lock_outline,
                          title: 'Change password',
                          trailing: false,
                          onTap: () {
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0), 
                  child: Text(
                    "System settings",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: CustomListTile(
                          icon: Icons.language,
                          title: 'Change language',
                          trailing: false,
                          onTap: () {
                            
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300], 
                        thickness: 1.0, 
                        height: 0, 
                      ),
                      Container(
                        color: Colors.white, 
                        child: CustomListTile(
                          icon: Icons.brightness_2,
                          title: 'Change theme',
                          trailing: false,
                          onTap: () {
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


