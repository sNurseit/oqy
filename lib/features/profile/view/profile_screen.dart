
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/features/profile/bloc/profile_bloc.dart';
import 'package:oqy/service/profile_service.dart';
import 'package:oqy/widgets/error_loading_widget.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _controller; // Используем опциональную переменную для инициализации в initState
  final List<String> _tabs = ["Tab 1", "Tab 2"]; // Ваши вкладки
  final scrollController = ScrollController();


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
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  actions: [
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.share)
                    ),
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.settings)
                    ),
                  ],
                  pinned: true,
                  floating: false,
                  expandedHeight: 270, 
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    expandedTitleScale:1,
                    background: Center(
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        bloc: _profileBloc,
                        builder: (context, state) {
                          if(state is ProfileLoaded){
                            return Column(
                              children: [
                                const SizedBox(height: 40,),
                                CircleAvatar(radius: 60,),
                                const SizedBox(height: 10,),
                                Text( 
                                  '${state.profile.firstname} ${state.profile.lastname}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                
                              ],
                            );
                          }
                          if(state is ProfileLoadingFailure){
                            return ErrorLoadingWidget(
                              onTryAgain: () => _profileBloc.add(LoadProfile()), // Передаем функцию
                            );
                          }
                          return const Text(
                            'Loading'
                          );
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
                              tabs: _tabs
                                  .map((String name) => Tab(text: name))
                                  .toList()),
                        ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: _tabs.map((String tab) {
              return SingleChildScrollView( // Добавлено, чтобы прокручивать содержимое внутри TabBarView
                child: Column(
                  children: [
                    SizedBox(height: 200),
                    Center(child: Text("Содержимое $tab")),
                    SizedBox(height: 200),
                    Center(child: Text("Содержимое $tab")),
                    SizedBox(height: 200),
                    Center(child: Text("Содержимое $tab")),
                    SizedBox(height: 200),
                    Center(child: Text("Содержимое $tab")),
                    SizedBox(height: 200),
                  ],
                ),
              );
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