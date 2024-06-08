import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/features/admin/bloc/admin_bloc.dart';

@RoutePage()
class AdminScreen extends StatefulWidget {
  final Profile profile;
  const AdminScreen({required this.profile, super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(LoadAdminEvent(profile: widget.profile));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin panel', style: theme.textTheme.bodyMedium?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if(state is AdminLoaded){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    for(int i = 0; i<state.users.length; i++) 
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: theme.cardColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: state.users[i].picture!=null ? Image.memory(
                                    Uint8List.fromList(base64.decode('data:image/png;base64,${state.users[i].picture!}')),
                                    fit: BoxFit.cover,
                                  ):const Center(child: Text('No photo')),
                                )
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0, top: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.users[i].firstname!} ${state.users[i].lastname!}', 
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontSize: 16, 
                                          fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 2,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        for(int j = 0; j< state.users[i].roles!.length; j++)
                                          ElevatedButton(
                                            onPressed: (){}, 
                                            child: Text(state.users[i].roles![j].name)
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            );
          }
          return  const CircularProgressIndicator();
        },
      ),
    );
  }
}
