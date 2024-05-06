
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/features/profile/bloc/profile_bloc.dart';
import 'package:oqy/service/profile_service.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _controller; // Используем опциональную переменную для инициализации в initState
  final List<String> _tabs = ["Tab 1", "Tab 2", "Tab 3"]; // Ваши вкладки


  final _profileBloc = ProfileBloc(GetIt.I<ProfileService>());
  @override 
  void initState(){
    super.initState();
    _controller = TabController(length: _tabs.length, vsync: this); // Инициализируем контроллер в initState
    _profileBloc.add(LoadProfile());
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 200.0, // В зависимости от вашего дизайна
                flexibleSpace: FlexibleSpaceBar(
                  title: BlocBuilder<ProfileBloc, ProfileState>(
                  bloc: _profileBloc,
                  builder: (context, state) {
                    if(state is ProfileLoaded){
                      return Text( 
                        '${state.profile.firstname} ${state.profile.lastname}',

                      );
                    }
                    return const Text(
                      'Loading'
                    );
                  },
                ),
                  background: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50.0), // Размер для табов
                  child: Material(
                    color: Colors.white,
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
              return Center(child: Text("Содержимое $tab"));
            }).toList(),
          ),
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
