

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oqy/features/profile/model/profile_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  ProfileWidget.create();
  }
}


class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  static Widget create(){
    return ChangeNotifierProvider(
      create: (_)=>ProfileModel(),
      child: const ProfileWidget(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch:true,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background:  Container(
                height: 100,
                color: Colors.deepOrange,
              ),
              title: const Text('Mirkinbai Sergey'),

            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.deepPurple,
            )
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child:
                        Text('$index', textScaler: const TextScaler.linear(5)),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}