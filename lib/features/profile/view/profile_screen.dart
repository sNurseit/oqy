import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/features/profile/bloc/profile_bloc.dart';
import 'package:oqy/features/profile/widgets/profile_picture.dart';
import 'package:oqy/features/profile/widgets/setting_drawer_widget.dart';
import 'package:oqy/service/profile_service.dart';
import 'package:oqy/widgets/error_loading_widget.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  final List<String> _tabs = ["Tab 1", "Tab 2"];
  final scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _tabs.length, vsync: this);
    final profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    profileBloc.add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {

    final _profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    return Scaffold(
      endDrawer: const SettingDrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _profileBloc.add(LoadProfile(completer:completer));
          return completer.future;
        },
        child: Stack(
          children: <Widget>[
            ListView(),
            DefaultTabController(
              length: _tabs.length,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      sliver: SliverAppBar(
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: IconButton(
                              onPressed: ()=> Scaffold.of(context).openEndDrawer(), 
                              icon: const Icon(Icons.settings),
                            )
                          ),
                        ],
                        pinned: true,
                        floating: false,
                        expandedHeight: 300,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          expandedTitleScale: 1,
                          background: Center(
                            child: BlocBuilder<ProfileBloc, ProfileState>(
                              bloc: _profileBloc,
                              builder: (context, state) {
                                if (state is ProfileLoaded) {
                                  return Column(
                                    children: [
                                      const SizedBox(height: 80),
                                      ProfilePictureWidget(picture: state.profile.picture),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${state.profile.firstname} ${state.profile.lastname}',
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  );
                                }
                                if (state is ProfileLoadingFailure) {
                                  return ErrorLoadingWidget(
                                    onTryAgain: () => _profileBloc.add(LoadProfile()),
                                  );
                                }
                                return const Text('Loading');
                              },
                            ),
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(0),
                          child: TabBar(
                            controller: _controller,
                            labelColor: Colors.black,
                            indicatorColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _controller,
                  children: _tabs.map((String tab) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 200),
                          Center(child: Text("Содержимое $tab")),
                          const SizedBox(height: 200),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}